#bash -c "$(wget https://raw.githubusercontent.com/crystalsis/someofmyconfig/master/debian/init.sh -O -)"
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
apt-get install -y apt-transport-https gnupg2 software-properties-common sudo vim-nox vim-pathogen vim-asciidoc vim-haproxy vim-youcompleteme vim-command-t zsh fish git curl wget jq busybox ipvsadm keepalived htop iotop iftop zip unzip liblxc1
apt-get install -y strace socat dnsutils net-tools lrzsz cmatrix boxes libaa-bin sl toilet figlet bb fortune-mod fortune-zh cowsay lolcat screenfetch linuxlogo neofetch aview imagemagick pv espeak rig bastet ninvaders pacman4console nsnake greed bsdgames bsdgames moon-buggy pi ri
apt-get install -y fonts-powerline fonts-noto fonts-ipafont-mincho fonts-ipafont-gothic fonts-arphic-ukai fonts-arphic-uming fonts-nanum fonts-mona fonts-vlgothic fonts-takao-gothic fonts-ipafont-gothic fonts-ipaexfont-gothic fonts-takao-mincho fonts-ipafont-mincho fonts-ipaexfont-mincho
apt-get install -y ttf-mscorefonts-installer ttf-denemo ttf-unifont ttf-wqy-zenhei ttf-wqy-microhei ttf-essays1743 ttf-atarismall ttf-dejavu ttf-tagbanwa ttf-summersby ttf-staypuft ttf-marvosym ttf-engadget ttf-bitstream-vera ttf-ancient-fonts-symbola ttf-ancient-fonts ttf-aenigma ttf-sjfonts ttf-lyx ttf-freefont ttf-georgewilliams
apt-get install -y fonts-arphic-bkai00mp fonts-arphic-bsmi00lp fonts-arphic-gbsn00lp fonts-arphic-gkai00mp
#mkdir ~/.local/share/fonts/ -p
#curl -fsSL https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -o ~/.local/share/fonts/PowerlineSymbols.otf
#fc-cache -vf ~/.local/share/fonts/
#mkdir ~/.config/fontconfig/conf.d/ -p
#curl -fsSL https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -o ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
usermod -a -G sudo jakaz
usermod -a -G adm jakaz
#docker
apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/debian $(lsb_release -cs) stable"
apt-key fingerprint 0EBFCD88
apt-get update
apt-get install -y docker-ce
#docker-conpose
curl -fsSL "https://mirrors.aliyun.com/docker-toolbox/linux/compose/1.21.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#k8s
curl -fsSL https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
#rkt
wget https://github.com/rkt/rkt/releases/download/v1.30.0/rkt_1.30.0-1_amd64.deb
dpkg -i rkt_1.30.0-1_amd64.deb
rm -f rkt_1.30.0-1_amd64.deb
#config dir
mkdir /etc/consul.d
mkdir /etc/vault.d
mkdir /etc/vault.d/data
mkdir /etc/vault.d/plugins
#consul
wget https://releases.hashicorp.com/consul/1.4.0/consul_1.4.0_linux_amd64.zip
unzip consul_1.4.0_linux_amd64.zip
chmod +x consul
mv consul /usr/bin/consul
rm -f consul_1.4.0_linux_amd64.zip
#vault
wget https://releases.hashicorp.com/vault/1.0.0/vault_1.0.0_linux_amd64.zip
unzip vault_1.0.0_linux_amd64.zip
chmod +x vault
mv vault /usr/bin/vault
rm -f vault_1.0.0_linux_amd64.zip
#nomad
wget https://releases.hashicorp.com/nomad/0.8.6/nomad_0.8.6_linux_amd64-lxc.zip
unzip nomad_0.8.6_linux_amd64-lxc.zip
chmod +x nomad
mv nomad /usr/bin/nomad
rm -f nomad_0.8.6_linux_amd64-lxc.zip
#fabio
wget https://github.com/fabiolb/fabio/releases/download/v1.5.10/fabio-1.5.10-go1.11.1-linux_amd64
chmod +x fabio-1.5.10-go1.11.1-linux_amd64
mv fabio-1.5.10-go1.11.1-linux_amd64 /usr/bin/fabio
rm -f fabio-1.5.10-go1.11.1-linux_amd64
#etcd
wget https://github.com/etcd-io/etcd/releases/download/v3.3.10/etcd-v3.3.10-linux-amd64.tar.gz
tar xvpf etcd-v3.3.10-linux-amd64.tar.gz
cp etcd-v3.3.10-linux-amd64/etcd /usr/bin/etcd
cp etcd-v3.3.10-linux-amd64/etcdctl /usr/bin/etcdctl
rm -fr etcd-v3.3.10-linux-amd64/
rm -f etcd-v3.3.10-linux-amd64.tar.gz
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"