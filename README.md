# minedmap-docker
 
docker run
  -d
  --name='jackett'
  --net='bridge'
  -e TZ="Europe/Berlin"
  -e HOST_OS="Unraid"
  -e HOST_HOSTNAME="bigboi"
  -e HOST_CONTAINERNAME="jackett"
  -e 'AUTO_UPDATE'='true'
  -e 'RUN_OPTS'='run options here'
  -e 'PUID'='99'
  -e 'PGID'='100'
  -e 'UMASK'='022'
  -l net.unraid.docker.managed=dockerman
  -l net.unraid.docker.webui='http://[IP]:[PORT:9117]'
  -l net.unraid.docker.icon='https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/jackett-logo.png'
  -p '9117:9117/tcp'
  -v '/mnt/user/media/downloads/torrents/':'/downloads':'rw'
  -v '/mnt/user/appdata/jackett':'/config':'rw' 'lscr.io/linuxserver/jackett'

9e4c23e518c66bd411f7b87840ae23dba973d765271aae937fbdb0b321db205e



docker run --rm -v '/home/lukas/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances/1.19.3/.minecraft/saves/TEST':'/save':'rw' -v '/home/lukas/Downloads/minedmap':'/map':'rw' minedmap:latest

docker run -it minedmap:latest /bin/bash

sudo docker run --rm -p 80:80 -v'/home/lukas/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances/1.19.3/.minecraft/saves/TEST':'/save':'r' -v '/home/lukas/Downloads/minedmap':'/map':'rw' minedmap:latest
