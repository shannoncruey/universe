import random
import shared
from bson import ObjectId

"""
coordinate system is based on light minutes

So, for a real world example, proxima centauri is 4.3ly away,

4.3*365*24*60 = 2,260,080 lm

"""

# 1 - the base unit of distance
BASEUNIT = 525600
# VOID - multiplier to create 'padding' between stars
VOID = 9999
# SYSTEM - maximum distance of a planet from it's star
SYSTEM = 300

def create_stars():
    """
    Will speak stars into existence.
    """
    shared.log.info("Generating the galaxy...")
    
    i = 0
    space = VOID * BASEUNIT
    
    while i < 500:
        x = int(random.uniform(-space, space))
        y = int(random.uniform(-space, space))
        z = int(random.uniform(-space, space))
        
        star = {
                "type": "star", 
                "x": x,
                "y": y,
                "z": z
                }
        star_id = shared.DB.objects.insert(star)
        i += 1
        
        # planets will be between 10 and 300 light minutes of a star
        # 0-10 planets will be created
        numplanets = random.uniform(0, 10)
        p = 0
        while p < numplanets:
            px = x + int(random.uniform(10, SYSTEM))
            py = y + int(random.uniform(10, SYSTEM))
            pz = z + int(random.uniform(10, SYSTEM))
            planet = {
                    "type": "planet", 
                    "star_id": str(star_id), 
                    "x": px,
                    "y": py,
                    "z": pz
                    }
            planet_id = shared.DB.objects.insert(planet)
            p += 1

            # moons are very close to a planet
            # 0-5 moons will be created
            nummoons = random.uniform(0, 5)
            m = 0
            while m < nummoons:
                mx = px + int(random.uniform(1, 5))
                my = py + int(random.uniform(1, 5))
                mz = pz + int(random.uniform(1, 5))
                moon = {
                        "type": "moon", 
                        "planet_id": str(planet_id), 
                        "x": mx,
                        "y": my,
                        "z": mz
                        }
                shared.DB.objects.insert(moon)
                m += 1


def purge():
    # whack stuff
    shared.DB.objects.remove()
    shared.DB.sensorlogs.remove()
    