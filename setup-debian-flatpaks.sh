#!/usr/bin/env bash

set -e

echo "Installing flatpaks"

flatpak install --user -y flathub \
    com.google.Chrome \
    com.spotify.Client \
    org.pulseaudio.pavucontrol \
    org.flameshot.Flameshot

echo "Flatpaks installed"

