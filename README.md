# 🚀 L2TP/IPSec VPN Server Auto Installer (by Jubairbro)

এই প্রজেক্টটি একটি ফাস্ট ও সিম্পল L2TP/IPSec VPN সার্ভার সেটআপ এবং ম্যানেজমেন্ট সিস্টেম।  
সেটআপের সময় সকল দরকারি প্যাকেজ, কনফিগ, ইউজার ম্যানেজমেন্ট, এবং ফায়ারওয়াল অটোমেটিক কনফিগার হয়।

> ⚠️ শুধুমাত্র Ubuntu VPS (18.04 / 20.04 / 22.04) এর জন্য সাজানো।

---

## 🔧 Install Instructions

```bash
wget -qO v-setup.sh https://raw.githubusercontent.com/jubairbro/L2TP/main/v-setup.sh
chmod +x v-setup.sh
./v-setup.sh```

সফল ইনস্টলেশন শেষে, আপনার VPS এ নিচের কমান্ডটি দিয়ে VPN মেনু চালাতে পারবেন:
```bash
vpn```


---

📋 Default Configuration

Name	Value

Server IP	আপনার VPS এর Public IP
Pre-shared Key	jubairbrotelegram
Username	Jubairbro
Password	Jubairbro
IP Range	10.1.0.2 - 10.1.0.254
DNS	1.1.1.1, 8.8.8.8



---

🧰 Built-in Tools (Menu Options)

Command	Description

vpn	মেইন মেনু চালু করবে
vpn-add	নতুন VPN ইউজার এড করার টুল
vpn-del	ইউজার রিমুভ করার টুল
vpn-list	সকল ইউজার ও তাদের তথ্য দেখতে
vpn-show-connected	কোন ইউজার এখন কানেক্ট আছে দেখাবে
vpn-logs-status	VPN সার্ভিস লগ ও অবস্থা দেখতে পারবেন
vpn-backup-restore	ইউজার ব্যাকআপ ও রিস্টোর সিস্টেম
vpn-expiry-checker	মেয়াদ শেষ চেকার (Auto remove সহ)
vpn-uninstall	সম্পূর্ণভাবে VPN রিমুভ করে দিবে



---

🌐 GitHub Repo Structure

L2TP/
├── v-setup.sh               # Main installer
├── vpn                      # Main menu script
├── vpn-add                  # Add user script
├── vpn-del                  # Remove user script
├── vpn-list                 # List all users
├── vpn-show-connected       # Show active sessions
├── vpn-logs-status          # View VPN logs
├── vpn-backup-restore       # Backup & Restore
├── vpn-expiry-checker       # Expiry control
└── vpn-uninstall            # Full uninstall


---

🐸 Maintainer

> Author: @Jubairbro
Telegram Channel: t.me/JubairFF




---

⚠️ Warning

স্ক্রিপ্টটি শুধুমাত্র ক্লিন VPS এর জন্য সাজানো।

চলমান প্রোডাকশন VPS-এ চালালে পুরাতন কনফিগ ও ইউজার হারাতে পারেন।

আপনি নিজ দায়িত্বে ব্যবহার করবেন।



---

❤️ Contribution

ইচ্ছা করলে টুলে নতুন ফিচার অ্যাড করতে পারেন বা Pull Request করতে পারেন।


---

📅 License

Free to use. Respect original author credit 🙏
© Jubairbro - 2025
