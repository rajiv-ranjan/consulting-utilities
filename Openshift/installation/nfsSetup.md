```sh
lsblk
```
```sh
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    253:0    0  40G  0 disk
`-vda1 253:1    0  40G  0 part /
vdb    253:16   0  10G  0 disk
`-vdb1 253:17   0  10G  0 part
vdc    253:32   0  10G  0 disk
`-vdc1 253:33   0  10G  0 part
```

[root@node-0 ~]# pvcreate /dev/vdb1
  Physical volume "/dev/vdb1" successfully created.
[root@node-0 ~]# vgcreate vg-registry /dev/vdb1
  Volume group "vg-registry" successfully created
[root@node-0 ~]# vgcreate vg-apps /dev/vdc1
  Physical volume "/dev/vdc1" successfully created.
  Volume group "vg-apps" successfully created
[root@node-0 ~]# lvcreate -n lv-registry -l 100%VG vg-registry
  Logical volume "lv-registry" created.
[root@node-0 ~]# lvcreate -n lv-apps -l 100%VG vg-apps
  Logical volume "lv-apps" created.

[root@node-0 ~]# mkfs.xfs /dev/mapper/vg--apps-lv--apps
meta-data=/dev/mapper/vg--apps-lv--apps isize=512    agcount=4, agsize=655104 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2620416, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@node-0 ~]# mkfs.xfs /dev/mapper/vg--registry-lv--registry
meta-data=/dev/mapper/vg--registry-lv--registry isize=512    agcount=4, agsize=655104 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2620416, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0


[root@node-0 ~]# lsblk
NAME                          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda                           253:0    0  40G  0 disk
`-vda1                        253:1    0  40G  0 part /
vdb                           253:16   0  10G  0 disk
`-vdb1                        253:17   0  10G  0 part
  `-vg--registry-lv--registry 252:0    0  10G  0 lvm
vdc                           253:32   0  10G  0 disk
`-vdc1                        253:33   0  10G  0 part
  `-vg--apps-lv--apps         252:1    0  10G  0 lvm
[root@node-0 ~]# ll /exports/
total 0
drwxr-xr-x. 2 root root 6 Dec 10 05:23 apps
drwxr-xr-x. 2 root root 6 Dec 10 05:14 registry
[root@node-0 ~]# mount -t xfs /dev/vg
vga_arbiter  vg-apps/     vg-registry/
[root@node-0 ~]# mount -t xfs /dev/vg
vga_arbiter  vg-apps/     vg-registry/
[root@node-0 ~]# mount -t xfs /dev/vg-registry/lv-registry /exports/registry
[root@node-0 ~]# mount -t xfs /dev/vg-apps/lv-apps /exports/apps
[root@node-0 ~]#


[root@node-0 ~]# df -h
Filesystem                             Size  Used Avail Use% Mounted on
/dev/vda1                               40G  2.1G   38G   6% /
devtmpfs                               1.9G     0  1.9G   0% /dev
tmpfs                                  1.9G     0  1.9G   0% /dev/shm
tmpfs                                  1.9G  8.5M  1.9G   1% /run
tmpfs                                  1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs                                  379M     0  379M   0% /run/user/1000
/dev/mapper/vg--registry-lv--registry   10G   33M   10G   1% /exports/registry
/dev/mapper/vg--apps-lv--apps           10G   33M   10G   1% /exports/apps
[root@node-0 ~]#


### Similar process for metric, logging and monitoring NFS too
*I have chosen extra volume available on bastion server*
```sh
mkdir /exports/nfs/metrics -p
mkdir /exports/nfs/logging -p
mkdir /exports/nfs/monitoring -p
```

```sh
lsblk
```

```sh
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    253:0    0  40G  0 disk
`-vda1 253:1    0  40G  0 part /
vdb    253:16   0  10G  0 disk
|-vdb1 253:17   0   3G  0 part
|-vdb2 253:18   0   3G  0 part
`-vdb3 253:19   0   4G  0 part
```

```sh
# export volume prep for metric NFS
pvcreate /dev/vdb1
vgcreate vg-metrics /dev/vdb1
lvcreate -n lv-metrics -l 100%VG vg-metrics
mkfs.xfs /dev/mapper/vg--metrics-lv--metrics
mount -t xfs /dev/vg-metrics/lv-metrics /exports/nfs/metrics
# export volume prep for monitoring NFS
pvcreate /dev/vdb2
vgcreate vg-monitoring /dev/vdb2
lvcreate -n lv-monitoring -l 100%VG vg-monitoring
mkfs.xfs /dev/mapper/vg--monitoring-lv--monitoring
mount -t xfs /dev/vg-monitoring/lv-monitoring /exports/nfs/monitoring

# export volume prep for logging NFS
pvcreate /dev/vdb3
vgcreate vg-logging /dev/vdb3
lvcreate -n lv-logging -l 100%VG vg-logging
mkfs.xfs /dev/mapper/vg--logging-lv--logging
mount -t xfs /dev/vg-logging/lv-logging /exports/nfs/logging
```
Output

```sh
[root@node-0 ~]# lsblk
NAME                              MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda                               253:0    0  40G  0 disk
`-vda1                            253:1    0  40G  0 part /
vdb                               253:16   0  10G  0 disk
|-vdb1                            253:17   0   3G  0 part
| `-vg--metrics-lv--metrics       252:0    0   3G  0 lvm  /exports/nfs/metrics
|-vdb2                            253:18   0   3G  0 part
| `-vg--monitoring-lv--monitoring 252:1    0   3G  0 lvm  /exports/nfs/monitoring
`-vdb3                            253:19   0   4G  0 part
  `-vg--logging-lv--logging       252:2    0   4G  0 lvm  /exports/nfs/logging
```
After changing the exports config file
```sh
cat /etc/exports
```
```sh
/exports/nfs/metrics node-0.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash) node-1.rajranjainfra.lab.pnq2.cee.redhat.com(rw,no_root_squash) node-2.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash)
/exports/nfs/monitoring node-0.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash) node-1.rajranjainfra.lab.pnq2.cee.redhat.com(rw,no_root_squash) node-2.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash)
/exports/nfs/logging node-0.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash) node-1.rajranjainfra.lab.pnq2.cee.redhat.com(rw,no_root_squash) node-2.rajranjainfra.lab.pnq2.cee.redhat.com(rw,root_squash)
```
To verify run exports should be mountable on the infra nodes
```sh
mount -t nfs node-0.rajranjabastion.lab.pnq2.cee.redhat.com:/exports/nfs/metrics /mnt/metrics
```
