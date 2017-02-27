# Setup

## Grab the Fedora boot.iso
```sh
wget https://download.fedoraproject.org/pub/fedora/linux/releases/25/Workstation/x86_64/os/images/boot.iso
```

## Setup Mock
```sh
cp fedora-25-x86_64.cfg /etc/mock/fedora-25-x86_64.cfg
mock -r fedora-25-x86_64 --init
mock -r fedora-25-x86_64 --install lorax-lmc-novirt git vim-minimal pykickstart qemu
mock -r fedora-25-x86_64 --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks boot.iso
```

## Kickstart

#### Start a shell
```sh
mock -r fedora-25-x86_64 --shell
```

#### Install Dependencies
```sh
dnf install qemu
```

#### Flatten the kickstart file
```sh
ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F25
```

#### Make the iso
```sh
livemedia-creator --make-iso --iso=boot.iso --ks=flat-antuple-fedora.ks
```

