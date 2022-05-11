# Automated dev env setup
This repo contains scripts and ansible tasks to automate the setup of an ubuntu instance, primarily targeting ubuntu 20.04 on wsl2.
A step in this process will clone down my dotfiles repository and symlink those files and run some other configuration scripts.
Use at your own risk!

## Remote Setup
- Run this to start the setup for ubuntu with ansible remotely.
`bash <(curl -s https://raw.githubusercontent.com/hoelter/my-setup/master/ansible-install)`

## Local Setup
- Ensure ansible is installed, clone down this repository, and run the ansible command to install with the tag 'ubuntu'.
- Some tasks may only run when targeted specifically, they will not have the 'ubuntu' tag.

