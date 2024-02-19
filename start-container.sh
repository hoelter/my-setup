#!/usr/bin/env bash

podman run --rm --mount type=bind,source=$(pwd),target=/home/docker/my-setup,readonly -it my-setup bash -c "./my-setup/setup-debian.sh; bash"

