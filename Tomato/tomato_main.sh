#! /bin/sh

if [ ! -e /tmp/tweaked ]; then 
  wget -qO- https://raw.githubusercontent.com/Maxima623/Tweaks/master/Tomato/tomato_wanup.sh | sh
  wget -qO- https://raw.githubusercontent.com/Maxima623/Tweaks/master/Tomato/tomato_firewall.sh | sh
  echo > /tmp/tweaked
fi

exit 0
