#! /bin/sh

iptables -t mangle -I PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
iptables -t mangle -I PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

iptables -t mangle -I PREROUTING -p tcp -m state --state NEW -m tcpmss ! --mss 536:65535 -j DROP
iptables -t mangle -I PREROUTING -p tcp ! --syn -m state --state NEW -j DROP
iptables -t mangle -I PREROUTING -m state --state INVALID -j DROP
iptables -t mangle -I PREROUTING -f -j DROP
iptables -t mangle -I PREROUTING -p icmp -j DROP

iptables -t nat -I PREROUTING -p udp -m state --state NEW -j DROP
iptables -t nat -I PREROUTING -p udp -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -t nat -I PREROUTING -p udp -m multiport ! --dports 53,80,443 -m connlimit --connlimit-above 128 -j DROP
iptables -t nat -I PREROUTING -p tcp --syn -m state --state NEW -j DROP
iptables -t nat -I PREROUTING -p tcp --syn -m state --state NEW -m limit --limit 16/second --limit-burst 16 -j ACCEPT
iptables -t nat -I PREROUTING -p tcp --syn -m multiport ! --dports 53,80,443 -m connlimit --connlimit-above 128 -j DROP

exit 0
