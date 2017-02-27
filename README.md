
mock -r fedora-25-x86_64 --init  
mock -r fedora-25-x86_64 --install lorax-lmc-novirt git vim-minimal pykickstart  
mock -r fedora-25-x86_64 --copyin antuple-fedora.ks fedora-live-base.ks fedora-repo.ks fedora-repo-not-rawhide.ks  

mock -r fedora-25-x86_64 --shell  
ksflatten -v, --config antuple-fedora.ks -o flat-antuple-fedora.ks --version F25  
dnf install qemu  
livemedia-creator --ks flat-antuple-fedora.ks --no-virt --resultdir /var/lmc --project Fedora-Antuple-Live --make-iso --volid Fedora-SoaS-25 --iso-only --iso-name Fedora-Antuple-25-x86_64.iso --releasever 25 --title Fedora-Antuple-live --macboot  
