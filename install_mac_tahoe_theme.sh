#!/bin/bash

sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions
git clone https://github.com/vinceliuice/MacTahoe-gtk-theme.git --depth=1
cd MacTahoe-gtk-theme
sudo ./install.sh

git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git
cd MacTahoe-gtk-theme
sudo ./install.sh

