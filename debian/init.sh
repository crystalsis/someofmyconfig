#!/usr/bin/env bash
#自动或手动判断Linux发行版和版本号初始化系统，安装字体，安装常用工具和zsh等
#正在修改中，修改的已经不能用了
#Centos Debian Fedora Ubuntu ↑↓ OpenSUSE Gentoo Arch Alpine ↓↓ FreeBSD OpenBSD NetBSD
#bash -c "$(wget https://raw.githubusercontent.com/crystalsis/someofmyconfig/master/debian/init.sh -O -)"
#su - root
if [ -n "$1" ]; then
  os="$1"
  if [ -n "$2" ]; then
    ver="$2"
    if [[ $os == "debian" ]]; then
      case $ver in
      4)
        code="etch"
        ;;
      5)
        code="lenny"
        ;;
      6)
        code="squeeze"
        ;;
      7)
        code="wheezy"
        ;;
      8)
        code="jessie"
        ;;
      9)
        code="stretch"
        ;;
      10)
        code="buster"
        ;;
      esac
    elif [[ $os == "centos" ]]; then
      code="$ver"
    else
      code="$ver"
    fi
  else
    command -v lsb_release || { dnf install -y redhat-lsb || yum install -y redhat-lsb || apt-get install -y lsb-release || zypper install -y lsb-release; }
    os=$(lsb_release -is | tr [:upper:] [:lower:])
    ver=$(lsb_release -rs | tr [:upper:] [:lower:])
    code=$(lsb_release -cs | tr [:upper:] [:lower:])
  fi
else
  command -v lsb_release || { dnf install -y redhat-lsb || yum install -y redhat-lsb || apt-get install -y lsb-release || zypper install -y lsb-release; }
  os=$(lsb_release -is | tr [:upper:] [:lower:])
  ver=$(lsb_release -rs | tr [:upper:] [:lower:])
  code=$(lsb_release -cs | tr [:upper:] [:lower:])
fi
printf "select os:%s,version:%s,dode:%s\n" "${os}" "${ver}" "${code}"
case ${os} in
debian)
  case ${code} in
  buster)
    printf "0\n"
    ;;
  stretch)
    printf "1\n"
    ;;
  jessie)
    printf "2\n"
    ;;
  wheezy)
    printf "3\n"
    ;;
  esac
  ;;
centos)
  printf "4\n"
  ;;
fedora) ;;

ubuntu) ;;

opensuse) ;;

gentoo) ;;

arch) ;;

alpine) ;;

esac

#context
apt-get update
apt-get install -y netselect-apt apt-transport-https
netselect-apt -s -n -c China -d -t 20 ${ver}
mv sources.list /etc/apt/sources.list
apt-get update

cat <<EOF >/etc/apt/sources.list
deb https://mirrors.aliyun.com/debian/ stable main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stable main non-free contrib
deb https://mirrors.aliyun.com/debian/ stable-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stable-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ stable-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stable-backports main non-free contrib
deb https://mirrors.aliyun.com/debian/ stable-proposed-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stable-proposed-updates main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ stable/updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian-security/ stable/updates main non-free contrib
EOF
apt-get update
apt-get upgrade
apt-get install -y gnupg2 software-properties-common sudo
usermod -a -G sudo jakaz
usermod -a -G adm jakaz
apt-get install -y vim-nox vim-pathogen vim-asciidoc vim-haproxy vim-youcompleteme vim-command-t
apt-get install -y zsh fish git curl wget jq busybox ipvsadm keepalived htop iotop iftop zip unzip liblxc1
#funny
apt-get install -y strace socat dnsutils net-tools lrzsz cmatrix boxes libaa-bin sl toilet figlet bb
apt-get install -y fortune-mod fortune-zh cowsay lolcat screenfetch linuxlogo neofetch aview imagemagick
apt-get install -y pv espeak rig bastet ninvaders pacman4console nsnake greed bsdgames bsdgames moon-buggy pi ri
#fonts
apt-get install -y fonts-powerline fonts-noto fonts-ipafont-mincho fonts-ipafont-gothic fonts-arphic-ukai fonts-arphic-uming
apt-get install -y fonts-nanum fonts-mona fonts-vlgothic fonts-takao-gothic fonts-ipafont-gothic fonts-ipaexfont-gothic
apt-get install -y fonts-takao-mincho fonts-ipafont-mincho fonts-ipaexfont-mincho
apt-get install -y ttf-mscorefonts-installer ttf-denemo ttf-unifont ttf-wqy-zenhei ttf-wqy-microhei ttf-essays1743 ttf-atarismall
apt-get install -y ttf-dejavu ttf-tagbanwa ttf-summersby ttf-staypuft ttf-marvosym ttf-engadget ttf-bitstream-vera
apt-get install -y ttf-ancient-fonts-symbola ttf-ancient-fonts ttf-aenigma ttf-sjfonts ttf-lyx ttf-freefont ttf-georgewilliams
apt-get install -y fonts-arphic-bkai00mp fonts-arphic-bsmi00lp fonts-arphic-gbsn00lp fonts-arphic-gkai00mp
#mkdir ~/.local/share/fonts/ -p
#curl -fsSL https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -o ~/.local/share/fonts/PowerlineSymbols.otf
#fc-cache -vf ~/.local/share/fonts/
#mkdir ~/.config/fontconfig/conf.d/ -p
#curl -fsSL https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -o ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
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
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
