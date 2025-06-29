#!/bin/bash

# Define lists of apps to install per method
DNF_APPS=("htop" "neofetch")
SNAP_APPS=("code" "spotify")
FLATPAK_APPS=("com.discordapp.Discord")
RPM_URLS=(
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
)

# Colored print functions
print_info() {
  echo -e "\n\033[1;34m==> $1\033[0m"
}

print_skip() {
  echo -e "\033[1;33m⚠️  $1\033[0m"
}

# Install DNF packages
install_dnf() {
  for pkg in "${DNF_APPS[@]}"; do
    if rpm -q "$pkg" &>/dev/null; then
      print_skip "DNF: $pkg is already installed"
    else
      print_info "Installing $pkg via DNF..."
      sudo dnf install -y "$pkg"
    fi
  done
}

# Install Snap packages
install_snap() {
  for pkg in "${SNAP_APPS[@]}"; do
    if snap list | grep -qw "$pkg"; then
      print_skip "Snap: $pkg is already installed"
    else
      print_info "Installing $pkg via Snap..."
      sudo snap install "$pkg"
    fi
  done
}

# Install Flatpak packages
install_flatpak() {
  for pkg in "${FLATPAK_APPS[@]}"; do
    if flatpak list | grep -qw "$pkg"; then
      print_skip "Flatpak: $pkg is already installed"
    else
      print_info "Installing $pkg via Flatpak..."
      flatpak install -y flathub "$pkg"
    fi
  done
}

# Install RPM packages from URLs
install_rpm() {
  TMP_DIR="/tmp/rpm-installer"
  mkdir -p "$TMP_DIR"

  for url in "${RPM_URLS[@]}"; do
    fname=$(basename "$url")
    local_path="$TMP_DIR/$fname"

    # Extract package name from RPM (without downloading yet)
    if [[ "$url" == *.rpm ]]; then
      if [[ -f "$local_path" ]]; then
        rpm_name=$(rpm -qpi "$local_path" | awk -F: '/^Name/ {print $2}' | xargs)
      else
        wget -q "$url" -O "$local_path"
        rpm_name=$(rpm -qpi "$local_path" | awk -F: '/^Name/ {print $2}' | xargs)
      fi

      if rpm -q "$rpm_name" &>/dev/null; then
        print_skip "RPM: $rpm_name is already installed"
      else
        print_info "Installing $rpm_name from RPM file..."
        sudo dnf install -y "$local_path"
      fi
    fi
  done
}

# Run all installers
install_all() {
  install_dnf
  install_snap
  install_flatpak
  install_rpm
  echo -e "\n✔️ \033[1;32mAll installations completed.\033[0m"
}

# Start
install_all
