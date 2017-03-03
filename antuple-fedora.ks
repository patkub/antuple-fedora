%include fedora-kickstarts/fedora-live-workstation.ks

# Configure installation method
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/appe-kickstart-syntax-reference.html#sect-kickstart-commands-install
install

# Configure repos
%include antuple-fedora-repos.ks

# Configure Firewall
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-network-configuration.html#sect-kickstart-commands-firewall
firewall --enabled --ssh

# Configure Network Interfaces
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-network.html
network --onboot yes --bootproto=dhcp --hostname=antuple-laptop

# Configure Keyboard Layouts
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-environment.html#sect-kickstart-commands-keyboard
keyboard us

# Configure Language During Installation
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-lang.html
lang en_US

# Configure X Window System
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-xconfig.html
xconfig --startxonboot

# Configure Time Zone
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-timezone.html
timezone America/New_York

# Configure Authentication
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-users-groups.html#sect-kickstart-commands-auth
auth --passalgo=sha512

# Create User Account
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-user.html
user --name=liveuser --password=liveuser --plaintext --groups=wheel

# Set Root Password
# https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-kickstart-commands-rootpw.html
rootpw --plaintext liveuser

# pre-installation
%include antuple-fedora-pre.ks

# Software Selection
%include antuple-fedora-packages.ks

# post-installation
%include antuple-fedora-post.ks


