#!/bin/bash

SAVEGAME_DIR=/savegame
VIEWER_DIR=/home/minecraft/minedmap-source/viewer
MAPDATA_DIR=${VIEWER_DIR}/data

if [ ! -d "${SAVEGAME_DIR}" ]; then
	echo "No savegame found at ${SAVEGAME_DIR}, exiting." 
	exit 1
fi

#symlink mapdata dir
echo "symlinking map data directory..."
ln -s /mapdata ${MAPDATA_DIR}

#initial render
sh /rendermap.sh

echo "Starting cron"
cron
echo "cron started"

echo "Starting webserver..."
caddy file-server --root "${VIEWER_DIR}" --listen 0.0.0.0:80 