### Persistent Volume Objects

```sh
[quicklab@node-0 ~]$ oc get pv
NAME              CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                    STORAGECLASS   REASON    AGE
registry-volume   10Gi       RWX            Retain           Bound     default/registry-claim                            4d


[quicklab@node-0 ~]$ oc get pv/registry-volume -o yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  creationTimestamp: 2019-03-17T17:18:01Z
  finalizers:
  - kubernetes.io/pv-protection
  name: registry-volume
  resourceVersion: "37116"
  selfLink: /api/v1/persistentvolumes/registry-volume
  uid: 9e46e055-48d8-11e9-9cfb-fa163e7ec45b
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 10Gi
  claimRef:
    apiVersion: v1
    kind: PersistentVolumeClaim
    name: registry-claim
    namespace: default
    resourceVersion: "37114"
    uid: a4239405-48d8-11e9-9cfb-fa163e7ec45b
  glusterfs:
    endpoints: glusterfs-registry-endpoints
    path: glusterfs-registry-volume
  persistentVolumeReclaimPolicy: Retain
status:
  phase: Bound
```

### Storage Class

[quicklab@node-0 ~]$ oc get sc
NAME                      PROVISIONER                AGE
glusterfs-storage         kubernetes.io/glusterfs    4d
glusterfs-storage-block   gluster.org/glusterblock   4d

[quicklab@node-0 ~]$ oc get sc glusterfs-storage -o yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  creationTimestamp: 2019-03-17T16:24:38Z
  name: glusterfs-storage
  resourceVersion: "28581"
  selfLink: /apis/storage.k8s.io/v1/storageclasses/glusterfs-storage
  uid: 292f2628-48d1-11e9-adf0-fa163e7ec45b
parameters:
  resturl: http://heketi-storage.app-storage.svc:8080
  restuser: admin
  secretName: heketi-storage-admin-secret
  secretNamespace: app-storage
provisioner: kubernetes.io/glusterfs
reclaimPolicy: Delete
volumeBindingMode: Immediate


[quicklab@node-0 ~]$ oc get sc glusterfs-storage-block -o yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  creationTimestamp: 2019-03-17T16:26:42Z
  name: glusterfs-storage-block
  resourceVersion: "28916"
  selfLink: /apis/storage.k8s.io/v1/storageclasses/glusterfs-storage-block
  uid: 73304a5d-48d1-11e9-adf0-fa163e7ec45b
parameters:
  chapauthenabled: "true"
  hacount: "3"
  restsecretname: heketi-storage-admin-secret-block
  restsecretnamespace: app-storage
  resturl: http://heketi-storage.app-storage.svc:8080
  restuser: admin
provisioner: gluster.org/glusterblock
reclaimPolicy: Delete
volumeBindingMode: Immediate


### Gluster FS Disk Details

[quicklab@node-0 c1-ocp]$ ansible --key quicklab.key -i hosts glusterfs -a 'df -h'
node-3.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem                    Size  Used Avail Use% Mounted on
/dev/vda1                      80G  7.3G   73G  10% /
devtmpfs                      3.8G     0  3.8G   0% /dev
tmpfs                         3.9G     0  3.9G   0% /dev/shm
tmpfs                         3.9G  2.2M  3.9G   1% /run
tmpfs                         3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs                         3.9G  4.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/08828e03-48d1-11e9-9f34-fa163e161366/volumes/kubernetes.io~secret/config
tmpfs                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/08828e03-48d1-11e9-9f34-fa163e161366/volumes/kubernetes.io~secret/heketi-storage-service-account-token-n8kpz
10.10.92.212:heketidbstorage  2.0G   54M  2.0G   3% /var/lib/origin/openshift.local.volumes/pods/08828e03-48d1-11e9-9f34-fa163e161366/volumes/kubernetes.io~glusterfs/db
tmpfs                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/55f4f084-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sync-token-php7c
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/0f3d214649543fade771b4b838f6f39817b9bb648b76d5cfe8254065c9ce9813/merged
shm                            64M     0   64M   0% /var/lib/docker/containers/34c95ee86c8c5651d5ddd01e1ba7202366a7d975937e5206e433578da6731b12/shm
tmpfs                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/a1819a0b-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/8308e27e3f2a7f1bb1f718d7c0592d90bcfde8437a1a774b844a51ab47d0acae/merged
shm                            64M     0   64M   0% /var/lib/docker/containers/a818e1c02848067237dbdd7cd87db370b357f3db6c61d2654469fd6ef9a1cb26/shm
tmpfs                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/ab60a87f-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/0bc72eb9d5c55d36c235a855c087d72e009fa00b16b5a983fc8b56c100fb7b3f/merged
shm                            64M     0   64M   0% /var/lib/docker/containers/50a129fb48a47b20874fa7e07b150a6096e10c7f00740440a420a7069dc35145/shm
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/d4115808c966dc33c8da23ea16464de13e5248c4a4723ad53a8f465a6fd9edfc/merged
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/5046e01e7cd78a4eeb2bec139ff9b07bcd310c91b8b7728910bfe08e41c5c962/merged
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/25a8184ffa39a467653534859425bd68f61bfc9b37dc4766dd558d2a5056c076/merged
shm                            64M     0   64M   0% /var/lib/docker/containers/5a6059a5fd67d5242acb89ca5acd037b166ca068af7b1d712655daa2f0006907/shm
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/f2a796bc6b2e367904cd75aac4b75d52b024f41a964f8bcec1e8968cf1973c71/merged
tmpfs                         3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/b083a9f2-48d7-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/default-token-mxvzc
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/be33f99b42e299c4ba86c79e633f7134368f9bd02650338e6aa93f013f1a5f7d/merged
shm                            64M     0   64M   0% /var/lib/docker/containers/290714b8cdf2bd34014d54076e900b15299dea6d7176a1077d1c2572dcef291c/shm
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/c6431ba89aa0c6e2c4d73dc4ff1662815c3b4ae7939b7526c78933d6eb686060/merged
overlay                        80G  7.3G   73G  10% /var/lib/docker/overlay2/18e9d65d72eb67820c4fa0c38ce6d330974631e719151528e3005e8f8d70b3ef/merged
tmpfs                         783M     0  783M   0% /run/user/1000

node-0.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem                              Size  Used Avail Use% Mounted on
/dev/vda1                                80G  7.2G   73G   9% /
devtmpfs                                3.8G     0  3.8G   0% /dev
tmpfs                                   3.9G     0  3.9G   0% /dev/shm
tmpfs                                   3.9G  2.3M  3.9G   1% /run
tmpfs                                   3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs                                   3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/500a2db6-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sync-token-php7c
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/21de16bcfc3e13e8e43622187fa840730c3ca756803202ff7f9b234490eaf631/merged
shm                                      64M     0   64M   0% /var/lib/docker/containers/1443ccbe903e1c5085cd3d927c9e160d4aa0a69013f5b6704c85cfc62f4acd3f/shm
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/4eb42c0855354d1240932a72a00dace81bb9bef93a8f43a66f000f73cd16a128/merged
tmpfs                                   3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/afb9d107-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/b43eb514838a468bd4b798b0bf528249fdf72308c65b14fb8e5c84fb84416a3c/merged
shm                                      64M     0   64M   0% /var/lib/docker/containers/eef1e23ccbdaa41e920a0a34d416616144dc7b3ccf4d0955d25c0fcdd733342a/shm
tmpfs                                   3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/bf13646f-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/db86c991b1afd7ea7269b9711338211ce70aaa1f74c6e3ea1cd392b6dfca4062/merged
shm                                      64M     0   64M   0% /var/lib/docker/containers/9fcbe2ad2913522c435b75ad92416e0cd04d026da36f2b14dfc27f66d5a76943/shm
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/1bd20f98805075de9ef60892de8823c5d436f464f6812a25712ac3941966f190/merged
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/48b9e464d5f888f2620baaf8e7c99244d4958723c4261566c7347033641a2f12/merged
tmpfs                                   3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/b0840ecb-48d7-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/default-token-mxvzc
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/433b902d4b5964a70f47c1d32be48124cf632fd9b2c3535aaad39c304b0d7110/merged
shm                                      64M     0   64M   0% /var/lib/docker/containers/67c244bf7ab97c2d467803ecde93bf4e3e3e7816f09ead16fe4e312227e35751/shm
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/46cd0461bc4dd5059e14484040906fb753810b75e1527490b152064aab6a8f38/merged
tmpfs                                   3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/36b5b6c4-48d9-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/registry-token-r8t6w
10.10.92.212:glusterfs-registry-volume   10G  363M  9.6G   4% /var/lib/origin/openshift.local.volumes/pods/36b5b6c4-48d9-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~glusterfs/registry-volume
tmpfs                                   3.9G  8.0K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/36b5b6c4-48d9-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/registry-certificates
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/b5125b64b7a0253a49c515ecef7a7cc463bfe1ff194744cfb9e38cac7d38c376/merged
shm                                      64M     0   64M   0% /var/lib/docker/containers/8cee1789100b5d6c2bf5e475f77ff847041f46e23a36a3480ad196564e8e3a13/shm
overlay                                  80G  7.2G   73G   9% /var/lib/docker/overlay2/2069a7c627ff1a18743f01e71f1150f94c732e6015ce727a15b5a47d3293b8c2/merged
tmpfs                                   783M     0  783M   0% /run/user/1000

node-1.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G  7.1G   73G   9% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  2.0M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/5010aba3-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sync-token-php7c
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/9e8c62fb282f56bdd8e4371f6ff041d4b10bf4713eb2183097e319282df4ba1e/merged
shm              64M     0   64M   0% /var/lib/docker/containers/0c1aa9704bbeab633acea54a6a7f161014a23391eaf61a45f5265d49bfb29922/shm
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/f7d29e95bbc31357698997dd705abc9938bcce36e3e489d74eb595e78ebc16cb/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9099e768-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/f5a4f1d7f116644f9da502a0934e79058d7afc21c9bd1aaa3fe66a49e23ab62c/merged
shm              64M     0   64M   0% /var/lib/docker/containers/9ec7c132b46c3d699525694fe4473b5aca11977190289e355ac6e854c82bb605/shm
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/b9260802-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/ab02d423781ce8b623e5f896de0d8733b2f42d9e965719bc89583804992b9d41/merged
shm              64M     0   64M   0% /var/lib/docker/containers/ac0c330c51d18c2a4223eecaff0e5334cb6fe43c34a625043cd1d5910c373274/shm
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/ce8e328442489edf3661028bbf139f5e5d25c2b7fd017aefbe6b9f9a5fc67f93/merged
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/a5c72bbc6acb1223109460b5527c80458856a617bb081ffd7a86fef85a629065/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/b08864f4-48d7-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/default-token-mxvzc
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/3afb86f8fdfecb85df3429a61f7d09fab557a14fa190ac461812a949d263038f/merged
shm              64M     0   64M   0% /var/lib/docker/containers/0afa9410a076c255a4ff12e4e24aff1963faefb6f320f8418ffad5d696a67b56/shm
overlay          80G  7.1G   73G   9% /var/lib/docker/overlay2/12c3e157f02eae5202c954a1a43fcfebae1fdfb7da5da2019be736d5e660ccb1/merged
tmpfs           783M     0  783M   0% /run/user/1000

node-2.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        80G  7.4G   73G  10% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G  2.2M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/53deff43-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sync-token-php7c
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/4e463e06545730ffbee7e57272bb6755ce3869338ce13a51b06250e29a141924/merged
shm              64M     0   64M   0% /var/lib/docker/containers/5f152789a2dd754c5457cc8deb8f472ce2c7e5beae6f0d1d09e151781af3d60c/shm
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/3d811b2f04bbe3af5fbf8cac92bad5687b10adaf4c72a1ffc0097154cb704746/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/9cebacb3-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/c78469f45dae1f1ab3bcf4095514699f4fc9e43ea45457f8802c46c5b717fae1/merged
shm              64M     0   64M   0% /var/lib/docker/containers/20931a01f5a8eb6806b2aa788abfda3bb0247307a2b69d7790bf2c87eb12370d/shm
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/6e802dca195f453593db6a21ddbeeeacda8ba7e8a51ec28eaaef64b689976921/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/a0a0f4f5-48d6-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/sdn-token-4xplq
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/a6464190e16a63c91ec3174a38d6f0d8f160aef41e191c7706adb9fe5f5b7dd3/merged
shm              64M     0   64M   0% /var/lib/docker/containers/7e1b407f202879089e2c3fd7bc9144760170fa734b95c12324c05800c6a31f24/shm
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/ecf5ad1abb369e8be3e46f2cf04acbb4c7b9b76ff64bdb8773fa91c32c2087e0/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/b07ac55e-48d7-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/default-token-mxvzc
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/269d1013ca0f6a30853e12ad0b5e26960e696993171508c810253780106f86e0/merged
shm              64M     0   64M   0% /var/lib/docker/containers/f6ad963d636b7a750800ffb11600b7239c8e615d937bb437c1e8ef1067a1b31d/shm
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/4fbb075225d5f7e6da51e835ee875e8805a3accb0901c3be1496d3bf77ce21e4/merged
tmpfs           3.9G   16K  3.9G   1% /var/lib/origin/openshift.local.volumes/pods/65d5121e-48d8-11e9-a90a-fa163e0bcd4d/volumes/kubernetes.io~secret/glusterblock-storage-provisioner-token-h5ln6
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/10ecf6c6e12b9245714c8193f659fe88ddca39b2dab9f86dd2637633be083270/merged
shm              64M     0   64M   0% /var/lib/docker/containers/3be89b6b79df824f9a4070a3b291643a4c0366a44738c60a2f79ff6ef5dcd835/shm
overlay          80G  7.4G   73G  10% /var/lib/docker/overlay2/0e5269bff4de000788b6d42f3ba751b094492d38a977e8c0c40cc31ae0978152/merged
tmpfs           783M     0  783M   0% /run/user/1000

[quicklab@node-0 c1-ocp]$ nslookup 10.10.92.212
Server:		10.75.5.25
Address:	10.75.5.25#53

Non-authoritative answer:
212.92.10.10.in-addr.arpa	name = node-0.rajranjaregistryocs.lab.rdu2.cee.redhat.com.

Authoritative answers can be found from:

[quicklab@node-0 c1-ocp]$ ansible --key quicklab.key -i hosts glusterfs -a 'lsblk'
node-2.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                               253:0    0   80G  0 disk
`-vda1                                                                            253:1    0   80G  0 part /
vdb                                                                               253:16   0   10G  0 disk
`-vdb1                                                                            253:17   0   10G  0 part
vdc                                                                               253:32   0   10G  0 disk
vdd                                                                               253:48   0   10G  0 disk
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40_tmeta   252:0    0   12M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40-tpool 252:2    0    2G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40     252:3    0    2G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_2d6ad17a1cabdedd75681d254b2ab18d  252:4    0    2G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40_tdata   252:1    0    2G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40-tpool 252:2    0    2G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b3bf443ced5eb08c49d3420583d05b40     252:3    0    2G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_2d6ad17a1cabdedd75681d254b2ab18d  252:4    0    2G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362_tmeta   252:5    0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362-tpool 252:7    0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362     252:8    0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_00f2d07960d294f4c19bb20ba0320362  252:9    0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362_tdata   252:6    0  1.3G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362-tpool 252:7    0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_00f2d07960d294f4c19bb20ba0320362     252:8    0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_00f2d07960d294f4c19bb20ba0320362  252:9    0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc_tmeta   252:10   0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc-tpool 252:12   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc     252:13   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_1dd26a992e370e03de6999bcc0740bbc  252:14   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc_tdata   252:11   0  1.3G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc-tpool 252:12   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_1dd26a992e370e03de6999bcc0740bbc     252:13   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_1dd26a992e370e03de6999bcc0740bbc  252:14   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b_tmeta   252:15   0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b-tpool 252:17   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b     252:18   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_469b6101bd89044db860834bab84cdf3  252:19   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b_tdata   252:16   0  1.3G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b-tpool 252:17   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_99a1bb2988e5017897cb8e54d146d71b     252:18   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_469b6101bd89044db860834bab84cdf3  252:19   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8_tmeta   252:20   0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8-tpool 252:22   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8     252:23   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_9544d6fc0b221d10568f108816bf0362  252:24   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8_tdata   252:21   0  1.3G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8-tpool 252:22   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_3e9e43402aa34e08129a32b87a56c4e8     252:23   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_9544d6fc0b221d10568f108816bf0362  252:24   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a_tmeta   252:25   0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a-tpool 252:27   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a     252:28   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_b9b01dd9963d28493482595f3047498a  252:29   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a_tdata   252:26   0  1.3G  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a-tpool 252:27   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_b9b01dd9963d28493482595f3047498a     252:28   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_b9b01dd9963d28493482595f3047498a  252:29   0  1.3G  0 lvm
|-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7_tmeta   252:30   0    8M  0 lvm
| `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7-tpool 252:32   0  1.3G  0 lvm
|   |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7     252:33   0  1.3G  0 lvm
|   `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_6b9193d09937c6a5b6c8806701541ecc  252:34   0  1.3G  0 lvm
`-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7_tdata   252:31   0  1.3G  0 lvm
  `-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7-tpool 252:32   0  1.3G  0 lvm
    |-vg_e1db8e6b00f4f81d07499eddf4518dc7-tp_2403782d85e7c001b6a87924e7affdb7     252:33   0  1.3G  0 lvm
    `-vg_e1db8e6b00f4f81d07499eddf4518dc7-brick_6b9193d09937c6a5b6c8806701541ecc  252:34   0  1.3G  0 lvm
vde                                                                               253:64   0   10G  0 disk

node-0.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                               253:0    0   80G  0 disk
`-vda1                                                                            253:1    0   80G  0 part /
vdb                                                                               253:16   0   10G  0 disk
`-vdb1                                                                            253:17   0   10G  0 part
vdc                                                                               253:32   0   10G  0 disk
vdd                                                                               253:48   0   10G  0 disk
|-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121_tmeta   252:0    0   12M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121-tpool 252:2    0    2G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121     252:3    0    2G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_3f49001655714c084dc0fa205fcd0121  252:4    0    2G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121_tdata   252:1    0    2G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121-tpool 252:2    0    2G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_3f49001655714c084dc0fa205fcd0121     252:3    0    2G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_3f49001655714c084dc0fa205fcd0121  252:4    0    2G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42_tmeta   252:5    0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42-tpool 252:7    0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42     252:8    0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_e8f93b21f9e17104af5cf150d80d6baa  252:9    0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42_tdata   252:6    0  1.3G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42-tpool 252:7    0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_ec7bc3f02151040c3e4372dba6912e42     252:8    0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_e8f93b21f9e17104af5cf150d80d6baa  252:9    0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5_tmeta   252:10   0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5-tpool 252:12   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5     252:13   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_06214f3a043e5648bf4b4970cf69ecd5  252:14   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5_tdata   252:11   0  1.3G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5-tpool 252:12   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_06214f3a043e5648bf4b4970cf69ecd5     252:13   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_06214f3a043e5648bf4b4970cf69ecd5  252:14   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a_tmeta   252:15   0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a-tpool 252:17   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a     252:18   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_2b7770fbc5fd8a2cf4777ec4b323b24a  252:19   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a_tdata   252:16   0  1.3G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a-tpool 252:17   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_2b7770fbc5fd8a2cf4777ec4b323b24a     252:18   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_2b7770fbc5fd8a2cf4777ec4b323b24a  252:19   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c_tmeta   252:20   0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c-tpool 252:22   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c     252:23   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_6132b3ead6191ef29e92313e0a3cde0c  252:24   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c_tdata   252:21   0  1.3G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c-tpool 252:22   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_6132b3ead6191ef29e92313e0a3cde0c     252:23   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_6132b3ead6191ef29e92313e0a3cde0c  252:24   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf_tmeta   252:25   0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf-tpool 252:27   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf     252:28   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_5ec8b47604c7011c8587206c3d7265bf  252:29   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf_tdata   252:26   0  1.3G  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf-tpool 252:27   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_5ec8b47604c7011c8587206c3d7265bf     252:28   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_5ec8b47604c7011c8587206c3d7265bf  252:29   0  1.3G  0 lvm
|-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f_tmeta   252:30   0    8M  0 lvm
| `-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f-tpool 252:32   0  1.3G  0 lvm
|   |-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f     252:33   0  1.3G  0 lvm
|   `-vg_26a493e506b275239da577d327d4bfee-brick_0284daa19b4096f8d1c4173154f2441f  252:34   0  1.3G  0 lvm
`-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f_tdata   252:31   0  1.3G  0 lvm
  `-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f-tpool 252:32   0  1.3G  0 lvm
    |-vg_26a493e506b275239da577d327d4bfee-tp_0284daa19b4096f8d1c4173154f2441f     252:33   0  1.3G  0 lvm
    `-vg_26a493e506b275239da577d327d4bfee-brick_0284daa19b4096f8d1c4173154f2441f  252:34   0  1.3G  0 lvm
vde                                                                               253:64   0   10G  0 disk

node-3.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                               253:0    0   80G  0 disk
`-vda1                                                                            253:1    0   80G  0 part /
vdb                                                                               253:16   0   10G  0 disk
`-vdb1                                                                            253:17   0   10G  0 part
vdc                                                                               253:32   0   10G  0 disk
vdd                                                                               253:48   0   10G  0 disk
|-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5_tmeta   252:0    0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5-tpool 252:2    0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5     252:3    0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_6216949a80b81b706914f9e5e1cad8ba  252:4    0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5_tdata   252:1    0  1.3G  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5-tpool 252:2    0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_7b9349818a4bde35bb181839bfc79ad5     252:3    0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_6216949a80b81b706914f9e5e1cad8ba  252:4    0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003_tmeta   252:5    0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003-tpool 252:7    0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003     252:8    0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_27274fbebaea34c4746e8f2e471ef003  252:9    0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003_tdata   252:6    0  1.3G  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003-tpool 252:7    0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_27274fbebaea34c4746e8f2e471ef003     252:8    0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_27274fbebaea34c4746e8f2e471ef003  252:9    0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d_tmeta   252:10   0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d-tpool 252:12   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d     252:13   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_d11248a8449b70acaab17316de0bce0d  252:14   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d_tdata   252:11   0  1.3G  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d-tpool 252:12   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_d11248a8449b70acaab17316de0bce0d     252:13   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_d11248a8449b70acaab17316de0bce0d  252:14   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34_tmeta   252:15   0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34-tpool 252:17   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34     252:18   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_d3fa33221ac6c3140c7f7029ca6ba9c7  252:19   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34_tdata   252:16   0  1.3G  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34-tpool 252:17   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_488fea965b837949eb19db1f547aaf34     252:18   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_d3fa33221ac6c3140c7f7029ca6ba9c7  252:19   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2_tmeta   252:20   0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2-tpool 252:22   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2     252:23   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_c3ed04974045472905847d69eac74a99  252:24   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2_tdata   252:21   0  1.3G  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2-tpool 252:22   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_cfcb0d9987e3c153a4cdc716c2b74cf2     252:23   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_c3ed04974045472905847d69eac74a99  252:24   0  1.3G  0 lvm
|-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c_tmeta   252:25   0    8M  0 lvm
| `-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c-tpool 252:27   0  1.3G  0 lvm
|   |-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c     252:28   0  1.3G  0 lvm
|   `-vg_99981852b31751b73855ba6bf03c75aa-brick_c2cc3bf0bffff1128f53416071b2013c  252:29   0  1.3G  0 lvm
`-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c_tdata   252:26   0  1.3G  0 lvm
  `-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c-tpool 252:27   0  1.3G  0 lvm
    |-vg_99981852b31751b73855ba6bf03c75aa-tp_c2cc3bf0bffff1128f53416071b2013c     252:28   0  1.3G  0 lvm
    `-vg_99981852b31751b73855ba6bf03c75aa-brick_c2cc3bf0bffff1128f53416071b2013c  252:29   0  1.3G  0 lvm
vde                                                                               253:64   0   10G  0 disk

node-1.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
NAME                                                                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
vda                                                                               253:0    0   80G  0 disk
`-vda1                                                                            253:1    0   80G  0 part /
vdb                                                                               253:16   0   10G  0 disk
`-vdb1                                                                            253:17   0   10G  0 part
vdc                                                                               253:32   0   10G  0 disk
vdd                                                                               253:48   0   10G  0 disk
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc_tmeta   252:0    0   12M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc-tpool 252:2    0    2G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc     252:3    0    2G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_998fa858a33b98b882da70f7fa93fabc  252:4    0    2G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc_tdata   252:1    0    2G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc-tpool 252:2    0    2G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_998fa858a33b98b882da70f7fa93fabc     252:3    0    2G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_998fa858a33b98b882da70f7fa93fabc  252:4    0    2G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d_tmeta   252:5    0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d-tpool 252:7    0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d     252:8    0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_f4a7699bf92159e1cb526cb5f04bca5d  252:9    0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d_tdata   252:6    0  1.3G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d-tpool 252:7    0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_f4a7699bf92159e1cb526cb5f04bca5d     252:8    0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_f4a7699bf92159e1cb526cb5f04bca5d  252:9    0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07_tmeta   252:10   0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07-tpool 252:12   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07     252:13   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_4fa5c06342bf126f8a7902305f624b07  252:14   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07_tdata   252:11   0  1.3G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07-tpool 252:12   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4fa5c06342bf126f8a7902305f624b07     252:13   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_4fa5c06342bf126f8a7902305f624b07  252:14   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8_tmeta   252:15   0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8-tpool 252:17   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8     252:18   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_4cc06f6d8c84eb90e0cf8fc3248305a8  252:19   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8_tdata   252:16   0  1.3G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8-tpool 252:17   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_4cc06f6d8c84eb90e0cf8fc3248305a8     252:18   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_4cc06f6d8c84eb90e0cf8fc3248305a8  252:19   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208_tmeta   252:20   0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208-tpool 252:22   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208     252:23   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_41ac1bab8c4eb87f09e3420ddcc77208  252:24   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208_tdata   252:21   0  1.3G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208-tpool 252:22   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_41ac1bab8c4eb87f09e3420ddcc77208     252:23   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_41ac1bab8c4eb87f09e3420ddcc77208  252:24   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c_tmeta   252:25   0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c-tpool 252:27   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c     252:28   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_efd63da3f546b885f0497f775e70a64c  252:29   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c_tdata   252:26   0  1.3G  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c-tpool 252:27   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_efd63da3f546b885f0497f775e70a64c     252:28   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_efd63da3f546b885f0497f775e70a64c  252:29   0  1.3G  0 lvm
|-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54_tmeta   252:30   0    8M  0 lvm
| `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54-tpool 252:32   0  1.3G  0 lvm
|   |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54     252:33   0  1.3G  0 lvm
|   `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_8c8fd2a1ae58b6f305ee5076d78d4112  252:34   0  1.3G  0 lvm
`-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54_tdata   252:31   0  1.3G  0 lvm
  `-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54-tpool 252:32   0  1.3G  0 lvm
    |-vg_a033bd011e7c80dafccf098a92ce5c72-tp_1da65c56c28344bd468f6dfcbace0f54     252:33   0  1.3G  0 lvm
    `-vg_a033bd011e7c80dafccf098a92ce5c72-brick_8c8fd2a1ae58b6f305ee5076d78d4112  252:34   0  1.3G  0 lvm
vde                                                                               253:64   0   10G  0 disk



[quicklab@node-0 c1-ocp]$ ansible --key quicklab.key -i hosts glusterfs -a 'ip addr' | egrep -i 'node-|eth0'
node-0.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.10.92.212/22 brd 10.10.95.255 scope global noprefixroute dynamic eth0
node-3.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.10.92.219/22 brd 10.10.95.255 scope global noprefixroute dynamic eth0
node-1.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.10.92.69/22 brd 10.10.95.255 scope global noprefixroute dynamic eth0
node-2.rajranjaregistryocs.lab.rdu2.cee.redhat.com | SUCCESS | rc=0 >>
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.10.92.66/22 brd 10.10.95.255 scope global noprefixroute dynamic eth0


### HEKETI DETAILS

[quicklab@node-0 c1-ocp]$ curl -w '\n' ${HEKETI_CLI_SERVER}/hello
Hello from Heketi
[quicklab@node-0 c1-ocp]$ clear
[quicklab@node-0 c1-ocp]$ heketi-cli cluster list
Clusters:
Id:638518ec2954889dc3b9c4b58b708195 [file][block]
[quicklab@node-0 c1-ocp]$ heketi-cli topology info

Cluster Id: 638518ec2954889dc3b9c4b58b708195

    File:  true
    Block: true

    Volumes:

	Name: heketidbstorage
	Size: 2
	Id: 153bdba9d16001fb27d1ab72f492be9f
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Mount: 10.10.92.66:heketidbstorage
	Mount Options: backup-volfile-servers=10.10.92.69,10.10.92.219,10.10.92.212
	Durability Type: replicate
	Replica: 3
	Snapshot: Disabled

		Bricks:
			Id: 2d6ad17a1cabdedd75681d254b2ab18d
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_2d6ad17a1cabdedd75681d254b2ab18d/brick
			Size (GiB): 2
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: 3f49001655714c084dc0fa205fcd0121
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_3f49001655714c084dc0fa205fcd0121/brick
			Size (GiB): 2
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 998fa858a33b98b882da70f7fa93fabc
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_998fa858a33b98b882da70f7fa93fabc/brick
			Size (GiB): 2
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72


	Name: glusterfs-registry-volume
	Size: 10
	Id: ecf502bcde88caafe718f46cd05ce6a6
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Mount: 10.10.92.66:glusterfs-registry-volume
	Mount Options: backup-volfile-servers=10.10.92.69,10.10.92.219,10.10.92.212
	Durability Type: replicate
	Replica: 3
	Snapshot: Disabled

		Bricks:
			Id: 00f2d07960d294f4c19bb20ba0320362
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_00f2d07960d294f4c19bb20ba0320362/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: 0284daa19b4096f8d1c4173154f2441f
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_0284daa19b4096f8d1c4173154f2441f/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 06214f3a043e5648bf4b4970cf69ecd5
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_06214f3a043e5648bf4b4970cf69ecd5/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 1dd26a992e370e03de6999bcc0740bbc
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_1dd26a992e370e03de6999bcc0740bbc/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: 27274fbebaea34c4746e8f2e471ef003
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_27274fbebaea34c4746e8f2e471ef003/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: 2b7770fbc5fd8a2cf4777ec4b323b24a
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_2b7770fbc5fd8a2cf4777ec4b323b24a/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 41ac1bab8c4eb87f09e3420ddcc77208
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_41ac1bab8c4eb87f09e3420ddcc77208/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72

			Id: 469b6101bd89044db860834bab84cdf3
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_469b6101bd89044db860834bab84cdf3/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: 4cc06f6d8c84eb90e0cf8fc3248305a8
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_4cc06f6d8c84eb90e0cf8fc3248305a8/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72

			Id: 4fa5c06342bf126f8a7902305f624b07
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_4fa5c06342bf126f8a7902305f624b07/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72

			Id: 5ec8b47604c7011c8587206c3d7265bf
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_5ec8b47604c7011c8587206c3d7265bf/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 6132b3ead6191ef29e92313e0a3cde0c
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_6132b3ead6191ef29e92313e0a3cde0c/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: 6216949a80b81b706914f9e5e1cad8ba
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_6216949a80b81b706914f9e5e1cad8ba/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: 6b9193d09937c6a5b6c8806701541ecc
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_6b9193d09937c6a5b6c8806701541ecc/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: 8c8fd2a1ae58b6f305ee5076d78d4112
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_8c8fd2a1ae58b6f305ee5076d78d4112/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72

			Id: 9544d6fc0b221d10568f108816bf0362
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_9544d6fc0b221d10568f108816bf0362/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: b9b01dd9963d28493482595f3047498a
			Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_b9b01dd9963d28493482595f3047498a/brick
			Size (GiB): 1
			Node: 3fe0835b0a4e1c4def0eba0648c669da
			Device: e1db8e6b00f4f81d07499eddf4518dc7

			Id: c2cc3bf0bffff1128f53416071b2013c
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_c2cc3bf0bffff1128f53416071b2013c/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: c3ed04974045472905847d69eac74a99
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_c3ed04974045472905847d69eac74a99/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: d11248a8449b70acaab17316de0bce0d
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_d11248a8449b70acaab17316de0bce0d/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: d3fa33221ac6c3140c7f7029ca6ba9c7
			Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_d3fa33221ac6c3140c7f7029ca6ba9c7/brick
			Size (GiB): 1
			Node: 74533cd42d8c27163f613d753093b5b9
			Device: 99981852b31751b73855ba6bf03c75aa

			Id: e8f93b21f9e17104af5cf150d80d6baa
			Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_e8f93b21f9e17104af5cf150d80d6baa/brick
			Size (GiB): 1
			Node: ce36543d481b49c2c9ab02e80fca63e2
			Device: 26a493e506b275239da577d327d4bfee

			Id: efd63da3f546b885f0497f775e70a64c
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_efd63da3f546b885f0497f775e70a64c/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72

			Id: f4a7699bf92159e1cb526cb5f04bca5d
			Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_f4a7699bf92159e1cb526cb5f04bca5d/brick
			Size (GiB): 1
			Node: 4c424da42aa7f43a0e5e1d703b6b4b47
			Device: a033bd011e7c80dafccf098a92ce5c72


    Nodes:

	Node Id: 3fe0835b0a4e1c4def0eba0648c669da
	State: online
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Zone: 1
	Management Hostnames: node-2.rajranjaregistryocs.lab.rdu2.cee.redhat.com
	Storage Hostnames: 10.10.92.66
	Devices:
		Id:e1db8e6b00f4f81d07499eddf4518dc7   Name:/dev/vdd            State:online    Size (GiB):9       Used (GiB):9       Free (GiB):0
			Bricks:
				Id:00f2d07960d294f4c19bb20ba0320362   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_00f2d07960d294f4c19bb20ba0320362/brick
				Id:1dd26a992e370e03de6999bcc0740bbc   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_1dd26a992e370e03de6999bcc0740bbc/brick
				Id:2d6ad17a1cabdedd75681d254b2ab18d   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_2d6ad17a1cabdedd75681d254b2ab18d/brick
				Id:469b6101bd89044db860834bab84cdf3   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_469b6101bd89044db860834bab84cdf3/brick
				Id:6b9193d09937c6a5b6c8806701541ecc   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_6b9193d09937c6a5b6c8806701541ecc/brick
				Id:9544d6fc0b221d10568f108816bf0362   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_9544d6fc0b221d10568f108816bf0362/brick
				Id:b9b01dd9963d28493482595f3047498a   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_e1db8e6b00f4f81d07499eddf4518dc7/brick_b9b01dd9963d28493482595f3047498a/brick

	Node Id: 4c424da42aa7f43a0e5e1d703b6b4b47
	State: online
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Zone: 1
	Management Hostnames: node-1.rajranjaregistryocs.lab.rdu2.cee.redhat.com
	Storage Hostnames: 10.10.92.69
	Devices:
		Id:a033bd011e7c80dafccf098a92ce5c72   Name:/dev/vdd            State:online    Size (GiB):9       Used (GiB):9       Free (GiB):0
			Bricks:
				Id:41ac1bab8c4eb87f09e3420ddcc77208   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_41ac1bab8c4eb87f09e3420ddcc77208/brick
				Id:4cc06f6d8c84eb90e0cf8fc3248305a8   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_4cc06f6d8c84eb90e0cf8fc3248305a8/brick
				Id:4fa5c06342bf126f8a7902305f624b07   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_4fa5c06342bf126f8a7902305f624b07/brick
				Id:8c8fd2a1ae58b6f305ee5076d78d4112   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_8c8fd2a1ae58b6f305ee5076d78d4112/brick
				Id:998fa858a33b98b882da70f7fa93fabc   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_998fa858a33b98b882da70f7fa93fabc/brick
				Id:efd63da3f546b885f0497f775e70a64c   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_efd63da3f546b885f0497f775e70a64c/brick
				Id:f4a7699bf92159e1cb526cb5f04bca5d   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_a033bd011e7c80dafccf098a92ce5c72/brick_f4a7699bf92159e1cb526cb5f04bca5d/brick

	Node Id: 74533cd42d8c27163f613d753093b5b9
	State: online
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Zone: 1
	Management Hostnames: node-3.rajranjaregistryocs.lab.rdu2.cee.redhat.com
	Storage Hostnames: 10.10.92.219
	Devices:
		Id:99981852b31751b73855ba6bf03c75aa   Name:/dev/vdd            State:online    Size (GiB):9       Used (GiB):7       Free (GiB):2
			Bricks:
				Id:27274fbebaea34c4746e8f2e471ef003   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_27274fbebaea34c4746e8f2e471ef003/brick
				Id:6216949a80b81b706914f9e5e1cad8ba   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_6216949a80b81b706914f9e5e1cad8ba/brick
				Id:c2cc3bf0bffff1128f53416071b2013c   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_c2cc3bf0bffff1128f53416071b2013c/brick
				Id:c3ed04974045472905847d69eac74a99   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_c3ed04974045472905847d69eac74a99/brick
				Id:d11248a8449b70acaab17316de0bce0d   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_d11248a8449b70acaab17316de0bce0d/brick
				Id:d3fa33221ac6c3140c7f7029ca6ba9c7   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_99981852b31751b73855ba6bf03c75aa/brick_d3fa33221ac6c3140c7f7029ca6ba9c7/brick

	Node Id: ce36543d481b49c2c9ab02e80fca63e2
	State: online
	Cluster Id: 638518ec2954889dc3b9c4b58b708195
	Zone: 1
	Management Hostnames: node-0.rajranjaregistryocs.lab.rdu2.cee.redhat.com
	Storage Hostnames: 10.10.92.212
	Devices:
		Id:26a493e506b275239da577d327d4bfee   Name:/dev/vdd            State:online    Size (GiB):9       Used (GiB):9       Free (GiB):0
			Bricks:
				Id:0284daa19b4096f8d1c4173154f2441f   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_0284daa19b4096f8d1c4173154f2441f/brick
				Id:06214f3a043e5648bf4b4970cf69ecd5   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_06214f3a043e5648bf4b4970cf69ecd5/brick
				Id:2b7770fbc5fd8a2cf4777ec4b323b24a   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_2b7770fbc5fd8a2cf4777ec4b323b24a/brick
				Id:3f49001655714c084dc0fa205fcd0121   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_3f49001655714c084dc0fa205fcd0121/brick
				Id:5ec8b47604c7011c8587206c3d7265bf   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_5ec8b47604c7011c8587206c3d7265bf/brick
				Id:6132b3ead6191ef29e92313e0a3cde0c   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_6132b3ead6191ef29e92313e0a3cde0c/brick
				Id:e8f93b21f9e17104af5cf150d80d6baa   Size (GiB):1       Path: /var/lib/heketi/mounts/vg_26a493e506b275239da577d327d4bfee/brick_e8f93b21f9e17104af5cf150d80d6baa/brick
[quicklab@node-0 c1-ocp]$