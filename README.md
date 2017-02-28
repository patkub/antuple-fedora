# Setup

## Grab the Fedora boot.iso
```sh
wget https://download.fedoraproject.org/pub/fedora/linux/releases/25/Workstation/x86_64/os/images/boot.iso
```

## Setup Mock
```sh
dnf install mock
cp antuple-fedora-25-x86_64.cfg /etc/mock/
mock -r antuple-fedora-25-x86_64 --init
mock -r antuple-fedora-25-x86_64 --install lorax-lmc-novirt git vim-minimal pykickstart qemu
```

## Kickstart

### Copy Kickstart files
```sh
mock -r antuple-fedora-25-x86_64 --shell
mkdir remix
exit
mock -r antuple-fedora-25-x86_64 --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks boot.iso remix/
```

#### Start a shell
```sh
mock -r antuple-fedora-25-x86_64 --shell
cd remix
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
livemedia-creator --make-iso --iso=boot.iso --iso-name=antuple-fedora-25-x86_64-v1.iso --ks=flat-antuple-fedora.ks
```

To get a log of the livemedia-creator process, copy the virt-install.log file:
```sh
mock -r antuple-fedora-25-x86_64 --copyout /remix/virt-install.log virt-install.log
```

