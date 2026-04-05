#!/usr/bin/env bash
# setup.sh - Interactive script to configure nixos-config system variables

set -e

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Welcome to my NixOS Setup Script!${NC}"
echo "This script will help you configure your NixOS system variables."

# Get current values if vars.nix exists
if [ -f vars.nix ]; then
    CURRENT_USERNAME=$(grep "username =" vars.nix | cut -d'"' -f2)
    CURRENT_FULLNAME=$(grep "fullName =" vars.nix | cut -d'"' -f2)
    CURRENT_HOSTNAME=$(grep "hostname =" vars.nix | cut -d'"' -f2)
    CURRENT_TIMEZONE=$(grep "timezone =" vars.nix | cut -d'"' -f2)
    CURRENT_LOCALE=$(grep "locale =" vars.nix | cut -d'"' -f2)
    CURRENT_LAYOUT=$(grep "layout =" vars.nix | cut -d'"' -f2)
    CURRENT_VGATYPE=$(grep "vgaType =" vars.nix | cut -d'"' -f2)
else
    CURRENT_USERNAME=$(whoami)
    CURRENT_FULLNAME="NixOS User"
    CURRENT_HOSTNAME="nixos-pc"
    CURRENT_TIMEZONE="UTC"
    CURRENT_LOCALE="en_US.UTF-8"
    CURRENT_LAYOUT="us"
    CURRENT_VGATYPE="amdgpu"
fi

read -p "Enter username [$CURRENT_USERNAME]: " USERNAME
USERNAME=${USERNAME:-$CURRENT_USERNAME}

read -p "Enter full name [$CURRENT_FULLNAME]: " FULLNAME
FULLNAME=${FULLNAME:-$CURRENT_FULLNAME}

read -p "Enter hostname [$CURRENT_HOSTNAME]: " HOSTNAME
HOSTNAME=${HOSTNAME:-$CURRENT_HOSTNAME}

read -p "Enter timezone [$CURRENT_TIMEZONE]: " TIMEZONE
TIMEZONE=${TIMEZONE:-$CURRENT_TIMEZONE}

read -p "Enter locale [$CURRENT_LOCALE]: " LOCALE
LOCALE=${LOCALE:-$CURRENT_LOCALE}

read -p "Enter keyboard layout (comma separated, e.g., us,id,jp) [$CURRENT_LAYOUT]: " LAYOUT
LAYOUT=${LAYOUT:-$CURRENT_LAYOUT}

echo "Select VGA type:"
echo "1) amdgpu"
echo "2) nvidia"
echo "3) intel"
read -p "Selection [1]: " VGA_SEL
case $VGA_SEL in
    2) VGATYPE="nvidia" ;;
    3) VGATYPE="intel" ;;
    *) VGATYPE="amdgpu" ;;
esac

# Write to vars.nix
cat <<EOF > vars.nix
{
  username = "$USERNAME";
  fullName = "$FULLNAME";
  hostname = "$HOSTNAME";
  timezone = "$TIMEZONE";
  locale = "$LOCALE";
  layout = "$LAYOUT";
  vgaType = "$VGATYPE";
}
EOF

# Ensure vars.nix is tracked by git (intent-to-add) so flakes can see it,
# even if it's ignored in .gitignore.
if [ -d .git ]; then
    git add -N -f vars.nix
fi

echo -e "${GREEN}Configuration saved to vars.nix and tracked locally for Flakes!${NC}"
echo ""
echo "Next steps:"
echo "1. Edit hardware configuration: modules/hosts/pc/hardware.nix"
echo "2. Run: sudo nixos-rebuild switch --flake .#pc"
