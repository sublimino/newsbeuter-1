FROM ubuntu:latest

RUN \
  groupadd rss && \
  useradd rss -g rss -d /home/rss && \
  mkdir -p /home/rss/.newsbeuter && \
  chown -R rss:rss /home/rss

RUN \
  apt update && \
  apt install -y \
    build-essential \
    libsqlite3-dev \
    libstfl-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libxml2-dev \
    libjson-c-dev \
    libncursesw5-dev \
    libssl-dev \
    gettext \
    git

RUN \
  git clone https://github.com/akrennmair/newsbeuter.git /code

RUN apt install -y vim strace

ADD . /code

RUN \
  cd /code && \
  make && \
  make install

RUN \
  apt install -y elinks 

ENV HOME /home/rss
USER rss
WORKDIR ${HOME}

CMD ["/usr/local/bin/newsbeuter"]
