# Zabbix Web

- Author : DJERBI Florian
- Object : Monitoring a website on Zabbix 
- Creation Date : 07/27/2023
- Modification Date : 08/07/2023


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

