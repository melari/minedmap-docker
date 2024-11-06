FROM ubuntu:latest
ARG MINEDMAP_VERSION=2.2.0

WORKDIR /home/minecraft
RUN adduser --disabled-password --uid 1000 minecraft

RUN apt-get -y update
RUN apt-get -y install git gcc clang clang-tools cmake pkg-config zlib1g-dev libpng-dev cron curl
RUN git clone --depth 1 --branch v${MINEDMAP_VERSION} https://github.com/NeoRaider/MinedMap.git /home/minecraft/minedmap-source

#install caddy
RUN apt install -y debian-keyring debian-archive-keyring apt-transport-https -y
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt-get update
RUN apt-get install caddy -y

# Compile MinedMap
WORKDIR /home/minecraft/minedmap-build
RUN cmake ../minedmap-source -DCMAKE_BUILD_TYPE=RELEASE
RUN make
RUN mv /home/minecraft/minedmap-build/src/MinedMap /usr/local/bin

#set up cron
RUN echo "*/5 * * * * /rendermap.sh > /proc/1/fd/1 2>&1" >> /etc/cron.d/rendermap-cron \
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
