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

* 

oc adm policy add-scc-to-group hostaccess system:serviceaccounts:openshift-logging


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