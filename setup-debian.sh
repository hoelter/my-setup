#!/usr/bin/env bash

set -e

echo "Setting up user directories"
mkdir -p $HOME/.local/bin

echo "Installing core apt packages"
sudo apt install -y \
    git \
    curl \
    build-essential \
    moreutils \
    xclip \
    stow \
    podman \
    htop

echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "Installing core homebrew packages"
brew install \
    gcc \
    fish \
    tmux \
    urlview `# for tmux plugin support` \
    neovim \
    fzf \
    fd \
    ripgrep \
    bat \
    lf

echo "Installing dotfiles"
git clone https://github.com/hoelter/.dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles/
./debian-desktop-install

echo "Completing fzf setup post dotfiles install"
echo "Answers to prompts are y, y, n"
"$(brew --prefix)"/opt/fzf/install

echo "Installing secondary homebrew packages"
# To enable autostart of these services, run 'brew services start syncthing && brew services start tailscale'
brew install \
    syncthing \
    tailscale

echo "Installing desktop apt packages"
# consider additional apt packages: feh azote
sudo apt install -y \
    i3 \
    x11-xserver-utils `# installs xrandr` \
    suckless-tools `# installs dmenu`\
    dunst \
    lightdm \
    redshift \
    thunar \
    pulseaudio \
    pactl

echo "Installing flatpak"
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Need to reboot before flatpak apps can be installed."

echo "Setup script complete, reboot now."

