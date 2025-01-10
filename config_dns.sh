#!/bin/bash
#Init

sudo tee /etc/systemd/resolved.conf >/dev/null <<'EOF'
[Resolve]
DNS=94.140.14.14 2a10:50c0::ad1:ff 94.140.15.15 2a10:50c0::ad2:ff
DNSOverTLS=yes
DNSSEC=yes
FallbackDNS=45.90.28.181 2a07:a8c0::c8:d79a 45.90.30.181 2a07:a8c1::c8:d79a
EOF

systemctl restart systemd-resolved

resolvectl query torrent9.ing
dig torrent9.ing
