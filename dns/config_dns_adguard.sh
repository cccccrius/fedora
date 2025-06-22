nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "94.140.14.14 94.140.15.15"
  nmcli con mod "$connection" ipv6.dns "2a10:50c0::ad1:ff 2a10:50c0::ad2:ff"
  nmcli con down "$connection" && nmcli con up "$connection"
done

resolvectl status
