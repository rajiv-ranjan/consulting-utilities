* stop docker service
* rm -rf /var/lib/docker/*
* remove the lv
* remove the vg
* fdisk and remove the partition
* add WIPE_SIGNATURES=true to /etc/sysconfig/docker-storage-setup
* Make variable DOCKER_STORAGE_OPTIONS in /etc/sysconfig/docker-storage zero-length-string ie ""
* run docker-storage-setup. Make sure it's cleanly initializes docker-vg
* start the docker service. Make sure docker service starts clean. Check via 
```sh  
systemctl start docker.service
journalctl -u docker -n 50 -o json-pretty
```