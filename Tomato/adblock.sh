#! /bin/sh

if [ -e xhosts ]; then rm -rf xhosts; fi

HOSTS=" 
        ""https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext&useip=0.0.0.0""
        ""https://adaway.org/hosts.txt""
        ""http://someonewhocares.org/hosts/zero/hosts""
        ""https://hosts-file.net/ad_servers.txt""
        ""http://www.malwaredomainlist.com/hostslist/hosts.txt""
        ""http://winhelp2002.mvps.org/hosts.txt""
      "

wget -q -O - $HOSTS | grep .0.0. | sed -e '2,$s/127.0.0.1/0.0.0.0/g' -e 's/[[:space:]]*#.*$//' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u | awk 'NF > 0' > xhosts

exit 0
