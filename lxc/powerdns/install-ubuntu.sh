#!/bin/bash
echo 'Started:       Container update'
apt-get update -qq > /dev/null
echo 'Completed:     Container update'
echo 'Started:       Container upgrade'
apt-get upgrade -y -qq > /dev/null
echo 'Completed:     Container upgrade'
echo 'Started:       Disabling Resolved'
systemctl disable systemd-resolved.service
systemctl stop systemd-resolved.service
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo 'Completed:     Disabling Resolved'
echo 'Started:       Installing PowerDNS'
apt-get install pdns-server pdns-backend-mysql -y -qq > /dev/null
systemctl restart pdns
systemctl enable pdns
echo 'Completed:     Installing PowerDNS'
echo '##################################'
echo '##################################'
echo '######     Post Install     ######'
echo '##################################'
echo '##################################'
echo '                                  '
echo '  You must modify the pdns.conf   '
echo '  file before using PowerDNS.     '
echo '                                  '
echo '  You can do this by editing      '
echo '  /etc/powerdns/pdns.conf         '
echo '                                  '
echo '##################################'
echo '##################################'
exit 1
