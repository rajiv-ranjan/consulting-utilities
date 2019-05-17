lsblk
fdisk /dev/vdc
partprobe
partx -u /dev/vdc
lsblk
pvcreate /dev/vdc1
pvcreate /dev/vdc2
pvs
vgcreate vg00 /dev/vdc1
vgcreate vg01 /dev/vdc2
lvcreate -n vol_logging -l 100%FREE vg00
lvcreate -n vol_logging_ops -l 100%FREE vg01
lvs
lvdisplay
mkfs.xfs /dev/vg00/vol_logging
mkfs.xfs /dev/vg01/vol_logging_ops
blkid /dev/vg00/vol_logging
blkid /dev/vg01/vol_logging_ops
mkdir /logging
mkdir /logging_ops
vi /etc/fstab
mount -a
df -h

* the service account of namespace openshift-logging will need access to the host path

```sh
# RECOMMENDED: if a hostaccess is required to be given to all the SA in a namespace then please use below
oc adm policy add-scc-to-group hostaccess system:serviceaccounts:openshift-logging

# if a hostaccess is required to be given to a specfic SA then use below from any namespace
oc adm policy add-scc-to-user hostaccess system:serviceaccounts:openshift-logging:aggregated-logging-elasticsearch

# if a hostaccess is required to be given to a specfic SA then use below from openshift-logging namespace
oc adm policy add-scc-to-user hostaccess -z aggregated-logging-elasticsearch

```sh

* Change the ownership of the folder on the local VM to be used by the project's scc fsGroup
```sh
sudo chown -R 1000080000:1000080000 /logging
sudo chown -R 1000080000:1000080000 /logging_ops
```
* Change the SELinux labels for the logging mount point. Make all volumes accessible to the processes running within the containers. You can change the labels of mounted file systems to allow this.

```sh
chcon -R unconfined_u:object_r:svirt_sandbox_file_t:s0 /logging
chcon -R unconfined_u:object_r:svirt_sandbox_file_t:s0 /logging_ops/
```

* Update all dc to point to host path.
```sh
oc set volume deploymentconfig.apps.openshift.io/logging-es-data-master-0uix5k9b --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging
oc set volume deploymentconfig.apps.openshift.io/logging-es-data-master-misholdu --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging
oc set volume deploymentconfig.apps.openshift.io/logging-es-data-master-r34l5x6z --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging

oc set volume deploymentconfig.apps.openshift.io/logging-es-ops-data-master-152tknrs --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging_ops
oc set volume deploymentconfig.apps.openshift.io/logging-es-ops-data-master-2rd3tite --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging_ops
oc set volume deploymentconfig.apps.openshift.io/logging-es-ops-data-master-uif852k7 --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=hostPath --path=/logging_ops
```
* Roll out the latest
```sh
oc rollout latest dc/logging-es-data-master-0uix5k9b
oc rollout latest dc/logging-es-data-master-misholdu
oc rollout latest dc/logging-es-data-master-r34l5x6z

oc rollout latest dc/logging-es-ops-data-master-152tknrs
oc rollout latest dc/logging-es-ops-data-master-2rd3tite
oc rollout latest dc/logging-es-ops-data-master-uif852k7
```


* TODO How to remove the volume and add that to the existing storage at hostpath. E.g. remove logging_ops and merge the volume to logging
```sh
lvs
vgs
pvs
df -hP | grep -i logging_ops
# delete the entry for logging_ops
vim /etc/fstab
umount /logging_ops
lvchange -an /dev/mapper/vg01-vol_logging_ops
lvremove /dev/mapper/vg01-vol_logging_ops
vgchange -an vg01
vgremove vg01

# check if the pv is available
pvs

[root@node-1 ~]# pvs
  PV         VG        Fmt  Attr PSize   PFree
  /dev/vdb1  docker-vg lvm2 a--  <10.00g <10.00g
  /dev/vdc1  vg00      lvm2 a--   <5.00g      0
  /dev/vdc2            lvm2 ---   <5.00g  <5.00g

vgextend vg00 /dev/vdc2
lvextend -L +5100M /dev/mapper/vg00-vol_logging
xfs_growfs /dev/mapper/vg00-vol_logging
df -hP /logging
```