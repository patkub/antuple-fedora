url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch"
repo --name=fedora-updates --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch" --cost=100
repo --name=rpmfusion-free --mirrorlist="http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch" --includepkgs=rpmfusion-free-release
repo --name=rpmfusion-free-updates --mirrorlist="http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch" --includepkgs=rpmfusion-free-release
repo --name=rpmfusion-nonfree --mirrorlist="http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch" --includepkgs=rpmfusion-nonfree-release
repo --name=rpmfusion-nonfree-updates --mirrorlist="http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch" --includepkgs=rpmfusion-nonfree-release
repo --name=google-chrome --baseurl="http://dl.google.com/linux/chrome/rpm/stable/\$basearch"

