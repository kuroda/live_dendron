FROM elixir:1.9

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install bash git vim sudo curl inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

RUN apt-get -y install nodejs

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY . /app

USER devel

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
