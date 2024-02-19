#!/usr/bin/env bash

set -e

echo "Setting up SSH authorized key"
mkdir -p $HOME/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7PMYKl6naZDIBtWmVzlEPknCcdTW+9V3H9xNRQ3ymG ssh@christopherhoelter.com" > $HOME/.ssh/authorized_keys

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
    lf \
    syncthing

echo "Installing dotfiles"
git clone https://github.com/hoelter/.dotfiles.git $HOME/.dotfiles --branch debian-changes
cd $HOME/.dotfiles/non-stowed-setup-scripts
./install-desktop.sh

echo "Completing fzf setup post dotfiles install"
echo "Answers to prompts are y, y, n"
"$(brew --prefix)"/opt/fzf/install

echo "Install asdf tool version manager v14"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.14.0
ln -s $HOME/.asdf/completions/asdf.fish $HOME/.config/fish/completions/asdf 

echo "Install tmux plugin manager"
mkdir -p $HOME/.local/share/tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm

echo "Installing tailscale"
# https://tailscale.com/kb/1174/install-debian-bookworm
curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt update && sudo apt install tailscale
# sudo tailscale up to start

echo "Setting up distrobox"
sudo apt install -y distrobox
# git clone https://github.com/89luca89/distrobox $HOME/.distrobox --depth 1 --branch 1.6.0.1
mkdir -p $HOME/.distroboxes/desktop-arch
distrobox create --pull --image docker.io/library/archlinux:latest --name desktop-arch --home $HOME/.distrboxes/desktop-arch --pre-init-hooks "pacman -S zathura" --init-hooks "distrobox-export --app zathura"

# Comment out from here to below to skip desktop package installations
echo "Installing desktop apt packages"
# consider additional apt packages: feh azote
sudo apt install -y \
    i3 \
    x11-xserver-utils `# installs xrandr` \
    suckless-tools `# installs dmenu` \
    dunst \
    lightdm \
    redshift \
    thunar \
    pulseaudio \
    xterm \
    bluetooth \
    distrobox

echo "Complete i3 setup from dotfiles"
./copyinstall-i3-configs.sh

echo "Installing flatpak"
sudo apt install -y flatpak
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Need to reboot before flatpak apps can be installed."
echo "Setup script complete, reboot now."

