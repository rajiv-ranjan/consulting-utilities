### Version of NFS

* Using **nfsstat**

|Commands|Purpose|
|----|----|
|nfsstat -m|To get the details of the nfs mounts on the client side|
|nfsstat -s|To get nfs statistics on the server side|
|nfsstat -c|To get nfs statistics on the client side|
|nfsstat -n|To get only nfs stats, ignoring RPC data|
|nfsstat -r|To get only RPC stats, ignoring nfs data|
|nfsstat -o all|To get all details|

* using **yum** 

```sh
$ sudo yum --version nfs
Failed to set locale, defaulting to C
3.4.3

  Installed: rpm-4.11.3-35.el7.x86_64 at 2018-12-09 07:22
  Built    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla> at 2018-06-19 12:48
  Committed: Pavlina Moravcova Varekova <pmoravco@redhat.com> at 2018-06-19

  Installed: subscription-manager-1.21.10-3.el7_6.x86_64 at 2018-12-09 07:23
  Built    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla> at 2018-11-07 19:14
  Committed: Christopher Snyder <csnyder@redhat.com> at 2018-11-07

  Installed: yum-3.4.3-161.el7.noarch at 2018-12-09 07:22
  Built    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla> at 2018-08-15 16:10
  Committed: Michal Domonkos <mdomonko@redhat.com> at 2018-08-15
[quicklab@node-0 c1-ocp]$
```
* Using **rpm**

```sh
$ rpm -qa *nfs*
libnfsidmap-0.25-19.el7.x86_64
nfs-utils-1.3.0-0.61.el7.x86_64

$ rpm -qa rpcbind
rpcbind-0.2.0-47.el7.x86_64
```
### Start a nfs server

```sh
# systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.

# systemctl start nfs

# systemctl status nfs
● nfs-server.service - NFS server and services
   Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; enabled; vendor preset: disabled)
   Active: active (exited) since Mon 2018-12-10 01:40:07 EST; 4s ago
  Process: 5336 ExecStartPost=/bin/sh -c if systemctl -q is-active gssproxy; then systemctl restart gssproxy ; fi (code=exited, status=0/SUCCESS)
  Process: 5318 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS (code=exited, status=0/SUCCESS)
  Process: 5317 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)
 Main PID: 5318 (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/nfs-server.service

# systemctl status rpcbind
● rpcbind.service - RPC bind service
   Loaded: loaded (/usr/lib/systemd/system/rpcbind.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2018-12-09 11:58:43 EST; 13h ago
 Main PID: 2186 (rpcbind)
   CGroup: /system.slice/rpcbind.service
           └─2186 /sbin/rpcbind -w
```

## Manually Exporting File System


## Automatically Exporting File System
* edit the exportfs config file at /etc/exports

```sh
# cat /etc/exports
/exports/test nfsclient(rw,root_squash,insecure) nfsclientSecond(rw,no_root_squash,insecure)
```

* reload the nfs. There are couple of ways

```sh
### option 1: exportfs command with -r = reexport, -a = all, -v = verbose
exportfs -var 

### option 2
# systemctl restart nfs

### option 3
# reboot
```

* check the exported fs 

```sh
exportfs
```

* check the nfs etab file that gets updated after the export

```sh
### check the configuration that was made by exportfs
# cat /var/lib/nfs/etab

### list of actively mounted nfs are found in rmtab file
# cat /var/lib/nfs/rmtab

```


## Mounting NFS Exports
### manual
Mount the nfs export on the client machine.

```sh
# mount -t nfs nfsserver:/exports/test /mnt/test
# ls -lrt /mnt/test
```

### automatically
* Mount the nfs export by editing the /etc/fstab file

```sh
# cat /etc/fstab
nfsserver:/export/test  /mnt/test   nfs defaults    0   0
```

* instruct the mount to re-read the configs

```sh
# mount -va
```

* check the global nfsmount.conf file to see the defaults that were used

```sh
# cat /etc/fsmount.conf
```
Global config can be over ridden in /etc/fstab by specifying the options. For more details see **man nfs**


|Commands|Purpose|
|----|----|
|exportfs -ua|To unexport all previous exported fs|
|||

