# Zabbix Web

- Author : DJERBI Florian
- Object : Monitoring a website on Zabbix 
- Creation Date : 07/27/2023
- Modification Date : 07/27/2023


## Install
### Package
``` bash
apt update
apt upgrade
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-2+debian11_all.deb
dpkg -i zabbix-release_5.0-2+debian11_all.deb
apt update
apt install zabbix-agent2 git
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
```

Edit the /etc/zabbix/zabbix_agent2.conf file.

Create a user zaabix_web
``` bash
useradd -m -s /bin/bash -d /home/zabbix_web zabbix_web
su - zaabix_web
git clone 
```
