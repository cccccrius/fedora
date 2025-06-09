#!/bin/bash

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+azerty')]"

sudo dnf install -y gnome-extensions-app dconf-editor

WGETOPT='-q --show-progress'

WGETVERSION=$(wget -V | head -n 1 | awk '{ print substr($3,1,1) }')

if [ "$WGETVERSION" = 2 ]
then
	WGETOPT='-nv'
fi

# curseurs breeze dark fedora

	wget -O /tmp/breeze.tar.gz $WGETOPT https://github.com/polirritmico/Breeze-Dark-Cursor/releases/download/v1.0/Breeze_Dark_v1.0.tar.gz
	cd /tmp
	tar -xf breeze.tar.gz >/dev/null 2>&1
	sudo mkdir -p /usr/share/icons/Breeze_Dark/
	sudo cp -rf /tmp/Breeze_Dark/* /usr/share/icons/Breeze_Dark/
	\rm -rf breeze.tar.gz
	sudo chown root:root /usr/share/icons/Breeze_Dark/
	sudo chmod -R 755 /usr/share/icons/Breeze_Dark/
	sudo dnf install -y breeze-cursor-theme > /dev/null 2>&1

# icones tela
    wget -O /tmp/tela.zip $WGETOPT https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
    cd /tmp
    sudo \rm -rf /tmp/tela
    sudo \rm -rf /tmp/Tela-icon-theme-master
    mkdir -p /tmp/tela > /dev/null 2>&1
    sudo unzip /tmp/tela.zip -d /tmp/tela > /dev/null 2>&1
    cd /tmp/tela/Tela-icon-theme-master
    sudo ./install.sh > /dev/null 2>&1



	# activation minimiser et maximiser
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

	# centrer les nouvelles fenêtres
	gsettings set org.gnome.mutter center-new-windows true
	# Détacher les popups des fenêtres
	gsettings set org.gnome.mutter attach-modal-dialogs false
	#agrandissement fenêtre
	gsettings set org.gnome.mutter auto-maximize false

	# Affichage du calendrier dans le panneau supérieur
	gsettings set org.gnome.desktop.calendar show-weekdate true

	# Modification du format de la date et heure
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface clock-show-seconds true
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface clock-format 24h

	#configurer nautilus
	# Désactivation de l ouverture du dossier lorsqu un élément est glissé dedans
	gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover false
	# Activation du double clic
	gsettings set org.gnome.nautilus.preferences click-policy 'double'

	gsettings set org.gnome.nautilus.preferences show-delete-permanently true
	gsettings set org.gnome.nautilus.preferences show-directory-item-counts 'always'
	gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
	gsettings set org.gnome.nautilus.preferences recursive-search 'always'
	gsettings set org.gtk.Settings.FileChooser sort-directories-first true
	gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

	#numlock
	gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
	gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true

	#touchpad
	gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
	gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
	gsettings set org.gnome.desktop.peripherals.touchpad left-handed 'mouse'
	gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation true
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
	gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
	gsettings set org.gnome.desktop.peripherals.touchpad speed 0.0
	gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag true
	gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag-lock false
	gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map 'default'
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
	#clic droit touchpad
	gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
	#désactiver touchpad si souris branchée
	gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled-on-external-mouse

	# Configuration de GNOME Logiciels
	# Désactivation du téléchargement automatique des mises à jour
	gsettings set org.gnome.software download-updates false
	# Activation de l'affichage des logiciels propriétaires
	gsettings set org.gnome.software show-only-free-apps false

	# Activation du mode nuit
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

	# Epuration des fichiers temporaires et de la corbeille de plus de 30 jours"
	gsettings set org.gnome.desktop.privacy remove-old-temp-files true
	gsettings set org.gnome.desktop.privacy remove-old-trash-files true
	gsettings set org.gnome.desktop.privacy old-files-age "30"

	# Confidentialité de GNOME
	# Désactivation de l'envoi des rapports
	gsettings set org.gnome.desktop.privacy report-technical-problems false
	# Désactivation des statistiques des logiciels
	gsettings set org.gnome.desktop.privacy send-software-usage-stats false

	# Désactivation des sons système
	gsettings set org.gnome.desktop.wm.preferences audible-bell true
	#son 140%
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'

	# Configuration de GNOME Text Editor
	gsettings set org.gnome.TextEditor highlight-current-line false
	gsettings set org.gnome.TextEditor restore-session false
	gsettings set org.gnome.TextEditor show-line-numbers true

	# Configuration interface
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	gsettings set org.gnome.desktop.interface gtk-theme Adwaita
	gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'
	gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Dark'
	gsettings set org.gnome.desktop.interface accent-color 'blue'
	#gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

	# Configuration de GNOME Web
	gsettings set org.gnome.Epiphany ask-for-default false
	gsettings set org.gnome.Epiphany homepage-url 'about:blank'
	gsettings set org.gnome.Epiphany start-in-incognito-mode true

	#numlock au démarrage
	xhost SI:localuser:gdm
	sudo -u gdm gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
	sudo -u gdm gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

	#theme sur gdm
	sudo -u gdm gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	sudo -u gdm gsettings set org.gnome.desktop.interface gtk-theme Adwaita
	sudo -u gdm gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'
	sudo -u gdm gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Dark'

	#fond d'écran gsettings
	sudo -u gdm gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sugiton.jpg

	#un seul bureau
	gsettings set org.gnome.mutter dynamic-workspaces false
	gsettings set org.gnome.desktop.wm.preferences num-workspaces 1

	#on force le thème bleu
	gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

	#### racourcis personnalisés
	BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

	KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
	"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/', '$KEY_PATH/custom2/', '$KEY_PATH/custom3/', '$KEY_PATH/custom4/']"

	# Take a screenshot of the entire display
	$BEGINNING/custom0/ name "Take Full Screenshot"
	$BEGINNING/custom0/ command "shutter --full"
	$BEGINNING/custom0/ binding "Print"

	# screenshot the current active window
	$BEGINNING/custom1/ name "Grab Active Window"
	$BEGINNING/custom1/ command "shutter --active"
	$BEGINNING/custom1/ binding "<Alt>Print"

	# Take a selection of screen with screenshot
	$BEGINNING/custom2/ name "Screenshot Selection"
	$BEGINNING/custom2/ command "shutter --select"
	$BEGINNING/custom2/ binding "<Shift>Print"

	# Launch Terminal
	$BEGINNING/custom3/ name "Gnome Terminal"
	$BEGINNING/custom3/ command "gnome-terminal"
	$BEGINNING/custom3/ binding "<Super>Q"

	# Open up file browser
	$BEGINNING/custom4/ name "Nautilus"
	$BEGINNING/custom4/ command "/usr/bin/nautilus --new-window"
	$BEGINNING/custom4/ binding "<Super>E"

	####


#installation des extensions gnome
array=( #https://extensions.gnome.org/extension/6281/wallpaper-slideshow/
https://extensions.gnome.org/extension/3628/arcmenu/
https://extensions.gnome.org/extension/2087/desktop-icons-ng-ding/
https://extensions.gnome.org/extension/2935/control-blur-effect-on-lock-screen/
https://extensions.gnome.org/extension/1007/window-is-ready-notification-remover/
https://extensions.gnome.org/extension/5470/weather-oclock/
https://extensions.gnome.org/extension/744/hide-activities-button/
https://extensions.gnome.org/extension/4099/no-overview/
https://extensions.gnome.org/extension/2917/bring-out-submenu-of-power-offlogout-button/
https://extensions.gnome.org/extension/517/caffeine/
https://extensions.gnome.org/extension/1160/dash-to-panel/
https://extensions.gnome.org/extension/4105/notification-banner-position/
#https://extensions.gnome.org/extension/1202/nasa-apod/
https://extensions.gnome.org/extension/1319/gsconnect/
https://extensions.gnome.org/extension/6469/picture-of-the-day/
https://extensions.gnome.org/extension/615/appindicator-support/
https://extensions.gnome.org/extension/2/move-clock/
https://extensions.gnome.org/extension/4944/app-icons-taskbar/ )

for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done

gnome-extensions list
gnome-extensions disable dash-to-panel@jderose9.github.com

array=( #https://extensions.gnome.org/extension/307/dash-to-dock/
#https://extensions.gnome.org/extension/1194/show-desktop-button/
https://extensions.gnome.org/extension/3088/extension-list
https://extensions.gnome.org/extension/7/removable-drive-menu/
https://extensions.gnome.org/extension/4356/top-bar-organizer/
https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/
#https://extensions.gnome.org/extension/2/move-clock/ )

for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done

	# Personnalisation de Dash-to-dock
	# Activation de l'extension"
	gnome-extensions enable dash-to-dock@micxgx.gmail.com
	# Placement en bas, fixé et masquage intelligent"
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
	gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen true
	# Correction du bug de la double lettre
	gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true

	# Activation de Appindicator
	gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com



Laval="[<(uint32 2, <('Laval d\'Aix', '', true, [(0.78045539105770666666, 0.09482932332684044444)], @a(dd) [])>)>]"

Marseille="[<(uint32 2, <('Marseille', 'LFML', true, [(0.75834555999153619, 0.091338891703272418)], [(0.75572756611354464, 0.094247779607693788)])>)>]"

Grenoble="[<(uint32 2, <('Grenoble', 'LFLS', true, [(0.79179770980585829, 0.093084220955266736)], [(0.78830705130186962, 0.099774661390106684)])>)>]"

Toulon="[<(uint32 2, <('Can Cantallops', '', false, [(0.75268600012299636, 0.10350660993136945)], @a(dd) [])>)>]"


echo -e "\nVille pour la météo:\n"
PS3='Votre choix: '
select yn in "Marseille" "Grenoble" "Toulon" "Laval d'Aix" "Sortie"; do
	case $yn in
		"Marseille" ) gsettings set org.gnome.Weather locations "$Marseille"; break;;
		"Grenoble" ) gsettings set org.gnome.Weather locations "$Grenoble"; break;;
		"Toulon" ) gsettings set org.gnome.Weather locations "$Toulon"; break;;
		"Laval d'Aix" ) gsettings set org.gnome.Weather locations "$Laval"; break;;
		"Sortie" ) break;;
	esac
done;

#dconf dump /org/gnome/shell/extensions/ > dconf-extensions.txt
#dconf load /org/gnome/shell/extensions/ < dconf-extensions.txt
#dconf dump /org/gnome/ > backup-conf-gnome-fr.txt
#dconf load /org/gnome/ < backup-conf-gnome-fr.txt
