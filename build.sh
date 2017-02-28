#!/bin/bash

########################################################
# Antuple Fedora Release Script                        #
# @author: Patrick Kubiak                              #
#                                                      #
# Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH]  #
# Example: sudo bash build.sh 25 x86_64                #
#                                                      #
########################################################

# Colors
green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0`

# check arguments
if [ $# -ne 2 ]; then
    echo "Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH]"
    exit 1
fi

RELEASE_VER=$1
BASE_ARCH=$2

echo "${red}************************************${reset}"
echo "${green}   Antuple Fedora Release Script!"
echo "${green}   Based on Fedora $RELEASE_VER $BASE_ARCH"
echo "${red}************************************${reset}"
echo " "

# get fedora boot.iso
echo "${green}Getting fedora boot.iso...${reset}"
wget https://download.fedoraproject.org/pub/fedora/linux/releases/$RELEASE_VER/Workstation/$BASE_ARCH/os/images/boot.iso

# setup mock
echo "${green}Setting up mock...${reset}"
dnf install mock
cp antuple-fedora-$RELEASE_VER-$BASE_ARCH.cfg /etc/mock/
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --init
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --install lorax-lmc-novirt git vim-minimal pykickstart qemu

# copy kickstart
echo "${green}Copying Kickstart...${reset}"
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --chroot "mkdir remix"
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks boot.iso remix/
mock -r antuple-fedora-25-x86_64 --chroot "cd remix"

# flatten kickstart
echo "${green}Flattening kickstart...${reset}"
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --chroot "ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F$RELEASE_VER"

# make iso
echo "${green}Building iso...${reset}"
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --chroot "livemedia-creator --make-iso --iso=boot.iso --iso-name=antuple-fedora-$RELEASE_VER-$BASE_ARCH-v1.iso --ks=flat-antuple-fedora.ks"

# save log
echo "${green}Saving log...${reset}"
mock -r antuple-fedora-$RELEASE_VER-$BASE_ARCH --copyout /remix/virt-install.log virt-install.log

