#!/bin/bash
clear
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "     🔧 Installing L2TP/IPSec VPN"
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

# Update system
apt update -y && apt upgrade -y

# Install required packages
apt install strongswan xl2tpd ppp iptables curl wget nano -y

# Enable IP forwarding
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sysctl -p

# Clean old config
rm -f /etc/ipsec.conf /etc/ipsec.secrets /etc/xl2tpd/xl2tpd.conf /etc/ppp/chap-secrets /etc/ppp/options.xl2tpd

# Create ipsec.conf
cat <<EOF > /etc/ipsec.conf
config setup
    uniqueids=no
conn L2TP-PSK
    keyexchange=ikev1
    authby=secret
    type=transport
    left=%defaultroute
    leftprotoport=17/1701
    right=%any
    rightprotoport=17/1701
    auto=add
EOF

# Create ipsec.secrets
cat <<EOF > /etc/ipsec.secrets
%any  %any  : PSK "jubairbrotelegram"
EOF

# Create xl2tpd config
cat <<EOF > /etc/xl2tpd/xl2tpd.conf
[global]
ipsec saref = yes
listen-addr = $(curl -s ifconfig.me)

[lns default]
ip range = 10.1.0.2-10.1.0.254
local ip = 10.1.0.1
require chap = yes
refuse pap = yes
require authentication = yes
name = JubairVPN
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
EOF

# Create options.xl2tpd
cat <<EOF > /etc/ppp/options.xl2tpd
require-mschap-v2
ms-dns 1.1.1.1
ms-dns 8.8.8.8
auth
mtu 1200
mru 1200
crtscts
hide-password
modem
debug
name l2tpd
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
EOF

# Create chap-secrets with default user
cat <<EOF > /etc/ppp/chap-secrets
# client  server  secret        IP addresses
Jubairbro  l2tpd  Jubairbro     *
EOF

# IPTABLES rule
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables.rules

# Save and apply routing
cat <<EOF > /etc/systemd/system/iptables.service
[Unit]
Description=Restore IPTABLES
[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore < /etc/iptables.rules
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reexec
systemctl enable iptables

# Restart VPN services
systemctl restart strongswan-starter
systemctl restart xl2tpd

# Download management scripts
echo -e "\n📦 Downloading VPN tools from GitHub..."
cd /usr/bin
tools=(vpn vpn-add vpn-del vpn-list vpn-online vpn-log vpn-restart vpn-backup vpn-restore)
for script in "${tools[@]}"; do
    wget -q -O $script https://raw.githubusercontent.com/Jubairbro/L2TP/main/$script
    chmod +x $script
done

echo -e "\n✅ All set!"
echo -e "➡️ Run: \e[1;33mvpn\e[0m to open control menu"
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
