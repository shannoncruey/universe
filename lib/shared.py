"""
Shared globals.
"""
import json
import decimal
from bson.objectid import ObjectId

from pymongo import MongoClient

MONGOSERVER = "127.0.0.1"
MONGOPORT = 27017
MONGODB = "universe"


class log():
    """
    The (to be expanded) central logging function.
    """
    @staticmethod
    def debug(msg):
        print("DEBUG: %s" % (msg))
    
    @staticmethod
    def info(msg):
        print("INFO: %s" % (msg))
    
    @staticmethod
    def warning(msg):
        print("WARNING: %s" % (msg))
    
    @staticmethod
    def error(msg):
        print("ERROR: %s" % (msg))
        
        
def uuid():
    return str(uuid.uuid4())


def tojson(dict_obj):
    def _serializer(obj):
        # decimals
        if isinstance(obj, decimal.Decimal):
            return float(obj)
    
        # Mongo results will often have the ObjectId type
        if isinstance(obj, ObjectId):
            return str(obj)
    
        # date time
        if hasattr(obj, 'isoformat'):
            return obj.isoformat()
        else:
            return str(obj)
    
        raise TypeError("Object of type %s with value of %s is not JSON serializable" % (type(obj), repr(obj)))

    return json.dumps(dict_obj, default=_serializer, indent=4, sort_keys=True, separators=(',', ': '))


conn = MongoClient(host=MONGOSERVER, port=MONGOPORT)
DB = conn[MONGODB]
