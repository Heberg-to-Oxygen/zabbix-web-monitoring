# Zabbix Web

- Author : DJERBI Florian
- Object : Monitoring a website on Zabbix 
- Creation Date : 07/27/2023
- Modification Date : 07/31/2023


## Requierement
### Package
Install zavvix agent 2 and git
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
### Database
Install and configure sql service:
  - [#](Mariadb (Coming Soon))


## Install
Create a user zaabix_web for clone and management script
``` bash
useradd -m -s /bin/bash -d /home/zabbix_web zabbix_web
su - zaabix_web
rm -rf .*
git clone --branch zabbix_web --single-branch https://github.com/Florian-Dj/script-infra.git
```

Edit the /etc/zabbix/zabbix_agent2.conf file.

### Database
Create a username with the privilieges
``` 

```

Insert a sql structure file in database

``` bash
sudo mysql -u `username` -p zabbix_web < zabbix_web.struct.sql
```

