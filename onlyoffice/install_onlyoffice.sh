sudo dnf install -y https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
sudo dnf install -y onlyoffice-desktopeditors
sudo mkdir /usr/share/icons/Crius 2> /dev/null
sudo cp ./only.png /usr/share/icons/Crius
sudo sed -i 's|Icon=onlyoffice-desktopeditors|Icon=/usr/share/icons/Crius/only.png|' /usr/share/applications/onlyoffice-desktopeditors.desktop
