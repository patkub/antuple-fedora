%pre
# google chrome repo
wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub

# vlc
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$releasever.noarch.rpm
%end

