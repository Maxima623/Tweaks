#! /bin/sh

sleep 3; if [ -e /tmp/fwltweaked ]; then exit 0; else echo > /tmp/fwltweaked; fi

iptables -I INPUT 3 -p udp -m state --state NEW -j DROP
iptables -I INPUT 3 -p udp -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -I INPUT 3 -p udp -m connlimit --connlimit-above 64 -j DROP
iptables -I INPUT 3 -p tcp --syn -m state --state NEW -j DROP
iptables -I INPUT 3 -p tcp --syn -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -I INPUT 3 -p tcp --syn -m connlimit --connlimit-above 128 -j DROP

iptables -I FORWARD 3 -p udp -m state --state NEW -j DROP
iptables -I FORWARD 3 -p udp -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -I FORWARD 3 -p udp -m connlimit --connlimit-above 64 -j DROP
iptables -I FORWARD 3 -p tcp --syn -m state --state NEW -j DROP
iptables -I FORWARD 3 -p tcp --syn -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -I FORWARD 3 -p tcp --syn -m connlimit --connlimit-above 128 -j DROP

iptables -I OUTPUT -m state --state INVALID -j DROP

iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
iptables -t mangle -I PREROUTING -p tcp -m state --state NEW -m tcpmss ! --mss 536:65535 -j DROP
iptables -t mangle -I PREROUTING -p tcp ! --syn -m state --state NEW -j DROP
iptables -t mangle -I PREROUTING -m state --state INVALID -j DROP
iptables -t mangle -I PREROUTING -f -j DROP
iptables -t mangle -I PREROUTING -p icmp -j DROP

exit 0
