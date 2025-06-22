nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "86.54.11.13,86.54.11.213"
  nmcli con mod "$connection" ipv6.dns "2a13:1001::86:54:11:13,2a13:1001::86:54:11:213"
  nmcli con down "$connection" && nmcli con up "$connection"
done

resolvectl status
