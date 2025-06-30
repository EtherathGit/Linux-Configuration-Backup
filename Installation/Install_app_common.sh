#!bin/bash

# Define the error handler
on_error() {
  echo "$(tput bold)❌ Error occurred while $CURRENT$(tput sgr0)"
  exit 1
}

# Register the trap
trap on_error ERR

# Colored print functions
print_info() {
  echo -e "\n\033[1;34m==> $1\033[0m"
}

print_skip() {
  echo -e "\033[1;33m⚠️  $1\033[0m"
}

# Install DNF packages
install_dnf() {
  CURRENT="installing DNF packages"
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
  CURRENT="installing Snap packages"
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
  CURRENT="installing Flatpak packages"
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
  CURRENT="installing RPM packages"
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
  if [[ ${#DNF_APPS[@]} -gt 0 ]]; then
    echo "$(tput bold)==> Starting DNF installations...$(tput sgr0)"
    install_dnf
  else
    echo "$(tput bold)==> Skipping DNF installations (no packages listed)$(tput sgr0)"
  fi

  if [[ ${#SNAP_APPS[@]} -gt 0 ]]; then
    echo "$(tput bold)==> Starting SNAP installations...$(tput sgr0)"
    install_snap
  else
    echo "$(tput bold)==> Skipping SNAP installations (no packages listed)$(tput sgr0)"
  fi

  if [[ ${#FLATPAK_APPS[@]} -gt 0 ]]; then
    echo "$(tput bold)==> Starting FLATPAK installations...$(tput sgr0)"
    install_flatpak
  else
    echo "$(tput bold)==> Skipping FLATPAK installations (no packages listed)$(tput sgr0)"
  fi

  if [[ ${#RPM_URLS[@]} -gt 0 ]]; then
    echo "$(tput bold)==> Starting RPM packages installations...$(tput sgr0)"
    install_rpm
  else
    echo "$(tput bold)==> Skipping RPM installations (no URLs listed)$(tput sgr0)"
  fi

  echo "$(tput bold)$(tput setaf 2)✓ All installations completed.$(tput sgr0)"
}


