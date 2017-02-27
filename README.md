
# Setup Mock
```sh
mock -r fedora-25-x86_64 --init
mock -r fedora-25-x86_64 --install lorax-lmc-novirt git vim-minimal pykickstart
mock -r fedora-25-x86_64 --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks
```

# Kickstart

Start a shell
```sh
mock -r fedora-25-x86_64 --shell
```

Install Dependencies
```sh
dnf install qemu
```

Flatten the kickstart file
```sh
ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F25
```

Make the iso
```sh
livemedia-creator --make-iso --iso=boot.iso --ks=flat-antuple-fedora.ks
```

