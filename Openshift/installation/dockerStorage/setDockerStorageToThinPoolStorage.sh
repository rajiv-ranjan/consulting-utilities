#!/bin/bash

for host in \
    master-0.rajranja.lab.pnq2.cee.redhat.com \
    master-1.rajranja.lab.pnq2.cee.redhat.com \
    master-2.rajranja.lab.pnq2.cee.redhat.com \
    infra-0.rajranja.lab.pnq2.cee.redhat.com \
    infra-1.rajranja.lab.pnq2.cee.redhat.com \
    node-0.rajranja.lab.pnq2.cee.redhat.com \
    node-1.rajranja.lab.pnq2.cee.redhat.com \
    node-2.rajranja.lab.pnq2.cee.redhat.com \
    node-3.rajranja.lab.pnq2.cee.redhat.com \
    node-4.rajranja.lab.pnq2.cee.redhat.com \
    node-5.rajranja.lab.pnq2.cee.redhat.com \
    node-6.rajranja.lab.pnq2.cee.redhat.com \
    node-7.rajranja.lab.pnq2.cee.redhat.com \
    node-8.rajranja.lab.pnq2.cee.redhat.com \
    node-9.rajranja.lab.pnq2.cee.redhat.com \
    lb-0.rajranja.lab.pnq2.cee.redhat.com;  \
    do echo "##### checking the block devices attached : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo lsblk --fs"; \
done

###### RUN ALL COMMAND AS ROOT
### check for the deives attached
ll /dev/disk/by-path/
lsblk --fs 
### observe if the device is already mounted. If yes then unmount and then proceed with docker storage setup
# assuming the vdb is the block storage device attached
fdisk -l /dev/vdb  



### create the docker storage setup config
# mark WIPE_SIGNATURES is required when the device already has signature
# below is what i used with my clusters
clear
sudo su -
#umount /mnt
lsblk -fs
cat <<EOF > /etc/sysconfig/docker-storage-setup
WIPE_SIGNATURES=true
DEVS=/dev/vdb
VG=docker-vg
EOF
### Run the docker storage setup
sudo docker-storage-setup
lsblk -fs
exit
exit


### Verify docker-storage is correctly populated
for host in \
    master-0.rajranja.lab.pnq2.cee.redhat.com \
    master-1.rajranja.lab.pnq2.cee.redhat.com \
    master-2.rajranja.lab.pnq2.cee.redhat.com \
    infra-0.rajranja.lab.pnq2.cee.redhat.com \
    infra-1.rajranja.lab.pnq2.cee.redhat.com \
    node-0.rajranja.lab.pnq2.cee.redhat.com \
    node-1.rajranja.lab.pnq2.cee.redhat.com \
    node-2.rajranja.lab.pnq2.cee.redhat.com \
    node-3.rajranja.lab.pnq2.cee.redhat.com \
    node-4.rajranja.lab.pnq2.cee.redhat.com \
    node-5.rajranja.lab.pnq2.cee.redhat.com \
    node-6.rajranja.lab.pnq2.cee.redhat.com \
    node-7.rajranja.lab.pnq2.cee.redhat.com \
    node-8.rajranja.lab.pnq2.cee.redhat.com \
    node-9.rajranja.lab.pnq2.cee.redhat.com \
    lb-0.rajranja.lab.pnq2.cee.redhat.com;  \
    do echo "##### checking the docker-pool lv for : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo grep -i --color dm.thinpooldev /etc/sysconfig/docker-storage && sudo grep -i --color docker--pool /etc/sysconfig/docker-storage && if [ $? -eq 0 ]; then echo 'SUCCESS'; else echo 'FAIL'; fi;"; \
done
