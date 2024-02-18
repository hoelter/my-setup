#!/usr/bin/env bash

docker run --rm --mount type=bind,source=$(pwd),target=/home/docker/my-setup,readonly -it my-setup-bare bash -c "./my-setup/setup-debian.sh; bash"
