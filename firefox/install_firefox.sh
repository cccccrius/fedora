#!/bin/bash
#Init

Vert="\033[32m"

echo -e "${Vert}"

myloc=$(dirname "$(realpath $0)")

sudo dnf remove -y firefox*

sudo \rm /usr/share/applications/org.mozilla.firefox.desktop 2> /dev/null

sudo \rm -f /usr/bin/firefox 2> /dev/null

sudo \rm -Rf /usr/lib64/firefox 2> /dev/null

sudo \rm -Rf /usr/lib64/firefox-addons 2> /dev/null

sudo \rm -Rf /opt/firefox 2> /dev/null

sudo \rm -Rf ~/.mozilla 2> /dev/null

sudo \rm ~/FirefoxSetup.tar.xz 2> /dev/null

sudo \rm -rf /usr/lib64/firefox 2> /dev/null

sudo \rm -rf /usr/lib64/firefox-addons 2> /dev/null

sudo \rm -rf /opt/firefox 2> /dev/null

notify-send "Firefox a été désinstallé"

wget -O ~/FirefoxSetup.tar.xz "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=fr"

notify-send "Téléchargement de Firefox terminé"

sudo tar Jxf ~/FirefoxSetup.tar.xz -C /usr/lib64/

sudo unlink /usr/bin/firefox 2> /dev/null
sudo ln -s /usr/lib64/firefox/firefox /usr/bin/firefox

sudo \rm /usr/lib64/firefox/defaults/pref/autoconfig.js 2> /dev/null
sudo mkdir -p /usr/lib64/firefox/defaults/pref/ 2> /dev/null
echo '//
pref("general.config.sandbox_enabled", false);
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);' | sudo tee /usr/lib64/firefox/defaults/pref/autoconfig.js

sudo \rm /usr/lib64/firefox/firefox.cfg 2> /dev/null
echo '//the first line is always a comment
pref("browser.aboutConfig.showWarning", false);
pref("browser.startup.page", 0);
pref("browser.newtabpage.enabled", false);
pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+] Sponsored stories
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Sponsored shortcuts
pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false); // [FF140+] Support Firefox
pref("browser.newtabpage.activity-stream.default.sites", "");
pref("geo.provider.ms-windows-location", false); // [WINDOWS]
pref("geo.provider.use_corelocation", false); // [MAC]
pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]
pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("browser.discovery.enabled", false);
pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
pref("browser.newtabpage.activity-stream.telemetry", false);
pref("app.shield.optoutstudies.enabled", false);
pref("app.normandy.enabled", false);
pref("app.normandy.api_url", "");
pref("breakpad.reportURL", "");
pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [DEFAULT: false]
pref("captivedetect.canonicalURL", "");
pref("network.captive-portal-service.enabled", false); // [FF52+]
pref("network.connectivity-service.enabled", false);
pref("browser.safebrowsing.downloads.remote.enabled", false);
pref("network.prefetch-next", false);
pref("network.dns.disablePrefetch", true);
pref("network.dns.disablePrefetchFromHTTPS", true);
pref("network.predictor.enabled", false);
pref("network.predictor.enable-prefetch", false); // [FF48+] [DEFAULT: false]
pref("network.http.speculative-parallel-limit", 0);
pref("browser.places.speculativeConnect.enabled", false);
pref("network.proxy.socks_remote_dns", true);
pref("network.file.disable_unc_paths", true); // [HIDDEN PREF]
pref("network.gio.supported-protocols", ""); // [HIDDEN PREF] [DEFAULT: ""]
pref("browser.urlbar.speculativeConnect.enabled", false);
pref("browser.urlbar.quicksuggest.enabled", false); // [FF92+]
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false); // [FF95+]
pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // [FF92+]
pref("browser.search.suggest.enabled", false);
pref("browser.urlbar.suggest.searches", false);
pref("browser.urlbar.trending.featureGate", false);
pref("browser.urlbar.addons.featureGate", false); // [FF115+]
pref("browser.urlbar.amp.featureGate", false); // [FF141+] adMarketplace
pref("browser.urlbar.fakespot.featureGate", false); // [FF130+] [DEFAULT: false]
pref("browser.urlbar.mdn.featureGate", false); // [FF117+]
pref("browser.urlbar.weather.featureGate", false); // [FF108+]
pref("browser.urlbar.wikipedia.featureGate", false); // [FF141+]
pref("browser.urlbar.yelp.featureGate", false); // [FF124+]
pref("browser.formfill.enable", false);
pref("browser.search.separatePrivateDefault", true); // [FF70+]
pref("browser.search.separatePrivateDefault.ui.enabled", true); // [FF71+]
pref("signon.autofillForms", false);
pref("signon.formlessCapture.enabled", false);
pref("network.auth.subresource-http-auth-allow", 1);
pref("browser.cache.disk.enable", false);
pref("browser.privatebrowsing.forceMediaMemoryCache", true); // [FF75+]
pref("media.memory_cache_max_size", 65536);
pref("browser.sessionstore.privacy_level", 2);
pref("toolkit.winRegisterApplicationRestart", false);
pref("browser.shell.shortcutFavicons", false);
pref("security.ssl.require_safe_negotiation", true);
pref("security.tls.enable_0rtt_data", false);
pref("security.OCSP.enabled", 1); // [DEFAULT: 1]
pref("security.OCSP.require", true);
pref("security.cert_pinning.enforcement_level", 2);
pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT: true FF137+]
pref("security.pki.crlite_mode", 2);
pref("dom.security.https_only_mode", true); // [FF76+]
pref("dom.security.https_only_mode_send_http_background_request", false);
pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
pref("browser.xul.error_pages.expert_bad_cert", true);
pref("network.http.referer.XOriginTrimmingPolicy", 2);
pref("privacy.userContext.enabled", true);
pref("privacy.userContext.ui.enabled", true);
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
pref("media.peerconnection.ice.default_address_only", true);
pref("dom.disable_window_move_resize", true);
pref("browser.download.start_downloads_in_tmp_dir", true); // [FF102+]
pref("browser.helperApps.deleteTempFileOnExit", true);
pref("browser.uitour.enabled", false);
pref("devtools.debugger.remote-enabled", false); // [DEFAULT: false]
pref("permissions.manager.defaultsUrl", "");
pref("network.IDN_show_punycode", true);
pref("pdfjs.disabled", false); // [DEFAULT: false]
pref("pdfjs.enableScripting", false); // [FF86+]
pref("browser.tabs.searchclipboardfor.middleclick", false); // [DEFAULT: false NON-LINUX]
pref("browser.contentanalysis.enabled", false); // [FF121+] [DEFAULT: false]
pref("browser.contentanalysis.default_result", 0); // [FF127+] [DEFAULT: 0]
pref("security.csp.reporting.enabled", false);
pref("browser.download.useDownloadDir", false);
pref("browser.download.alwaysOpenPanel", false);
pref("browser.download.manager.addToRecentDocs", false);
pref("browser.download.always_ask_before_handling_new_types", true);
pref("extensions.enabledScopes", 5); // [HIDDEN PREF]
pref("extensions.postDownloadThirdPartyPrompt", false);
pref("browser.contentblocking.category", "strict"); // [HIDDEN PREF]
//pref("privacy.sanitize.sanitizeOnShutdown", true);
pref("privacy.clearOnShutdown_v2.cache", true); // [DEFAULT: true]
pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // [DEFAULT: true]
pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // [DEFAULT: true]
pref("privacy.clearOnShutdown_v2.downloads", false); // [HIDDEN]
pref("privacy.clearOnShutdown_v2.formdata", true);
pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);
pref("privacy.clearSiteData.cache", true);
pref("privacy.clearSiteData.cookiesAndStorage", false); // keep false until it respects "allow" site exceptions
pref("privacy.clearSiteData.historyFormDataAndDownloads", false);
pref("privacy.clearSiteData.browsingHistoryAndDownloads", false);
pref("privacy.clearSiteData.formdata", true);
pref("privacy.clearHistory.cache", true); // [DEFAULT: true]
pref("privacy.clearHistory.cookiesAndStorage", false);
pref("privacy.clearHistory.historyFormDataAndDownloads", false); // [DEFAULT: true]
pref("privacy.clearHistory.browsingHistoryAndDownloads", false); // [DEFAULT: true]
pref("privacy.clearHistory.formdata", true);
pref("privacy.sanitize.timeSpan", 0);
pref("privacy.window.maxInnerWidth", 1600);
pref("privacy.window.maxInnerHeight", 900);
pref("privacy.resistFingerprinting.block_mozAddonManager", true);
pref("privacy.spoof_english", 1);
pref("widget.non-native-theme.use-theme-accent", false); // [DEFAULT: false WINDOWS]
pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
pref("browser.link.open_newwindow.restriction", 0);
pref("extensions.blocklist.enabled", true); // [DEFAULT: true]
pref("network.http.referer.spoofSource", false); // [DEFAULT: false]
pref("security.dialog_enable_delay", 1000); // [DEFAULT: 1000]
pref("privacy.firstparty.isolate", false); // [DEFAULT: false]
pref("extensions.webcompat.enable_shims", true); // [HIDDEN PREF] [DEFAULT: true]
pref("security.tls.version.enable-deprecated", false); // [DEFAULT: false]
pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT: false]
pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT: true]
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.enabled", false); // see [NOTE]
pref("toolkit.telemetry.server", "data:,");
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]
pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
pref("toolkit.coverage.endpoint.base", "");
pref("browser.startup.homepage_override.mstone", "ignore"); // [HIDDEN PREF]
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
pref("browser.urlbar.showSearchTerms.enabled", false);
pref("browser.shopping.experience2023.enabled", false); // [DEFAULT: false]
pref("browser.urlbar.pocket.featureGate", false); // [FF116+] [DEFAULT: false]

//mes prefs a moi
pref("network.trr.mode", 3);
pref("network.trr.uri", "https://dns.adguard.com/dns-query");
pref("network.trr.custom_uri", "https://dns.adguard.com/dns-query");
pref("network.trr.bootstrapAddress", "1.1.1.2");
pref("network.trr.default_provider_uri", "https://dns.adguard.com/dns-query");
pref("extensions.autoDisableScopes", 0);
pref("browser.aboutConfig.showWarning", false);
pref("browser.startup.homepage", "https://www.startpage.com/do/mypage.pl?prfe=a38a7b198b39423a2a8410c58bc85195b17c2169dc598fd2f51859005cacef2f1f098194b8ecf7753acb5928c4e5f842512f7eba940b1ac5dbc5849b03d896ba05af3c344cee5f55718ec775030d");
pref("startup.homepage_welcome_url", "https://www.startpage.com/do/mypage.pl?prfe=a38a7b198b39423a2a8410c58bc85195b17c2169dc598fd2f51859005cacef2f1f098194b8ecf7753acb5928c4e5f842512f7eba940b1ac5dbc5849b03d896ba05af3c344cee5f55718ec775030d");
pref("startup.homepage_override_url", "https://www.startpage.com/do/mypage.pl?prfe=a38a7b198b39423a2a8410c58bc85195b17c2169dc598fd2f51859005cacef2f1f098194b8ecf7753acb5928c4e5f842512f7eba940b1ac5dbc5849b03d896ba05af3c344cee5f55718ec775030d");
pref("browser.shell.checkDefaultBrowser", false);
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("app.update.silent", true);
pref("browser.messaging-system.whatsNewPanel.enabled", false);
pref("privacy.trackingprotection.enabled", true);
pref("privacy.firstparty.isolate", true);
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true);
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.rejected", true);
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.unifiedIsOptIn", false);
pref("toolkit.telemetry.prompted", 2);
pref("toolkit.telemetry.rejected", true);
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.healthreport.service.enabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("app.shield.optoutstudies.enabled", false);
pref("browser.urlbar.suggest.pocket", false);
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
pref("browser.newtabpage.activity-stream.system.showSponsored", false);
pref("browser.newtabpage.activity-stream.showSponsored", false);
pref("extensions.pocket.enabled", false);
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
pref("network.dns.echconfig.enabled", true);
pref("network.dns.http3_echconfig.enabled", true);
pref("browser.toolbars.bookmarks.visibility", "always");
pref("media.ffmpeg.vaapi.enabled",true);
pref("media.ffvpx.enabled",false);
pref("media.rdd-vpx.enabled",false);
pref("media.navigator.mediadatadecoder_vpx_enabled",true);
pref("image.webp",false);
pref("browser.download.viewableInternally.typeWasRegistered.webp",false);
pref("drm",true);
pref("sidebar.visibility", "hide-sidebar");
pref("sidebar.revamp", false);
pref("signon.rememberSignons", false);
pref("browser.translations.automaticallyPopup", false);
pref("browser.startup.page", 3);
pref("browser.shell.checkDefaultBrowser", true);
pref("browser.uiCustomization.state", '\''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["jid1-mnnxcxisbpnsxq_jetpack-browser-action","newtaboverride_agenedia_com-browser-action","gmailellcheckersimple_durasoft-browser-action","dontfuckwithpaste_raim_ist-browser-action","gdpr_cavi_au_dk-browser-action","chrome-gnome-shell_gnome_org-browser-action","netflixprime_autoskip_io-browser-action","plasma-browser-integration_kde_org-browser-action","support_netflux_me-browser-action","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","vertical-spacer","home-button","new-tab-button","urlbar-container","downloads-button","history-panelmenu","print-button","preferences-button","unified-extensions-button","ublock0_raymondhill_net-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","alltabs-button"],"vertical-tabs":[],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","screenshot-button","gmailellcheckersimple_durasoft-browser-action","newtaboverride_agenedia_com-browser-action","dontfuckwithpaste_raim_ist-browser-action","gdpr_cavi_au_dk-browser-action","chrome-gnome-shell_gnome_org-browser-action","netflixprime_autoskip_io-browser-action","plasma-browser-integration_kde_org-browser-action","support_netflux_me-browser-action","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","ublock0_raymondhill_net-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","PersonalToolbar","unified-extensions-area","TabsToolbar"],"currentVersion":23,"newElementCount":3}'\'');
pref("browser.tabs.groups.smart.enabled", false);
pref("browser.ml.chat.enabled", false);
pref("browser.ml.chat.shortcuts", false);
pref("browser.ml.chat.sidebar", false);
pref("browser.ml.chat.page", false);' | sudo tee /usr/lib64/firefox/firefox.cfg

sudo \rm /usr/lib64/firefox/distribution/policies.json 2> /dev/null
sudo mkdir -p /usr/lib64/firefox/distribution 2> /dev/null
#about:memory -> measure
echo '{
  "policies": {
    "ExtensionSettings": {
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      },
      "{26b743a8-b1b0-4b8c-a51e-0fc3797727a8}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-consent-dialog-remover/latest.xpi"
      },
      "DontFuckWithPaste@raim.ist": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi"
      },
      "jid1-MnnxcxisBPnSXQ@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi"
      },
      "newtaboverride@agenedia.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi"
      },
      "pure-url@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/pure-url/latest.xpi"
      },
      "gdpr@cavi.au.dk": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi"
      },
      "magnolia_limited_permissions@12.34": {
        "installation_mode": "normal_installed",
        "install_url": "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-3.8.8.0-custom.xpi"
      },
      "{74145f27-f039-47ce-a470-a662b129930a}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
      },
      "dont-track-me-google@robwu.nl": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/dont-track-me-google1/latest.xpi"
      },
      "gmailellcheckersimple@durasoft": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gmail-checker-simple/latest.xpi"
      },
      "{abea9bb3-7bd0-48bc-88b1-39f0560744d6}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-fixer-refreshed/latest.xpi"
      },
      "{00000f2a-7cde-4f20-83ed-434fcb420d71}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi"
      },
      "support@netflux.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflux/latest.xpi"
      },
      "plasma-browser-integration@kde.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi"
      },
      "chrome-gnome-shell@gnome.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gnome-shell-integration/latest.xpi"
      },
      "{7c73b62b-7ac7-4292-81a7-c15746af0972}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-display-icon/latest.xpi"
      },
      "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi"
      },
      "NetflixPrime@Autoskip.io": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflix-prime-auto-skip/latest.xpi"
      },
      "78272b6fa58f4a1abaac99321d503a20@proton.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
      }
    }
  }
}' | sudo tee /usr/lib64/firefox/distribution/policies.json

\rm ~/FirefoxSetup.tar.xz 2> /dev/null

sudo \rm /usr/share/applications/firefox.desktop 2> /dev/null
sudo tee -a /usr/share/applications/firefox.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=Firefox Web Browser
Name[fr]=Navigateur Web Firefox
Comment=Browse the World Wide Web
Comment[fr]=Naviguer sur le Web
GenericName=Web Browser
GenericName[fr]=Navigateur Web
Keywords=Internet;WWW;Browser;Web;Explorer
Keywords[fr]=Internet;WWW;Browser;Web;Explorer;Fureteur;Surfer;Navigateur
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/usr/lib64/firefox/firefox.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Open a New Window
Name[fr]=Ouvrir une nouvelle fenêtre
Exec=firefox -new-window

[Desktop Action new-private-window]
Name=Open a New Private Window
Name[fr]=Ouvrir une nouvelle fenêtre de navigation privée
Exec=firefox -private-window
EOF

sudo mkdir /usr/share/icons/Crius 2> /dev/null
sudo cp ./firefox.png /usr/share/icons/Crius
sudo cp ./firefox.png /usr/lib64/firefox/

sudo setfacl -Rm u:$USER:rwx /usr/lib64/firefox/

notify-send "Firefox a été installé depuis la dernière version du site. Bon surf."
