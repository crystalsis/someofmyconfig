#bash -c "$(wget https://raw.githubusercontent.com/crystalsis/commons/master/init.sh -O -)"
#su - root
usermod -a -G sudo jakaz
usermod -a -G adm jakaz
apt-get update
apt-get install -y apt-transport-https gnupg2 software-properties-common sudo vim zsh fish git curl wget jq busybox htop iotop iftop unzip liblxc1 strace socat dnsutils net-tools fonts-powerline lrzsz cmatrix cmatrix-xfont boxes libaa-bin sl toilet figlet bb fortune-mod fortune-zh cowsay lolcat screenfetch linuxlogo neofetch aview imagemagick pv espeak rig bastet ninvaders pacman4console nsnake greed bsdgames bsdgames moon-buggy pi ri fonts-noto fonts-ipafont-mincho fonts-ipafont-gothic fonts-arphic-ukai fonts-arphic-uming fonts-nanum fonts-mona fonts-vlgothic fonts-takao-gothic fonts-ipafont-gothic fonts-ipaexfont-gothic fonts-takao-mincho fonts-ipafont-mincho fonts-ipaexfont-mincho
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir ./demoCA
mkdir ./demoCA/certs
mkdir ./demoCA/newcerts
mkdir ./demoCA/private
mkdir ./demoCA/crl
touch ./demoCA/index.txt
echo 01 > ./demoCA/serial
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -out ca.csr
#openssl x509 -req -days 36500 -in ca.csr -signkey ca.key -out ca.crt
openssl req -new -x509 -days 36500 -key ca.key -out ca.crt subj "/C=CN/ST=Shandong/L=Qingdao/O=guagua/OU=party/CN=consul.guagua.party"
openssl genrsa  -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl ca -in server.csr -out server.crt -cert ca.crt -keyfile ca.key
mkdir /etc/consul.d
mkdir /etc/vault.d
mkdir /etc/vault.d/data
mkdir /etc/vault.d/plugins
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#curl -L https://get.oh-my.fish | fish
#omf install lambda fonts mvn rvm
wget https://releases.hashicorp.com/consul/1.4.0/consul_1.4.0_linux_amd64.zip
unzip consul_1.4.0_linux_amd64.zip
chmod +x consul
mv consul /usr/bin/consul
rm -f consul_1.4.0_linux_amd64.zip
wget https://releases.hashicorp.com/vault/1.0.0/vault_1.0.0_linux_amd64.zip
unzip vault_1.0.0_linux_amd64.zip
chmod +x vault
mv vault /usr/bin/vault
rm -f vault_1.0.0_linux_amd64.zip
wget https://releases.hashicorp.com/nomad/0.8.6/nomad_0.8.6_linux_amd64-lxc.zip
unzip nomad_0.8.6_linux_amd64-lxc.zip
chmod +x nomad
mv nomad /usr/bin/nomad
rm -f nomad_0.8.6_linux_amd64-lxc.zip
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