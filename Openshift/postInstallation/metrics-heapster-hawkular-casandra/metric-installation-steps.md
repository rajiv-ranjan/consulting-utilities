## Using local volume provisioner - Its in tech preview in 3.11
### configure local volume
> https://access.redhat.com/documentation/en-us/openshift_container_platform/3.11/html-single/configuring_clusters/#install-config-configuring-local

* get a list of devices available

```sh
ansible -i /home/quicklab/c1-ocp/hosts --key-file=/home/quicklab/c1-ocp/quicklab.key nodes -a 'ls -lrt /dev/disk/by-path'
```

* fdisk the device

```sh
# fdisk /dev/vdc
# partprobe
# lsblk
```

* make the new partition as xfs
  
```sh
mkfs.xfs /dev/vdc1
```

* mount the partion under /mnt/local-storage/

```sh
# mkdir -p /mnt/local-storage/virtual/metric-disk
# mount /dev/vdc1 /mnt/local-storage/virtual/metric-disk
# df -hT | grep -i metric
# blkid
```

* make the mount changes in fstab

```sh
# cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Thu Mar 22 19:04:42 2018
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=6bea2b7b-e6cc-4dba-ac79-be6530d348f5 /                       xfs     defaults        0 0
UUID=36387aaa-2de5-46c6-bb75-fc0bd0abf31a /mnt/local-storage/virtual/metric-disk	xfs	defaults        1 2

```
* change the label of the file system

```sh 
# chcon -R unconfined_u:object_r:svirt_sandbox_file_t:s0 /mnt/local-storage/
```


### Steps to create local volume provisioning
* create the namespace

```sh
# oc new-project local-storage

```

* remove the node selector from the project

oc patch namespace local-storage \
    -p '{"metadata": {"annotations": {"openshift.io/node-selector": ""}}}'

oc create -f config-map-local-volume-storage.yml

oc create serviceaccount local-storage-admin

oc adm policy add-scc-to-user privileged -z local-storage-admin

cd /home/quicklab/c1-ocp/metrics && wget https://raw.githubusercontent.com/openshift/origin/release-3.11/examples/storage-examples/local-examples/local-storage-provisioner-template.yaml

oc create -f /home/quicklab/c1-ocp/metrics/storage-class-metrics.yml 

oc new-app -p CONFIGMAP=local-volume-config \
  -p SERVICE_ACCOUNT=local-storage-admin \
  -p NAMESPACE=local-storage \
  -p PROVISIONER_IMAGE=registry.redhat.io/openshift3/local-storage-provisioner:v3.11 \
  --labels="app=local-storage-provisioner-label" \
  --template=local-storage/local-storage-provisioner

## Using NFS exports as pv

## Steps to run the metrics installer

#### inventory file looks like below for local volume based metric
```ini
############## METRICS #################
openshift_metrics_install_metrics=true
openshift_metrics_duration=5
openshift_metrics_resolution=1m
openshift_metrics_cassandra_pvc_size=10Gi
openshift_metrics_cassandra_pvc_storage_class_name=local-virtualdisk-metric
openshift_metrics_cassandra_storage_type=pv
openshift_metrics_cassandra_replicas=3
```

#### inventory file for nfs based metrics
```ini
############## METRICS #################
openshift_metrics_install_metrics=true
openshift_metrics_duration=1
openshift_metrics_resolution=15s
openshift_metrics_cassandra_pvc_size=3Gi
#openshift_metrics_cassandra_pvc_storage_class_name=local-virtualdisk-metric
openshift_metrics_cassandra_storage_type=pv
openshift_metrics_cassandra_replicas=1
openshift_metrics_cassandra_nodeselector={"node-role.kubernetes.io/infra":"true"}
openshift_metrics_hawkular_nodeselector={"node-role.kubernetes.io/infra":"true"}
openshift_metrics_heapster_nodeselector={"node-role.kubernetes.io/infra":"true"}
```
Also follow the below links 
1. Set the ownership of the NFS export on the server to nfsnobody:nfsnobody 

```sh
chown nfsnobody:nfsnobody -R /exports/nfs/metrics
chown nfsnobody:nfsnobody -R /exports/nfs/monitoring
chown nfsnobody:nfsnobody -R /exports/nfs/logging
```
2. Disabling ID mapping on NFSv4 if using NFS v4 server

```sh
# On both the NFS client and server, run
echo 'Y' > /sys/module/nfsd/parameters/nfs4_disable_idmapping
```

3. If there are permission related challenges in pods post installation then follow the article 
   * https://access.redhat.com/solutions/2688571#perms