FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install git gcc clang clang-tools cmake pkg-config zlib1g-dev libpng-dev nginx cron
RUN git clone https://github.com/NeoRaider/MinedMap.git
RUN mkdir MinedMap-build
RUN cd MinedMap-build
RUN cmake ../MinedMap -DCMAKE_BUILD_TYPE=RELEASE
RUN make
RUN cp /src/MinedMap /usr/local/bin
RUN mkdir /MinedMap/viewer/data
COPY entrypoint.sh /entrypoint.sh
COPY rendermap.sh /rendermap.sh

COPY default /etc/nginx/sites-available/default
EXPOSE 80/tcp

# RUN MinedMap /save /MinedMap/viewer/data
# CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]


# RUN ./src/MinedMap /path/to/save/game /path/to/viewer/data
# CMD ["/src/MinedMap","/save","/MinedMap/viewer/data"]
