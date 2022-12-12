FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install git gcc clang clang-tools cmake pkg-config zlib1g-dev libpng-dev 

# RUN snap install cmake --classic
# RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.2/cmake-3.20.2.tar.gz
# RUN tar -zxvf cmake-3.20.2.tar.gz
# RUN cd cmake-3.20.2
# RUN ./bootstrap
# RUN make 
# RUN sudo make install 

RUN git clone https://github.com/NeoRaider/MinedMap.git

RUN mkdir MinedMap-build
RUN cd MinedMap-build
RUN cmake ../MinedMap -DCMAKE_BUILD_TYPE=RELEASE
RUN make
RUN ./src/MinedMap /path/to/save/game /path/to/viewer/data


# RUN mkdir /tmp/minedmap
# WORKDIR /tmp/minedmap
# RUN git clone https://github.com/NeoRaider/MinedMap.git .
# RUN git checkout main
# RUN python2 setup.py build
# RUN wget https://launcher.mojang.com/mc/game/1.13.1/client/8de235e5ec3a7fce168056ea395d21cbdec18d7c/client.jar
# RUN mkdir /tmp/world
# RUN mkdir /tmp/export
# RUN mkdir /tmp/config
# RUN useradd -ms /bin/bash bob
# USER bob
# ENTRYPOINT ["/bin/bash", "-c","/tmp/overviewer/overviewer.py --config=/tmp/config/config.py"]