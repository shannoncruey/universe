import shared
from bson import ObjectId
import common


class Player():
    def __init__(self, _name):
        """
        Get a player for the given _id.
        """
        self.doc = shared.DB.people.find_one({"name": _name})
        self._id = str(self.doc["_id"])
        self.name = _name
        self.pos = (self.doc["x"], self.doc["y"], self.doc["z"])
    
    def whereami(self):
        shared.log.info("X: %s, Y: %s, Z: %s" % (self.pos[0], self.pos[1], self.pos[2]))

    def getlogs(self):
        cur = shared.DB.sensorlogs.find({"player_id": self._id}).sort("_id", -1)
        return list(cur) if cur else []

    def moveto(self, oid=None, pos=None):
        """
        moves the player 
        ship will simply be a property of the player...
        it's actually the player that moves.
        
        can go to an object or explicit position
        if you select to go to a 'mobile' object from your log, 
        it'll take you to the last known location.
        """
        
        # the gravity drive doesn't actually traverse space
        # it folds space and instantly appears in the destination
        # however, since you're folding space-time, there's a
        # known time cost for jumping.

        # at the moment the time cost is free = instant
        if oid:
            obj = shared.DB.objects.find_one({"_id": ObjectId(oid)})
            shared.DB.player.update({"_id": ObjectId(self._id)},
                                    {"$set": {
                                     "x": obj["x"],
                                     "y": obj["y"],
                                     "z": obj["z"],
                                    }})
            self.pos = (obj["x"], obj["y"], obj["z"])
        if pos:
            shared.DB.people.update({"_id": ObjectId(self._id)},
                                    {"$set": {
                                     "x": pos[0],
                                     "y": pos[1],
                                     "z": pos[2],
                                    }})
            self.pos = (pos[0], pos[1], pos[2])

    def scan(self, range=None):
        """
        # find objects near me
        # (should be a function of a ship not a player)
        
        range is a property of the player (based on the property
         that is the capability of his scanners, which are technically
         a feature of the ship.)
        
        minimum default range for stars is really high
        to detect a planet you must be within one BASEUNIT
        to detect a moon you must be within 300 of a planet
        """
        global BASEUNIT

        hits = []
        
        def _scanrange(range, _type):
            xmin = self.pos[0] - range
            xmax = self.pos[0] + range
            ymin = self.pos[1] - range
            ymax = self.pos[1] + range
            zmin = self.pos[2] - range
            zmax = self.pos[2] + range
            
            cur = shared.DB.objects.find({
                                          "type": _type,
                                          "x": {"$gt": xmin, "$lt": xmax },
                                          "y": {"$gt": ymin, "$lt": ymax },
                                          "z": {"$gt": zmin, "$lt": zmax },
                                         })
            if cur:
                hits.extend(list(cur))

        # stars
        _scanrange(2000 * common.BASEUNIT, "star")
        # planets n stuff
        _scanrange(common.BASEUNIT, "planet")
        # moons gotta be real close
        _scanrange(common.SYSTEM, "moon")

        shared.log.info(len(hits))

        # log all the hits in your sensor log
        for h in hits:
            log = {
                   "player_id": self._id,
                   "oid": str(h["_id"]),
                   "type": h["type"]
                  }
            if h.get("mobile") == True:
                log["x"] = h["x"]
                log["y"] = h["y"]
                log["z"] = h["z"]

            q = {
                 "player_id": self._id,
                 "oid": str(h["_id"])
                 }
            shared.DB.sensorlogs.update(q, log, upsert=True)

    @staticmethod
    def new(_name):
        """
        Create a new player
        """
        p = {
             "name": _name,
             "x": 0,
             "y": 0,
             "z": 0
            }

        _id = shared.DB.people.insert(p)
        return Player(_name)
