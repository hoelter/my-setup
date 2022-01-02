FROM ubuntu:focal

ARG TAGS

WORKDIR /usr/local/bin

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo \
    curl \
    git \
    build-essential \
    software-properties-common \
    && apt-add-repository -y --update ppa:ansible/ansible \
    && apt install -y ansible

ENV HOME /home/docker
ENV USER docker

RUN useradd --create-home --home-dir $HOME docker \
    && echo "docker:docker" | chpasswd && adduser docker sudo

WORKDIR $HOME

USER docker

