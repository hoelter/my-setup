# My environment setup

This repository holds some scripts I use to assist in setting up my workstation.

## To Setup a Debian Desktop Env

Before running these commands, you'll likely want to to tweak the setup scripts, like removing the ssh authorized key.

Curl and execute the install script
`bash <(curl -s https://raw.githubusercontent.com/hoelter/my-setup/debian/setup-debian.sh)`

After reboot, curl and setup flatpaks (while in a bash shell)
`bash <(curl -s https://raw.githubusercontent.com/hoelter/my-setup/debian/setup-debian-flatpaks.sh)`

This script can be used to setup a headless environment as well, just comment out everything down in the script
where it states the desktop section starts.
