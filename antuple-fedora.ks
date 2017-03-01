%include fedora-live-base.ks

repo --name=free --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=nonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch

%packages
-libcrypt
libcrypt-nss
google-chrome
vlc
python-vlc
npapi-vlc
%end

%pre
# google chrome repo
wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub
%end

