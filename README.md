# minedmap-docker
Dockerized Minedmap (https://github.com/NeoRaider/MinedMap) with a bundled caddy webserver.

Needs 2 mounted volumes:
- /savegame (your minecraft save game folder)
- /mapdata (folder where the map data should be stored)

Webserver runs on port 80