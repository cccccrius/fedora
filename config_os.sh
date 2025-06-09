#!/usr/bin/env bash

# on récupère le dossier courant
myloc=$(dirname "$(realpath $0)")
#myloc=$(pwd)
# on récupère la version de debian, utile pour ne pas avoir à modifier le script à chaque version
#codename=$(dpkg --status tzdata|awk -F'[:-]' '$1=="Provides"{print $NF}')

#on récuypère le desktop, gnome ou kde
MYDE=$(echo $XDG_CURRENT_DESKTOP)

WGETOPT='-q --show-progress'

WGETVERSION=$(wget -V | head -n 1 | awk '{ print substr($3,1,1) }')

if [ "$WGETVERSION" = 2 ]
then
	WGETOPT='-nv'
fi

DNFVERSION=$(sudo dnf --version | head -n 1 | awk '{ print substr($1,1,1) }')

if [ "$DNFVERSION" = 5 ]
then
	DNFOPT='--skip-unavailable'
fi

function myRPMInstallFunction() {
gitRepo=$1
filename=$2
urlLatest="https://api.github.com/repos/$gitRepo/releases/latest"
rpmFile=$(curl --silent $urlLatest | grep '\.rpm"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
if [ -n "$3" ]; then
    rpmFile=$(curl --silent $urlLatest | grep $3 | grep '\.rpm"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
fi
LOCFILE='/tmp/temp.rpm'
WGETOPT='-nv'
sudo \rm $LOCFILE 2> /dev/null
wget -O $LOCFILE $rpmFile $WGETOPT
sudo dnf install -y $LOCFILE
sudo \rm -rf $TMPDIR
notify-send "$filename a été installé."
}

function myDEBInstallFunction() {
gitRepo=$1
filename=$2
DIRTMP=/tmp/temp
mkdir $DIRTMP 2> /dev/null
urlLatest="https://api.github.com/repos/$gitRepo/releases/latest"
rpmFile=$(curl --silent $urlLatest | grep '\.deb"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
if [ -n "$4" ]; then
    debFile=$(curl --silent $urlLatest | grep $4 | grep '\.deb"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
fi
LOCFILE='/tmp/temp/temp.deb'
WGETOPT='-nv'
sudo \rm $LOCFILE 2> /dev/null
wget -O $LOCFILE $rpmFile $WGETOPT
cd $DIRTMP
sudo ar x $LOCFILE
tar -xf $DIRTMP/data.tar.gz
cd $DIRTMP/opt
sudo cp -r $3 /opt/$3
cd $DIRTMP/usr
sudo cp -r bin /usr/
sudo cp -r share /usr/
tar -xf $DIRTMP/control.tar.gz
sudo ./postinst configure
notify-send "$filename a été installé."
}

# sudo
sudo cat /etc/sudoers | grep $USER > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "" | sudo tee -a /etc/sudoers
	echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
	echo "" | sudo tee -a /etc/sudoers
	echo "ALL ALL=NOPASSWD: /usr/bin/wg-quick" | sudo tee -a /etc/sudoers
fi

# conf dnf
cat /etc/dnf/dnf.conf | grep parallel > /dev/null 2>&1
if [ $? -eq "1" ]
then
	sudo sh -c 'echo "max_parallel_downloads=10" >>/etc/dnf/dnf.conf'
fi
cat /etc/dnf/dnf.conf | grep fastestmirror > /dev/null 2>&1
if [ $? -eq "1" ]
then
	sudo sh -c 'echo "fastestmirror=True" >>/etc/dnf/dnf.conf'
fi

# ajout rpmfusion
sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data && sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted

# installations
sudo dnf install -y vlc-plugins-freeworld libavcodec-freeworld gnome-tweaks gparted keepassxc filezilla xournal fastfetch openssl p7zip-gui p7zip openssl gimp java-21-openjdk ffmpegthumbnailer nwipe hdparm $DNFOPT

# suppressions
sudo dnf remove -y libreoffice* thunderbird* hexchat* pidgin*

#config flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# polices
sudo mkdir -p "/tmp/fonts/"
sudo mkdir /usr/share/fonts/{Marianne,Spectral} > /dev/null 2>&1
sudo wget -O /tmp/fonts/marianne.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Marianne_fd0ba9c190.zip
sudo wget -O /tmp/fonts/spectral.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Spectral_2a059d2f08.zip
sudo unzip "/tmp/fonts/*.zip" -d /tmp/fonts > /dev/null 2>&1
sudo mv /tmp/fonts/Marianne/fontes\ desktop /tmp/fonts/Marianne/fontes_desktop
sudo mv /tmp/fonts/Marianne/fontes_desktop/*.otf /usr/share/fonts/Marianne
sudo mv /tmp/fonts/*.ttf /usr/share/fonts/Spectral
sudo \rm -rf /tmp/fonts
fc-cache -f -v > /dev/null 2>&1

# icones et curseurs
cd /tmp
#wget --no-check-certificate --content-disposition -O tela.zip -q --show-progress https://codeload.github.com/vinceliuice/Tela-icon-theme/zip/refs/heads/master
#wget -O tela.zip -q --show-progress https://codeload.github.com/vinceliuice/Tela-icon-theme/zip/refs/heads/master
wget -O tela.zip $WGETOPT https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
sudo \rm -rf /tmp/tela
sudo \rm -rf /tmp/Tela-icon-theme-master
mkdir -p /tmp/tela > /dev/null 2>&1
sudo unzip /tmp/tela.zip -d /tmp/tela > /dev/null 2>&1
cd /tmp/tela/Tela-icon-theme-master
sudo ./install.sh > /dev/null 2>&1

wget -O /tmp/breeze.tar.gz $WGETOPT https://github.com/polirritmico/Breeze-Dark-Cursor/releases/download/v1.0/Breeze_Dark_v1.0.tar.gz
cd /tmp
tar -xf breeze.tar.gz >/dev/null 2>&1
sudo mkdir -p /usr/share/icons/Breeze_Dark/
sudo cp -rf /tmp/Breeze_Dark/* /usr/share/icons/Breeze_Dark/
\rm -rf breeze.tar.gz
sudo chown root:root /usr/share/icons/Breeze_Dark/
sudo chmod -R 755 /usr/share/icons/Breeze_Dark/
sudo dnf install -y breeze-cursor-theme > /dev/null 2>&1



