FROM  ubuntu:18.04 as build

# Download packages
RUN apt-get -y update && apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev libgmp-dev software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin && apt-get -y update && apt-get -y install libdb4.8-dev libdb4.8++-dev libzmq3-dev libprotobuf-dev protobuf-compiler

# Download HTMLCoin Source Code
RUN git clone -b "v2.5.0" https://github.com/HTMLCOIN/HTMLCOIN --recursive

# Make the binaries
WORKDIR HTMLCOIN
RUN git submodule update --init --recursive
RUN ./autogen.sh && ./configure  --enable-bitcore-rpc --without-gui --enable-tests=no && make -j2
RUN cp -rp src/htmlcoind /bin/htmlcoind && cp -rp src/htmlcoin-tx /bin/htmlcoin-tx && cp -rp src/htmlcoin-cli /bin/htmlcoin-cli

# Place blockchain data in /htmlcoin-data folder and clean up for docker smaller size
ENV HTML_DATA /data
RUN mkdir $HTML_DATA && ln -sfn $HTML_DATA /root/.htmlcoin && rm -r /HTMLCOIN && apt autoremove --purge && rm -rf /var/lib/apt/lists/* 
VOLUME /data

COPY htmlcoin.conf /root/.htmlcoin/htmlcoin.conf

LABEL version="2.5"
 
EXPOSE 14889

ENTRYPOINT ["/bin/htmlcoind"]
CMD ["--logevents"]