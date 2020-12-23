# local
ip tun add a2b mode ipip remote 10.6.207.28 local 9.30.2.97
ip link set a2b up
ip addr add 192.168.200.1 brd 255.255.255.255 peer 192.168.200.2 dev a2b
ip route add 192.168.200.0/24 via 192.168.200.1
ip route  add 172.16.0.34/32 dev a2b

ip tun add a2c mode ipip remote 10.6.207.29 local 9.30.2.97
ip link set a2c up
ip addr add 192.168.201.1 brd 255.255.255.255 peer 192.168.201.2 dev a2c
ip route add 192.168.201.0/24 via 192.168.201.1
ip route  add 172.16.0.35/32 dev a2c

ip tun add a2d mode ipip remote 10.6.207.30 local 9.30.2.97
ip link set a2d up
ip addr add 192.168.202.1 brd 255.255.255.255 peer 192.168.202.2 dev a2d
ip route add 192.168.202.0/24 via 192.168.202.1
ip route  add 172.16.0.36/32 dev a2d


# remote 
ip tun add a2b mode ipip remote 9.30.2.97 local 172.16.0.34
ip link set a2b up
ip addr add 192.168.200.2 brd 255.255.255.255 peer 192.168.200.1 dev a2b
ip route add 192.168.200.0/24 via 192.168.200.2

ip tun add a2c mode ipip remote 9.30.2.97 local 172.16.0.35
ip link set a2c up
ip addr add 192.168.201.2 brd 255.255.255.255 peer 192.168.201.1 dev a2c
ip route add 192.168.201.0/24 via 192.168.201.2

ip tun add a2d mode ipip remote 9.30.2.97 local 172.16.0.36
ip link set a2d up
ip addr add 192.168.202.2 brd 255.255.255.255 peer 192.168.202.1 dev a2d
ip route add 192.168.202.0/24 via 192.168.202.2

