# universe

initial proof testing


in a python shell

from universe.player import Player
me = Player('playername')

# to see location
me.whereami()

# to move
me.moveto(oid=<oid of an object> OR pos=(x,y,z))

# to scan
me.scan()

# to read the sensor logs of previous scane
me.getlogs()
