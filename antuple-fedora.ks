%include fedora-live-base.ks

repo --name=free --baseurl=http://download1.rpmfusion.org/free/fedora/releases/25/Everything/i386/os/
repo --name=nonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/25/Everything/i386/os/
repo --name=snwh-paper --baseurl=http://download.opensuse.org/repositories/home:snwh:paper/Fedora_25/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch

%packages
-libcrypt
libcrypt-nss
beesu
gnome-tweak-tool
paper-icon-theme
paper-gtk-theme
google-chrome
vlc
python-vlc
npapi-vlc
%end

%post
/bin/bash
echo Antuple Fedora
echo Setting hostname...
hostnamectl set-hostname laptop.antuple
echo GNOME settings...
beesu gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
beesu gsettings set org.gnome.desktop.interface icon-theme 'Paper'
beesu gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
beesu gsettings set org.gnome.desktop.interface enable-animations true
%end
