```sh
# oc get clusternetwork default
```
* check the node from one of the master as root

```sh
# oc get nodes --all-namespaces  --show-labels
```

* check for etcd cluster health and member list

```sh
# etcdctl -C https://node-0.rajranjamaster.lab.pnq2.cee.redhat.com:2379,node-1.rajranjamaster.lab.pnq2.cee.redhat.com:2379,node-2.rajranjamaster.lab.pnq2.cee.redhat.com:2379 --ca-file=/etc/origin/master/master.etcd-ca.crt --cert-file=/etc/origin/master/master.etcd-client.crt     --key-file=/etc/origin/master/master.etcd-client.key cluster-health

member 115f036007cac1cb is healthy: got healthy result from https://10.74.176.219:2379
member ce773634ffc7c48c is healthy: got healthy result from https://10.74.176.18:2379
member ea703480af08da7d is healthy: got healthy result from https://10.74.176.74:2379
cluster is healthy



# etcdctl -C https://node-0.rajranjamaster.lab.pnq2.cee.redhat.com:2379,node-1.rajranjamaster.lab.pnq2.cee.redhat.com:2379,node-2.rajranjamaster.lab.pnq2.cee.redhat.com:2379 \
--ca-file=/etc/origin/master/master.etcd-ca.crt \
--cert-file=/etc/origin/master/master.etcd-client.crt \
--key-file=/etc/origin/master/master.etcd-client.key member list

115f036007cac1cb: name=node-2.rajranjamaster.lab.pnq2.cee.redhat.com peerURLs=https://10.74.176.219:2380 clientURLs=https://10.74.176.219:2379 isLeader=true
ce773634ffc7c48c: name=node-0.rajranjamaster.lab.pnq2.cee.redhat.com peerURLs=https://10.74.176.18:2380 clientURLs=https://10.74.176.18:2379 isLeader=false
ea703480af08da7d: name=node-1.rajranjamaster.lab.pnq2.cee.redhat.com peerURLs=https://10.74.176.74:2380 clientURLs=https://10.74.176.74:2379 isLeader=false

```

* check and configure infra nodes Load Balancer (HAProxy)
check the HAProxy urls i.e. http://lbserver:9000

### make configuration changes to master and nodes
* password changes via htpasswd on masters
* configure users to allow access to the cluster
* 

### Config metrics
* Create the metric PV 
* Config the inventory file and run the ansible-playbook


### Top Cluster Admin Tasks
* install oc client
```sh
yum install -y atomic-openshift-clients.x86_64
```

* User managements - create users with required roles https://access.redhat.com/documentation/en-us/openshift_container_platform/3.11/html-single/architecture/#roles
* 