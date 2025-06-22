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

################ Description: ###################

clear

sudo echo -e "\nFedora finish script v2.0 by CRIUS\n" && sleep 4

###
###sudo sans mdp
###
sudo cat /etc/sudoers | grep $USER > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "" | sudo tee -a /etc/sudoers
	echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
	echo "" | sudo tee -a /etc/sudoers
	echo "ALL ALL=NOPASSWD: /usr/bin/wg-quick" | sudo tee -a /etc/sudoers
fi
echo -e "[*] Sudo sans mdp pour $USER\n"

###
###copie images
###
cd $myloc
cp -r ./IMAGES/* $HOME/Images
sudo cp ~/Images/sugiton.jpg /usr/share/wallpapers/sugiton.jpg
sudo chmod 755 /usr/share/wallpapers/sugiton.jpg
echo -e "[*] Images copiées pour $USER\n"

###
###copie des appimages
###
#mkdir ~/zappimages
#cp ./APPIMAGES/* ~/zappimages


#conf dnf
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
echo -e "[*] Dnf customisé\n"


#customiser profil
cat ~/.bashrc | grep "FUSION" > /dev/null 2>&1
if [ $? -eq "1" ]
then
	mkdir ~/scripts
	cp -r ./scripts/*.sh ~/scripts
	chmod +x ~/scripts/*.sh
	echo "alias LITE='~/scripts/lite.sh '" >> ~/.bashrc
	echo "alias LITER='~/scripts/liter.sh '" >> ~/.bashrc
	echo "alias FUSION='~/scripts/fusion.sh '" >> ~/.bashrc
	echo "alias FUSIONALL='~/scripts/fusionall.sh '" >> ~/.bashrc
	echo "alias CONVERT='~/scripts/convert.sh '" >> ~/.bashrc
	echo "alias SHRINK='~/scripts/shrink.sh '" >> ~/.bashrc
	echo "alias sudo='sudo '" >> ~/.bashrc
	echo "alias UP='sudo dnf update -y && flatpak update -y'" >> ~/.bashrc
	perso="alias ll='ls -alFh --color=auto'"
	echo $perso >> ~/.bashrc
	. ~/.bashrc
fi

cat ~/.bash_profile | grep "ll=" > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "alias ll='ls -alFh --color=auto'" | tee -a ~/.bash_profile
fi
#if [ "$MYDE" = "GNOME" ]
#then
	cp ./modèles/* ~/Modèles/
#fi
echo -e "[*] Profil customisé\n"


#enabling png to pdf
sudo sed -i 's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->|g' /etc/ImageMagick-7/policy.xml


# on augmente le buffer de conversion pdf
sudo sed -i 's/1GiB/8GiB/g' /etc/ImageMagick-7/policy.xml
echo -e "[*] Conversion pdf améliorée\n"

#rtc
timedatectl set-local-rtc 1 --adjust-system-clock
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo -e "[*] Heure passée en RTC\n"


#polices
#sudo mkdir -p "/usr/local/share/fonts/"
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
echo -e "[*] Polices Marianne et Spectral installées\n"


#tela
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
echo -e "[*] Icones tela installées\n"

#breeze round
cd /tmp
sudo \rm -rf /tmp/breeze
mkdir -p /tmp/breeze > /dev/null 2>&1
wget -O breeze.zip $WGETOPT https://github.com/L4ki/Breeze-Chameleon-Icons/archive/refs/heads/master.zip
sudo unzip /tmp/breeze.zip -d /tmp/breeze > /dev/null 2>&1
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Dark Icons' /usr/share/icons
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Light Icons' /usr/share/icons
sudo \rm -rf /tmp/breeze
sudo cp $myloc/IMAGES/fedora-logo-icon.svg '/usr/share/icons/Breeze-Round-Chameleon Dark Icons/apps/48/fedora-logo-icon.svg'
sudo cp $myloc/IMAGES/fedora-logo-icon.svg '/usr/share/icons/Breeze-Round-Chameleon Dark Icons/apps/32/fedora-logo-icon.svg'
echo -e "[*] Icones Breeze round installées\n"

#on enlève libreoffice
echo "suppression libreoffice"
sudo dnf remove -y libreoffice* thunderbird* hexchat* pidgin* transmission*

#on installe les depots rpm fusion
sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data && sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted && echo -e "[*] rpm fusion installé\n"

#installation des codecs
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel && sudo dnf install -y lame\* --exclude=lame-devel && sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing && sudo dnf -y install nvidia-vaapi-driver intel-media-driver libva-intel-driver vlc-plugins-freeworld libavcodec-freeworld && sudo dnf update -y @multimedia && sudo dnf4 group upgrade -y multimedia && echo -e "[*] codecs installés\n"

#config flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "[*] flatpak configuré\n"


#installation divers
#gnome-user-share
sudo dnf install -y gparted keepassxc filezilla xournal fastfetch openssl celluloid p7zip-gui p7zip openssl lm_sensors gimp java-21-openjdk transmission xournalpp libavcodec-freeworld ffmpegthumbnailer vlc kwrite nwipe hdparm $DNFOPT

echo -e "[*] logiciels installés\n"

#on installe ffmpeg avec tous ses codecs
#sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing

PCTYPE=$(sudo dmidecode --string chassis-type)

cd $myloc
cd ./GRUB
sudo mkdir -p /boot/grub2/themes/Zorin-16
sudo cp -R ./Zorin-16/* /boot/grub2/themes/Zorin-16
sudo cp grub_default.txt /etc/default/grub

if [ $PCTYPE != "Desktop" ]
then
	sudo grubby --update-kernel=ALL --args="hid_apple.fnmode=2"
fi

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
cd $myloc
echo -e "[*] grub configuré\n"


#on met à jour
echo "mise à jour système"
sudo dnf upgrade -y
sudo dnf autoremove -y

flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.poweriso.PowerISO
flatpak install -y flathub com.warlordsoftwares.media-downloader
flatpak install -y flathub com.warlordsoftwares.youtube-downloader-4ktube

cd $myloc && ./DESKTOP/install_nwipe_kde.sh
cd $myloc && ./DESKTOP/install_desktop_kde.sh
cd $myloc && ./DESKTOP/install_gparted_kde.sh
cd $myloc && ./DESKTOP/install_kparted_kde.sh
cd $myloc && ./BROWSERS/install_firefox.sh
#cd $myloc && ./BROWSERS/config_firefox_no_profile.sh
#cd $myloc && ./BROWSERS/config_firefox.sh
#cd $myloc && ./BROWSERS/THORIUM/install_thorium.sh
cd $myloc && ./ONLY/install_only.sh
#cd $myloc && ./PDFSAM/install_pdfsam.sh

myRPMInstallFunction "balena-io/etcher" "Balena Etcher"
myRPMInstallFunction "Alex313031/Thorium" "Thorium" "AVX2"
myDEBInstallFunction "torakiki/pdfsam" "PDFSam" "pdfsam-basic"

#config DNF
cd $myloc && ./DNS/config_dns.sh

resolvectl query torrent9.ing
dig torrent9.ing

cd $myloc

echo "[***] Fedora install finished."



