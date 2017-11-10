FROM ubuntu:16.04

RUN apt-get update && apt-get install -y apt-utils locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV LC_ALL=en_US.UTF-8

RUN apt-get update
RUN apt-get install -y gcc \
wget \
sudo \
python3 \
zlib1g-dev \
python3-pip \
libssl-dev \
build-essential
WORKDIR /tmp
RUN wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2d.tar.gz
RUN tar -xzf openssl-1.0.2d.tar.gz && cd openssl-1.0.2d && ./config --prefix=/usr/local/openssl zlib-dynamic --openssldir=/usr/local/openssl shared && make && make test && sudo make install
ADD openssl.cnf /usr/local/openssl/
ADD openssl.cnf /usr/lib/ssl/
