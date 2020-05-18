#!/bin/bash
$1=INVENTORY_FILE_PATH
$2=ROOT_CERT_FILE_PATH
$3=PRIVATE_KEY_PATH
$4=MASTER_INTERNAL_URL
$5=MASTER_PUBLIC_URL
$6=$WILDCARD_DOMAIN

mkdir ocpprereqvalidation
cd ocpprereqvalidation

########### Check RHEL Version ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/redhat-release' > redhat-release.log

########### No Of Cores ###########
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'lscpu' > lscpu.log

########### Memory info ###########
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'cat /proc/meminfo' > meminfo.log

########### Verify Selinux is enforcing or not ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'getenforce' > selinux.log

########### Verify DNS requirements ########### 
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/hosts' > etc-hosts.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/resolv.conf' > etc-resolv.log

ansible -i $INVENTORY_FILE_PATH OSEv3v -a 'nslookup $MASTER_INTERNAL_URL && nslookup $MASTER_PUBLIC_URL' > nslookupmasterurl.log

ansible -i $INVENTORY_FILE_PATH OSEv3v -a 'nslookup $WILDCARD_DOMAIN’ > wildcarddomain.log

########### Verify Network requirements ########### 

ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/sysconfig/network-scripts/ifcfg-eth0' > nmControlled.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'sysctl net.ipv4.ip_forward' > netipv4forward.log

########### Verify Node Host value ########### 

ansible -i $INVENTORY_FILE_PATH OSEv3 -m shell -a 'hostname && hostname -f' > nodehost.log

########### Storage utilization###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'df -h' > df.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'lsblk' > lsblk.log

########### NTP ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'timedatectl' > timedatactl.log

########### Entropy ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /proc/sys/kernel/random/entropy_avail' > entropy.log

########### Root Certs & Private Key ###########
openssl x509 -noout -text -in $ROOT_CERT_FILE_PATH > root-certs-description.log
openssl rsa -in $PRIVATE_KEY_PATH -check > privatekey.log

########### fstab Entries ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/fstab' > fstab_masters.log
sudo cat /etc/fstab > fstab_bastion.log

########### Proxy configuration ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/environment' > proxy.log

########### URL Whitelisting ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -m shell -a 'while read LINE; do curl -o /dev/null --silent --head --write-out "%{http_code} $LINE\n" "$LINE"; done < urllist.txt' > curlresponse.log

########### IP Table Content ###########
ansible -i $INVENTORY_FILE_PATH OSEv3 -m shell -a 'sudo iptables -S | grep dport' > iptables.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -m shell -a 'firewall-cmd --zone=public --list-ports' > firewalld-ports-list.log
