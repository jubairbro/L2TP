#!/bin/bash
clear
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "     🔧 L2TP/IPSec VPN Installer"
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

# ১. সিস্টেম আপডেট ও প্যাকেজ ইনস্টল
apt update -y && apt upgrade -y
apt install -y strongswan xl2tpd ppp iptables curl wget nano unzip

# ২. IP Forwarding চালু করে sysctl সংরক্ষণ
sysctl_conf="/etc/sysctl.conf"
grep -q "^net.ipv4.ip_forward" $sysctl_conf || echo "net.ipv4.ip_forward = 1" >> $sysctl_conf
sysctl -p

# ৩. পুরনো config & users ফাইল ক্লিয়ার করা
rm -f /etc/ipsec.conf /etc/ipsec.secrets
rm -f /etc/xl2tpd/xl2tpd.conf
rm -f /etc/ppp/chap-secrets /etc/ppp/options.xl2tpd
rm -f /etc/vpn-users.txt

# ৪. নতুন config ফাইল লেখাঃ
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

cat <<EOF > /etc/ipsec.secrets
%any  %any  : PSK "jubairbrotelegram"
EOF

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

cat <<EOF > /etc/ppp/options.xl2tpd
require-mschap-v2
ms-dns 1.1.1.1
ms-dns 8.8.8.8
auth
mtu 1200
mru 1200
lock
hide-password
modem
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
EOF

echo "Jubairbro l2tpd Jubairbro *" > /etc/ppp/chap-secrets
touch /etc/vpn-users.txt

# ৫. IPTables NAT সেটাপ
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables.rules

cat <<EOF > /etc/systemd/system/iptables-restore.service
[Unit]
Description=Restore IPTables on boot
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore < /etc/iptables.rules

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable iptables-restore.service

# ৬. VPN সার্ভিস রিস্টার্ট ও এনেবল
systemctl restart strongswan-starter
systemctl restart xl2tpd
systemctl enable strongswan-starter
systemctl enable xl2tpd

# ৭. GitHub থেকে টুলস ডাউনলোড করা
echo -e "\e[1;36m⬇️  Downloading management scripts...\e[0m"
BASE="https://raw.githubusercontent.com/jubairbro/L2TP/main"
TOOLS=(vpn vpn-add vpn-del vpn-list vpn-show-connected vpn-logs-status vpn-backup-restore vpn-expiry-checker vpn-uninstall)

for cmd in "${TOOLS[@]}"; do
    wget -q "${BASE}/${cmd}" -O /usr/bin/"$cmd"
    chmod +x /usr/bin/"$cmd"
    echo "✅ $cmd installed"
done

# ৮. শেষ বার্তা
echo -e "\n\e[1;32m✅ Installation complete!\e[0m"
echo -e "➡️ To Run Tool type: \e[1;33mvpn\e[0m"
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "\e[1;34mWait 10 sec to reboot.....\e[0m"
sleep 10
reboot



