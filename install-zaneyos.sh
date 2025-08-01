#!/usr/bin/env bash

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "Verified this is NixOS."
  echo "-----"
else
  echo "This is not NixOS or the distribution information is not available."
  exit
fi

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
  echo "-----"
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Ensure In Home Directory"
cd || exit

echo "-----"

read -rp "Enter Your New Hostname: [ default ] " hostName
if [ -z "$hostName" ]; then
  hostName="default"
fi

echo "-----"

read -rp "Enter Your Hardware Profile (GPU)
Options:
[ amd ]
nvidia
nvidia-laptop
intel
vm
Please type out your choice: " profile
if [ -z "$profile" ]; then
  profile="amd"
fi

echo "-----"

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "zaneyos" ]; then
  echo "ZaneyOS exists, backing up to .config/zaneyos-backups folder."
  if [ -d ".config/zaneyos-backups" ]; then
    echo "Moving current version of ZaneyOS to backups folder."
    mv "$HOME"/zaneyos .config/zaneyos-backups/"$backupname"
    sleep 1
  else
    echo "Creating the backups folder & moving ZaneyOS to it."
    mkdir -p .config/zaneyos-backups
    mv "$HOME"/zaneyos .config/zaneyos-backups/"$backupname"
    sleep 1
  fi
else
  echo "Thank you for choosing ZaneyOS."
  echo "I hope you find your time here enjoyable!"
fi

echo "-----"

echo "Cloning & Entering ZaneyOS Repository"
git clone -b stable-2.3 --single-branch https://gitlab.com/zaney/zaneyos.git
cd zaneyos || exit
mkdir hosts/"$hostName"
cp hosts/default/*.nix hosts/"$hostName"
installusername=$(echo $USER)
git config --global user.name "$installusername"
git config --global user.email "$installusername@gmail.com"
git add .
git config --global --unset-all user.name
git config --global --unset-all user.email
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix
sed -i "/^\s*profile[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$profile\"/" ./flake.nix


read -rp "Enter your keyboard layout: [ us ] " keyboardLayout
if [ -z "$keyboardLayout" ]; then
  keyboardLayout="us"
fi

sed -i "/^\s*keyboardLayout[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$keyboardLayout\"/" ./hosts/$hostName/variables.nix

echo "-----"

read -rp "Enter your console keymap: [ us ] " consoleKeyMap
if [ -z "$consoleKeyMap" ]; then
  consoleKeyMap="us"
fi

sed -i "/^\s*consoleKeyMap[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$consoleKeyMap\"/" ./hosts/$hostName/variables.nix

echo "-----"

sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./flake.nix

echo "-----"

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

echo "-----"

echo "Setting Required Nix Settings Then Going To Install"
NIX_CONFIG="experimental-features = nix-command flakes"

echo "-----"

sudo nixos-rebuild switch --flake ~/zaneyos/#${profile}
