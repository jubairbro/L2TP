<h1>🔐 L2TP/IPSec VPN - One Click Installer</h1>

<p>A fully automated VPN setup and management tool for <b>Ubuntu</b> VPS, built by <a href="https://github.com/jubairbro" target="_blank">@Jubairbro 🐸</a></p>

<hr>

<h2>🚀 Features</h2>
<ul>
  <li>✅ One-line easy installer</li>
  <li>✅ Auto configuration of L2TP/IPSec with PSK</li>
  <li>✅ VPN user management menu (add, remove, view)</li>
  <li>✅ See live connected users & their IPs</li>
  <li>✅ Works on most Ubuntu servers</li>
  <li>✅ Clean terminal interface</li>
</ul>

<hr>

<h2>📥 Installation (One-Line Command)</h2>

<pre><code>wget -qO v-setup.sh https://raw.githubusercontent.com/jubairbro/L2TP/main/v-setup.sh && chmod +x v-setup.sh && ./v-setup.sh
</code></pre>

<p>This command will:</p>
<ul>
  <li>Remove any existing strongSwan installation</li>
  <li>Install all required packages</li>
  <li>Apply clean VPN configuration</li>
  <li>Add a default user</li>
  <li>Install the menu script (vpn command)</li>
</ul>

<hr>

<h2>🛠 VPN Management (Run Menu Anytime)</h2>

<pre><code>vpn
</code></pre>

<p>You'll see a menu like:</p>

<pre>
━━━━━━━━━━ L2TP/IPSec VPN Menu ━━━━━━━━━━
1. Add New VPN User
2. Remove VPN User
3. Show Connected Users (Live)
4. VPN Configuration Info
5. Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
</pre>

<hr>

<h2>🔑 Default VPN Info</h2>

<table>
  <tr><th>Item</th><th>Value</th></tr>
  <tr><td>Server IP</td><td>(Auto detected)</td></tr>
  <tr><td>Pre-Shared Key</td><td><code>jubairbrotelegram</code></td></tr>
  <tr><td>Default Username</td><td><code>Jubairbro</code></td></tr>
  <tr><td>Default Password</td><td><code>Jubairbro</code></td></tr>
</table>

<p>You can add more users anytime via the menu.</p>

<hr>

<h2>📱 How to Connect (Client Side)</h2>

<h3>📲 Android</h3>
<ol>
  <li>Go to: <b>Settings → Network & Internet → VPN</b></li>
  <li>Add VPN → Choose <b>L2TP/IPSec PSK</b></li>
  <li>Server: your VPS IP</li>
  <li>Username & Password: as configured</li>
  <li>Pre-shared key: <code>jubairbrotelegram</code></li>
</ol>

<h3>💻 Windows</h3>
<ol>
  <li>Control Panel → Network and Sharing → Setup New Connection</li>
  <li>Choose VPN → Enter Server IP</li>
  <li>Choose <b>L2TP/IPSec with pre-shared key</b></li>
  <li>Enter your username & password</li>
</ol>

<p style="text-align:center;">Made with 🐸 by <a href="https://t.me/JubairFF" target="_blank">t.me/JubairFF</a></p>
