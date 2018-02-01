FROM ubuntu:16.04

RUN apt update \
    && apt install -y build-essential pkg-config \
    libc6-dev m4 g++-multilib autoconf libtool \
    ncurses-dev unzip git python python-zmq \
    zlib1g-dev wget bsdmainutils automake curl \
    supervisor

# build koto
RUN cd /usr/local/src \
    && git clone https://github.com/koto-dev/koto.git \
    && cd /usr/local/src/koto \
    && ./autogen.sh \
    && ./zcutil/fetch-params.sh \
    && ./zcutil/build.sh --disable-rust -j$(nproc)

RUN mkdir /root/.koto && touch /root/.koto/koto.conf

ENV PATH $PATH:/usr/local/src/koto/src

# install sshd
RUN apt install -y openssh-server
RUN mkdir -p /var/run/sshd 

# set supervisord.conf
COPY supervisord.conf /etc/supervisord.conf