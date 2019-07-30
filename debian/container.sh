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