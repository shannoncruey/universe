
# TODO: at the moment this is all hardcoded to a single player
PLAYER = "shannon"

import os
import sys
import json
import shelve
import re
import web
from web.wsgiserver import CherryPyWSGIServer

base_path = os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0])))
lib_path = os.path.join(base_path, "lib")
sys.path.insert(0, lib_path)

import shared
import player

web_root = os.path.join(base_path, "ui")
os.chdir(web_root)

urls = (
    '/', 'index',
    '/api/sensorlogs', 'sensorlogs',
)
app = web.application(urls, globals())
render = web.template.render('templates/')

class index:        
    def GET(self):
        return render.index()

class sensorlogs:        
    def GET(self):
        p = player.Player(PLAYER)
        logs = p.getlogs()
        web.header('Content-Type', 'application/json')
        return shared.tojson(logs)


def main():
    sys.argv.append("8088")
    app.run()