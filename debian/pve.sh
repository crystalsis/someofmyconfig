#!/usr/bin/env bash
#bash -c "$(wget https://raw.githubusercontent.com/crystalsis/someofmyconfig/master/debian/pve.sh -O -)"
#su - root
apt-get update
apt-get install netselect-apt
netselect-apt -s -n -c China -d -t 20 stretch
cat <<EOF >/etc/apt/sources.list
deb https://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb https://mirrors.aliyun.com/debian-security stretch/updates main
deb-src https://mirrors.aliyun.com/debian-security stretch/updates main
deb https://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
EOF
apt-get update
apt-get install sudo
usermod -a -G sudo jakaz
usermod -a -G adm jakaz
echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg  # optional, if you have a changed default umask
apt update && apt dist-upgrade
apt install proxmox-ve postfix open-iscsi