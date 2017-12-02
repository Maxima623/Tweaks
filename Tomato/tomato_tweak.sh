#! /bin/sh

sleep 10
wget -qO- https://raw.githubusercontent.com/Maxima623/Tweaks/master/Tomato/tomato_firewall.sh | sh
wget -qO- https://raw.githubusercontent.com/Maxima623/Tweaks/master/Tomato/tomato_wanup.sh | sh

exit 0
