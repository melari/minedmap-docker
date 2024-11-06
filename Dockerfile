FROM ubuntu:latest
ARG MINEDMAP_VERSION=2.2.0

WORKDIR /home/minecraft
RUN useradd -m -u 1001 -s /bin/bash minecraft

RUN apt-get -y update
RUN apt-get -y install git unzip cron curl
RUN git clone --depth 1 --branch v${MINEDMAP_VERSION} https://github.com/NeoRaider/MinedMap.git /home/minecraft/minedmap-source

#install caddy
RUN apt install -y debian-keyring debian-archive-keyring apt-transport-https -y
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt-get update
RUN apt-get install caddy -y

#grab MinedMap
RUN curl -L -o MinedMap.zip "https://github.com/neocturne/MinedMap/releases/download/v${MINEDMAP_VERSION}/MinedMap-${MINEDMAP_VERSION}-x86_64-unknown-linux-gnu.zip" && \
    unzip MinedMap.zip && \
    rm MinedMap.zip
RUN mv "MinedMap-${MINEDMAP_VERSION}-x86_64-unknown-linux-gnu/minedmap" minedmap
RUN chmod +x minedmap

#set up cron
RUN echo "0 * * * * /rendermap.sh > /proc/1/fd/1 2>&1" >> /etc/cron.d/rendermap-cron \
    # Give the necessary rights to the user to run the cron
    && crontab -u minecraft /etc/cron.d/rendermap-cron \
    && chmod u+s /usr/sbin/cron

COPY  --chown=minecraft:minecraft entrypoint.sh /entrypoint.sh
COPY  --chown=minecraft:minecraft rendermap.sh /rendermap.sh
RUN chmod 777 /rendermap.sh

WORKDIR /home/minecraft
RUN chown -R minecraft:minecraft /home/minecraft

USER minecraft

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
