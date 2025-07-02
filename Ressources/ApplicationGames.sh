#!bin/bash

# Define lists of apps to install per method
DNF_APPS=("steam")
SNAP_APPS=("code" "spotify")
FLATPAK_APPS=("com.discordapp.Discord")
RPM_URLS=(
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
)