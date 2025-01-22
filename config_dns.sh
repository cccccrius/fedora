#!/bin/bash
#Init

sudo tee /etc/systemd/resolved.conf >/dev/null <<'EOF'
[Resolve]
DNS=94.140.14.14 2a10:50c0::ad1:ff 94.140.15.15 2a10:50c0::ad2:ff
DNSOverTLS=yes
DNSSEC=yes
FallbackDNS=45.90.28.181 2a07:a8c0::c8:d79a 45.90.30.181 2a07:a8c1::c8:d79a
EOF

sudo systemctl restart systemd-resolved
sudo systemctl restart systemd-networkd

nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "94.140.14.14 94.140.15.15"
  nmcli con mod "$connection" ipv6.dns "2a10:50c0::ad1:ff 2a10:50c0::ad2:ff"
  nmcli con down "$connection" && nmcli con up "$connection"
done

nmcli dev show
resolvectl status
