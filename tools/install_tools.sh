myloc=$(dirname "$(realpath $0)")

sudo dnf install -y nwipe gparted
sudo mkdir /usr/share/icons/Crius/ 2> /dev/null

sudo cp $myloc/updaterdark.png /usr/share/icons/Crius/
sudo \rm ~/Bureau/MISE_A_JOUR.desktop 2> /dev/null
sudo tee ~/Bureau/MISE_A_JOUR.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=MISE_A_JOUR
Comment=MISE_A_JOUR
Exec=konsole -e "bash -c 'sudo dnf update -y && flatpak update -y'"
Icon=/usr/share/icons/Crius/updaterdark.png
Terminal=false
Type=Application
Categories=Application;
EOF

sudo chown $USER:$USER ~/Bureau/MISE_A_JOUR.desktop
sudo chmod +x ~/Bureau/MISE_A_JOUR.desktop

sudo \rm ~/Bureau/home.desktop 2> /dev/null
sudo tee ~/Bureau/home.desktop >/dev/null <<'EOF'
[Desktop Entry]
Encoding=UTF-8
Name=Dossier personnel
GenericName=Fichiers personnels
URL[$e]=$HOME
Icon=user-home
Type=Link
EOF

sudo chown $USER:$USER ~/Bureau/home.desktop
sudo chmod +x ~/Bureau/home.desktop

sudo \rm ~/Bureau/trash.desktop 2> /dev/null
sudo tee ~/Bureau/trash.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=Corbeille
Comment=Fichiers supprimés
Icon=user-trash-full
EmptyIcon=user-trash
Type=Link
URL=trash:/
OnlyShowIn=KDE;
EOF

sudo chown $USER:$USER ~/Bureau/trash.desktop
sudo chmod +x ~/Bureau/trash.desktop

mkdir $HOME/Bureau/rapports_nwipe 2> /dev/null

sudo \rm $HOME/Bureau/Nwipe.desktop 2> /dev/null
sudo tee $HOME/Bureau/Nwipe.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_Nwipe
Comment=Nwipe
Exec=konsole -e "bash -c 'sudo nwipe -m dodshort -P $HOME/Bureau/rapports_nwipe'"
#Exec=ptyxis --standalone --execute "sudo sh -c 'nwipe -m dodshort -P $HOME/Bureau/rapports_nwipe'"
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Application;
EOF

sudo chown $USER:$USER $HOME/Bureau/Nwipe.desktop
sudo chmod +x $HOME/Bureau/Nwipe.desktop
sudo cp $HOME/Bureau/Nwipe.desktop /usr/share/applications

sudo cp /usr/share/applications/gparted.desktop /usr/share/applications/gparted2.desktop
sudo sed -i "s/Name=.*/Name=ADMIN_GParted/g" /usr/share/applications/gparted2.desktop
sudo sed -i "s/Name.fr.=.*/Name[fr]=ADMIN_GParted/g" /usr/share/applications/gparted2.desktop
sudo sed -i "s/GenericName=.*/GenericName=ADMIN_Partition Editor/g" /usr/share/applications/gparted2.desktop
sudo sed -i "s/GenericName.fr.=.*/GenericName[fr]=ADMIN_Éditeur de partitions/g" /usr/share/applications/gparted2.desktop
sudo sed -i "s/Exec=.*/Exec=sudo gparted/g" /usr/share/applications/gparted2.desktop

sudo cp /usr/share/applications/gparted2.desktop $HOME/Bureau
sudo chown $USER:$USER $HOME/Bureau/gparted2.desktop
sudo chmod +x $HOME/Bureau/gparted2.desktop

sudo cp /usr/share/applications/org.kde.partitionmanager.desktop /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Name=.*/Name=ADMIN_KParted/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Name.fr.=.*/Name[fr]=ADMIN_KParted/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/GenericName=.*/GenericName=ADMIN_Partition Editor/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/GenericName.fr.=.*/GenericName[fr]=ADMIN_Éditeur de partitions/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Exec=.*/Exec=sudo partitionmanager/g" /usr/share/applications/org.kde.partitionmanager2.desktop

sudo cp /usr/share/applications/org.kde.partitionmanager2.desktop $HOME/Bureau
sudo chown $USER:$USER $HOME/Bureau/org.kde.partitionmanager2.desktop
sudo chmod +x $HOME/Bureau/org.kde.partitionmanager2.desktop



