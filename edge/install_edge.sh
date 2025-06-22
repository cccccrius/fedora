sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf4 config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo dnf install -y microsoft-edge-stable
sudo mkdir /usr/share/icons/Crius 2> /dev/null
sudo cp ./edge.png /usr/share/icons/Crius
sudo sed -i 's|Icon=microsoft-edge|Icon=/usr/share/icons/Crius/edge.png|' /usr/share/applications/microsoft-edge.desktop
