#!/bin/bash

ip4_33_1=x.x.x.x
ip6_1=x:x:x::x
vpn1=x.x.x.x

ip4_33_2=x.x.x.x
ip6_2=x:x:x::x
vpn2=x.x.x.x

#Borrar cadenas

iptables -F
iptables -X

ip6tables -F
ip6tables -X

#Política restrictiva

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

ip6tables -P INPUT DROP
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP

#Aceptar trafico loopback

iptables -A INPUT -i lo -j ACCEPT

ip6tables -A INPUT -s $ip6_1 -j ACCEPT

#Aceptar conexiones relacionadas

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#ssh

iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p tcp --dport 22 -j ACCEPT

ip6tables -A INPUT -s $ip6_2 -d $ip6_1 -p tcp --dport 22 -j ACCEPT

iptables -A INPUT -s <red> -p tcp --dport 22 -i ens33 -j ACCEPT

#http
iptables -A INPUT -d $ip4_33_1 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -d $ip4_33_1 -p tcp --dport 443 -j ACCEPT
ip6tables -A INPUT -d $ip6_1 -p tcp --dport 80 -j ACCEPT
ip6tables -A INPUT -d $ip6_1 -p tcp --dport 443 -j ACCEPT

#ntp
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p udp --dport 123 -j ACCEPT
ip6tables -A INPUT -p udp --dport 123 -j ACCEPT 

#rsyslog
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p udp --dport 514 -j ACCEPT
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p tcp --dport 514 -j ACCEPT
ip6tables -A INPUT -s $ip6_2 -d $ip6_1 -p udp --dport 514 -j ACCEPT
ip6tables -A INPUT -s $ip6_2 -d $ip6_1 -p tcp --dport 514 -j ACCEPT

#icmp
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p icmp -j ACCEPT
ip6tables -A INPUT -d $ip6_1 -p icmpv6 -j ACCEPT
iptables -A INPUT -s $vpn2 -d $vpn1 -p icmp -j ACCEPT

#vpn
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -s $vpn2 -d $vpn1 -p udp --dport 1194 -j ACCEPT

#nessus
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p tcp --dport 8834 -j ACCEPT
iptables -A INPUT -s $ip4_33_2 -d $ip4_33_1 -p tcp --dport 8834 -j ACCEPT

#Deshacer cambios
echo "Durmiendo 30 seg"
sleep 30

iptables -F
iptables -X

ip6tables -F
ip6tables -X

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT


