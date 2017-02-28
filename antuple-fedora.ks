%include fedora-live-base.ks

repo --name=free --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=nonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch

%packages
-libcrypt
libcrypt-nss
beesu
gnome-tweak-tool
google-chrome
vlc
python-vlc
npapi-vlc
%end

%pre
su -c 'setenforce 0'
yum clean expire-cache
yum update selinux-policy\*
%end

%post
/bin/bash
su -c 'setenforce 1'
echo Antuple Fedora $releasever $basearch
echo Setting hostname...
hostnamectl set-hostname laptop.antuple
echo GNOME settings...
beesu gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
beesu gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
beesu gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
beesu gsettings set org.gnome.desktop.interface enable-animations true
%end
