%include fedora-live-base.ks

repo --name=free --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=nonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch

%packages
-libcrypt
libcrypt-nss
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
su -c 'setenforce 1'
%end
