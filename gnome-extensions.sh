array=( https://extensions.gnome.org/extension/6281/wallpaper-slideshow/
https://extensions.gnome.org/extension/3628/arcmenu/
https://extensions.gnome.org/extension/2087/desktop-icons-ng-ding/
https://extensions.gnome.org/extension/2935/control-blur-effect-on-lock-screen/
https://extensions.gnome.org/extension/1007/window-is-ready-notification-remover/
https://extensions.gnome.org/extension/5470/weather-oclock/
https://extensions.gnome.org/extension/4099/no-overview/
https://extensions.gnome.org/extension/517/caffeine/
https://extensions.gnome.org/extension/1160/dash-to-panel/
https://extensions.gnome.org/extension/4105/notification-banner-position/
https://extensions.gnome.org/extension/1319/gsconnect/
https://extensions.gnome.org/extension/615/appindicator-support/
https://extensions.gnome.org/extension/7/removable-drive-menu/ )


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

