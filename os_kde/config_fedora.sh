#!/usr/bin/bash

# on récupère le dossier courant
myloc=$(dirname "$(realpath $0)")

WGETOPT='-q --show-progress'

WGETVERSION=$(wget -V | head -n 1 | awk '{ print substr($3,1,1) }')

if [ "$WGETVERSION" = 2 ]
then
	WGETOPT='-nv'
fi

DNFVERSION=$(sudo dnf --version | head -n 1 | awk '{ print substr($3,1,1) }')

if [ "$DNFVERSION" = 5 ]
then
	DNFOPT='--skip-unavailable'
fi

clear

sudo echo -e "\n\033[31;5mFedora finish script by CRIUS - 202500622\033[0m\n" && sleep 4

###sudo sans mdp
sudo cat /etc/sudoers | grep $USER > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "" | sudo tee -a /etc/sudoers
	echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
	echo "" | sudo tee -a /etc/sudoers
	echo "ALL ALL=NOPASSWD: /usr/bin/wg-quick" | sudo tee -a /etc/sudoers
fi
echo -e "[*] Sudo sans mdp pour $USER\n"

###conf dnf
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

###profil
cat ~/.bash_profile | grep "ll=" > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "alias ll='ls -alFh --color=auto'" | tee -a ~/.bash_profile
fi
cp ./modèles/* ~/Modèles/
echo -e "[*] Profil customisé\n"

###améliorations pdf
#enabling png to pdf
sudo sed -i 's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->|g' /etc/ImageMagick-7/policy.xml
# on augmente le buffer de conversion pdf
sudo sed -i 's/1GiB/8GiB/g' /etc/ImageMagick-7/policy.xml
echo -e "[*] Conversion pdf améliorée\n"

###polices marianne et spectral
sudo mkdir -p "/tmp/fonts/"
sudo mkdir /usr/share/fonts/{Marianne,Spectral} > /dev/null 2>&1
sudo wget -O /tmp/fonts/marianne.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Marianne_fd0ba9c190.zip
sudo wget -O /tmp/fonts/spectral.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Spectral_2a059d2f08.zip
sudo unzip "/tmp/fonts/*.zip" -d /tmp/fonts > /dev/null 2>&1
sudo mv /tmp/fonts/Marianne/fontes\ desktop /tmp/fonts/Marianne/fontes_desktop
sudo mv /tmp/fonts/Marianne/fontes_desktop/*.otf /usr/share/fonts/Marianne
sudo mv /tmp/fonts/*.ttf /usr/share/fonts/Spectral
sudo \rm -rf /tmp/fonts

###icones tela
mkdir -p /tmp/tela > /dev/null
wget -O /tmp/tela/tela.zip $WGETOPT https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
sudo unzip /tmp/tela/tela.zip -d /tmp/tela > /dev/null
cd /tmp/tela/Tela-icon-theme-master
sudo ./install.sh > /dev/null
cd $myloc
sudo \rm -rf /tmp/tela

###icones breeze round
mkdir -p /tmp/breeze > /dev/null 2>&1
wget -O /tmp/breeze/breeze.zip $WGETOPT https://github.com/L4ki/Breeze-Chameleon-Icons/archive/refs/heads/master.zip
sudo unzip /tmp/breeze/breeze.zip -d /tmp/breeze > /dev/null 2>&1
sudo mv /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Dark Icons' /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Dark_Icons
sudo mv /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Light Icons' /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Light_Icons
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Dark_Icons /usr/share/icons
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Light_Icons /usr/share/icons
sudo \rm -rf /tmp/breeze
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Dark_Icons/apps/48/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Dark_Icons/apps/32/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Light_Icons/apps/48/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Light_Icons/apps/32/fedora-logo-icon.svg

###programmes inutiles
echo "suppression programmes inutiles"
sudo dnf remove -y libreoffice* thunderbird* hexchat* pidgin* elisa-player dragon kmahjongg kmines kpat

###on installe les depots rpm fusion
sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data && sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted && echo -e "[*] rpm fusion installé\n"

###config flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "[*] flatpak configuré\n"

###installation logiciels
sudo dnf install -y gparted keepassxc filezilla xournal fastfetch openssl p7zip-gui p7zip lm_sensors gimp java-21-openjdk transmission xournalpp vlc kwrite nwipe hdparm pdfarranger chromium nvidia-vaapi-driver intel-media-driver libva-intel-driver vlc-plugins-freeworld libavcodec-freeworld detox $DNFOPT
echo -e "[*] logiciels installés\n"

###theme grub
cd $myloc
cd ./GRUB
sudo mkdir -p /boot/grub2/themes/Zorin-16
sudo cp -R ./Zorin-16/* /boot/grub2/themes/Zorin-16
sudo cp grub_default.txt /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
cd $myloc
echo -e "[*] grub configuré\n"

###forçage icone vlc
sudo mkdir -p /usr/share/icons/Crius/
sudo cp $myloc/vlc.png /usr/share/icons/Crius/vlc.png
sudo sed -i 's|Icon=vlc|Icon=/usr/share/icons/Crius/vlc.png|' /usr/share/applications/vlc.desktop

###installation shadow drive
sudo \rm -rf ~/zappimage
mkdir ~/zappimages
mkdir ~/.local/share/applications
sudo cp $myloc/APPIMAGES/Nextcloud.png /usr/share/icons/Crius/
cp $myloc/APPIMAGES/tech.shadow.drive.shadow-drive.desktop $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i 's|Icon=Nextcloud|Icon=/usr/share/icons/Crius/Nextcloud.png|' $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i 's|Icon=shadow-drive|Icon=/usr/share/icons/Crius/Nextcloud.png|' $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Icon.fr.=.*|Icon[fr]=/usr/share/icons/Crius/Nextcloud.png|g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Exec=shadow-drive %u|Exec=$HOME/zappimages/ShadowDrive-Linux64.AppImage %u|" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Exec=shadow-drive --quit|Exec=$HOME/zappimages/ShadowDrive-Linux64.AppImage --quit|" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/GenericName=.*/GenericName=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/GenericName.fr.=.*/GenericName[fr]=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/Name=.*/Name=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/Name.fr.=.*/Name[fr]=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo \rm /usr/share/applications/tech.shadow.drive.shadow-drive.desktop
sudo \rm ~/.local/share/applications/tech.shadow.drive.shadow-drive.desktop
sudo \rm $HOME/Bureau/tech.shadow.drive.shadow-drive.desktop
sudo \rm $HOME/zappimages/ShadowDrive-Linux64.AppImage
cp $myloc/APPIMAGES/ShadowDrive-Linux64.AppImage $HOME/zappimages
cd $myloc && cp ./APPIMAGES/shadow.drive.desktop ~/.local/share/applications
cd $myloc && cp ./APPIMAGES/shadow.drive.desktop $HOME/Bureau
