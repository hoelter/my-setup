FROM docker.io/debian:bookworm

ARG TAGS

WORKDIR /usr/local/bin

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo \
    tzdata \
    curl

ENV HOME /home/docker
ENV USER docker

RUN useradd --create-home --home-dir $HOME docker \
    && echo "docker:docker" | chpasswd && adduser docker sudo

WORKDIR $HOME

USER docker

