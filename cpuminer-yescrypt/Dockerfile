FROM ubuntu:16.04

RUN apt update \
    && apt install -y git supervisor build-essential libcurl4-openssl-dev automake

# build cpuminer-yescrypt
RUN cd /usr/local/src \
    && git clone https://github.com/koto-dev/cpuminer-yescrypt.git \
    && cd cpuminer-yescrypt \
    && ./autogen.sh \
    && ./configure CFLAGS="-O3" \
    && make -j$(nproc)

ENV PATH $PATH:/usr/local/src/cpuminer-yescrypt

# install sshd
RUN apt install -y openssh-server
RUN mkdir -p /var/run/sshd 

# set supervisord.conf
COPY supervisord.conf /etc/supervisord.conf
