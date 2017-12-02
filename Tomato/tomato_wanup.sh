#! /bin/sh

if [ ! -e /tmp/systweaked ]; then
	CR="/proc/sys/net/core"
	I4="/proc/sys/net/ipv4"
	I6="/proc/sys/net/ipv6"
	UX="/proc/sys/net/unix"
	VM="/proc/sys/vm"

	ec() { echo $2 > $1; }

	ec $CR/dev_weight 1024
	ec $CR/netdev_budget 1024
	ec $CR/netdev_max_backlog 2048
	ec $CR/optmem_max 65536
	ec $CR/rmem_default 131072
	ec $CR/rmem_max 262144
	ec $CR/somaxconn 1024
	ec $CR/wmem_default 16384
	ec $CR/wmem_max 65536

	ec $I4/icmp_echo_ignore_all 1
	ec $I4/tcp_abc 1
	ec $I4/tcp_adv_win_scale 1
	ec $I4/tcp_app_win 0
	ec $I4/tcp_base_mss 1024
	ec $I4/tcp_ecn 1
	ec $I4/tcp_fin_timeout 30
	ec $I4/tcp_frto 2
	ec $I4/tcp_frto_response 2
	ec $I4/tcp_keepalive_intvl 30
	ec $I4/tcp_keepalive_probes 5
	ec $I4/tcp_keepalive_time 600
	ec $I4/tcp_low_latency 1
	ec $I4/tcp_max_syn_backlog 4096
	ec $I4/tcp_max_tw_buckets 4096
	ec $I4/tcp_mtu_probing 1
	ec $I4/tcp_no_metrics_save 1
	ec $I4/tcp_rfc1337 1
	ec $I4/tcp_rmem "65536 131072 262144"
	ec $I4/tcp_slow_start_after_idle 0
	ec $I4/tcp_tw_recycle 0
	ec $I4/tcp_wmem "8192 16384 65536"

	ec $I6/conf/all/disable_ipv6 1
	ec $UX/max_dgram_qlen 512

	ec $VM/dirty_background_ratio 10
	ec $VM/dirty_expire_centisecs 60000
	ec $VM/dirty_ratio 90
	ec $VM/dirty_writeback_centisecs 60000
	ec $VM/oom_kill_allocating_task 1
	ec $VM/overcommit_memory 2
	ec $VM/overcommit_ratio 100
	ec $VM/swappiness 10
	ec $VM/vfs_cache_pressure 50

	ec /tmp/systweaked
fi

wget -O - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | grep .0.0. | sed -e '2,$s/127.0.0.1/0.0.0.0/g' -e 's/[[:space:]]*#.*$//' > /etc/dnsmasq/hosts/blkhosts
killall -1 dnsmasq

rm -rf /tmp/tomato_wanup.sh

exit 0
