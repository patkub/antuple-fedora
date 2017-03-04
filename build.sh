#!/bin/bash

####################################################################
# Antuple Fedora Release Script                                    #
# @author: Patrick Kubiak                                          #
#                                                                  #
# Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH] [BUILD_VER]  #
# Clean: sudo bash build.sh clean				   #
# Example: sudo bash build.sh 25 x86_64 1                          #
#                                                                  #
####################################################################

# Colors
green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0`

# clean up
if [ $1 = "clean" ]; then
	# clean up
	echo "${green}Cleaning up...${reset}"
	mock -r $MOCK_IMG -n --no-cleanup-after --chroot --cwd=/var "rm -rf lmc"
	exit 0
fi

# check arguments
if [ $# -ne 3 ]; then
    echo "Usage: sudo bash build.sh [RELEASE_VER] [BASE_ARCH] [BUILD_VER]"
    exit 1
fi

RELEASE_VER=$1
BASE_ARCH=$2
BUILD_VER=$3
MOCK_IMG=antuple-fedora-$RELEASE_VER-$BASE_ARCH
TITLE=Antuple-Fedora-$RELEASE_VER-$BASE_ARCH

echo "${red}************************************${reset}"
echo "${green}   Antuple Fedora Release Script!${reset}"
echo "${green}   Based on Fedora $RELEASE_VER $BASE_ARCH v$BUILD_VER${reset}"
echo "${red}************************************${reset}"
echo " "

# flatten kickstart
echo "${green}Flattening kickstart...${reset}"
ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F$RELEASE_VER

# copy kickstart
echo "${green}Copying kickstart...${reset}"
mock -r $MOCK_IMG -n --no-cleanup-after --chroot "mkdir remix"
mock -r $MOCK_IMG -n --no-cleanup-after --copyin flat-antuple-fedora.ks boot.iso remix/

# make iso
echo "${green}Building iso...${reset}"
mock -r $MOCK_IMG -n --no-cleanup-after --chroot --cwd=remix/ "livemedia-creator --ks flat-antuple-fedora.ks --no-virt --resultdir /var/lmc --project $TITLE-Live --make-iso --volid $TITLE --iso-only --iso-name $TITLE-$BUILD_VER.iso --releasever $RELEASE_VER --title $TITLE --macboot"

# save iso
echo "${green}Saving iso...${reset}"
mock -r $MOCK_IMG -n --no-cleanup-after --copyout /var/lmc/$TITLE-$BUILD_VER.iso $TITLE-$BUILD_VER.iso

# save log
echo "${green}Saving logs...${reset}"
mock -r $MOCK_IMG -n --no-cleanup-after --copyout /remix/livemedia.log livemedia.log
mock -r $MOCK_IMG -n --no-cleanup-after --copyout /remix/program.log program.log

