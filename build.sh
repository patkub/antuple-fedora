#!/bin/bash

####################################################################
# Antuple Fedora Release Script                                    #
# @author: Patrick Kubiak                                          #
#                                                                  #
# Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH] [BUILD_VER]  #
# Example: sudo bash build.sh 25 x86_64 1                          #
#                                                                  #
####################################################################

# Colors
green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0`

# check arguments
if [ $# -ne 3 ]; then
    echo "Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH] [BUILD_VER]"
    exit 1
fi

RELEASE_VER=$1
BASE_ARCH=$2
BUILD_VER=$3
MOCK_IMG=antuple-fedora-$RELEASE_VER-$BASE_ARCH

echo "${red}************************************${reset}"
echo "${green}   Antuple Fedora Release Script!"
echo "${green}   Based on Fedora $RELEASE_VER $BASE_ARCH v$BUILD_VER"
echo "${red}************************************${reset}"
echo " "

# get fedora boot.iso
echo "${green}Getting fedora boot.iso...${reset}"
#rm -rf boot.iso
wget https://download.fedoraproject.org/pub/fedora/linux/releases/$RELEASE_VER/Workstation/$BASE_ARCH/os/images/boot.iso

# setup mock
echo "${green}Setting up mock...${reset}"
dnf install mock
cp $MOCK_IMG.cfg /etc/mock/
mock -r $MOCK_IMG --init
mock -r $MOCK_IMG --install lorax-lmc-novirt git vim-minimal pykickstart qemu

# copy kickstart
echo "${green}Copying Kickstart...${reset}"
mock -r $MOCK_IMG --chroot "mkdir remix"
mock -r $MOCK_IMG --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks boot.iso remix/

# flatten kickstart
echo "${green}Flattening kickstart...${reset}"
mock -r $MOCK_IMG --chroot --cwd=remix/ "ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F$RELEASE_VER"

# make iso
echo "${green}Building iso...${reset}"
mock -r $MOCK_IMG --chroot --cwd=remix/ "livemedia-creator --make-iso --iso=boot.iso --iso-name=$MOCK_IMG-v$BUILD_VER.iso --ks=flat-antuple-fedora.ks"

# save log
echo "${green}Saving log...${reset}"
mock -r $MOCK_IMG --copyout /remix/virt-install.log virt-install.log

