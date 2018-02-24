#! /bin/sh

HOSTS="
        ""https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts""
        ""https://hosts-file.net/ad_servers.txt""
      "

wget -q -O - $HOSTS | grep .0.0. | sed -e '2,$s/127.0.0.1/0.0.0.0/g' -e 's/[[:space:]]*#.*$//' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u | awk 'NF > 0' > xhosts
killall -1 dnsmasq

exit 0
