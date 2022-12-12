FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install git gcc clang clang-tools cmake pkg-config zlib1g-dev libpng-dev 
RUN git clone https://github.com/NeoRaider/MinedMap.git
RUN mkdir MinedMap-build
RUN cd MinedMap-build
RUN cmake ../MinedMap -DCMAKE_BUILD_TYPE=RELEASE
RUN make
RUN ./src/MinedMap /path/to/save/game /path/to/viewer/data

