# Zabbix Web

- Author : DJERBI Florian
- Object : Monitoring a website on Zabbix 
- Creation Date : 07/27/2023
- Modification Date : 08/30/2023


## Management
### Website
This script allors to Add, Update, Enable/Disable and list websites zabbix monitoring.
He allows to have alerts for:
- unavailability of the website
- TLS certificate expiry
- domaine name expiry

### Server
This script allors to Add, Update, Enable/Disable and list servers zabbix monitoring.


## Requierement
### Package
Install zabbix agent 2 and git
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
Edit the /etc/zabbix/zabbix_agent2.conf file with a correct IP zabbix server

### Database
Install and configure sql service:
  - [Mariadb](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-debian-11)

Edit a /etc/mysql/mariadb.conf.d/50-server.cnf file, open mariadb service to the world
``` conf
# bind-address            = 127.0.0.1
bind-address            = 0.0.0.0
```
Restart the service
``` bash
systemctl restart mariadb.service
```

After it is opened, add iptables rules
``` conf
iptables -A INPUT -p tcp -s Zabbix-IP --sport 1024:65535 -d Server-IP --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s Server-IP --sport 3306 -d Zabbix-IP --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
```


## Install
Create a user zaabix_web for clone and management script
``` bash
useradd -m -s /bin/bash -d /home/zabbix_web zabbix_web
su - zabbix_web
git clone --branch zabbix_web --single-branch https://github.com/Florian-Dj/script-infra.git
su - zabbix_web
cd ~/script-infra/zabbix_web
cp variable.template variable  # Edit file with a real db informations
```

### Database
Create a username with grant privilieges on database zabbix_web
``` 
CREATE DATABASE IF NOT EXISTS `zabbix_web`;
CREATE USER 'zabbix_web'@'%' IDENTIFIED BY 'StrongPassword';
GRANT SELECT, INSERT, UPDATE ON `zabbix_web`.* TO 'zabbix_web'@'%';
```

Insert a sql structure file in database with a zaabix_web user
``` bash
su - zabbix_web
cd ~/script-infra/zabbix_web
mysql -u zabbix_web -p zabbix_web < zabbix_web.struct.sql
```

### Script conf zabbix
Edit and add a path directory in /etc/zabbix/zabbix_agent2.conf
Create a folder, change owner and copy/paste the zabbix_web_sql.conf file.
``` bash
# root user
echo "Include=./zabbix_agent2.d/plugins.d/zabbix_web/*.conf" >> /etc/zabbix/zabbix_agent2.conf
mkdir -p /etc/zabbix/zabbix_agent2.d/plugins.d/zabbix_web
chown zabbix_web:root /etc/zabbix/zabbix_agent2.d/plugins.d/zabbix_web
su - zabbix_web
cp ~/script-infra/zabbix_web/zabbix_web_sql.conf /etc/zabbix/zabbix_agent2.d/plugins.d/zabbix_web/zabbix_web_sql.conf
cp -r ~/script-infra/zabbix_web/scripts /etc/zabbix/zabbix_agent2.d/plugins.d/zabbix_web/scripts
```
