#### Prerequisite checklist 
* router is deployed and working
* 1 PV per es replica is required - follow the instruction in nfsSetup.md for nfs pv.
* decide on the HA for es
* if EFK has to be installed to a separate node then delete the default logging project created and recreate with specific name space else it can be left for installer to use.
```sh
oc projects
oc patch namespace openshift-logging -p '{"metadata":{"annotations":{"openshift.io/node-selector":"node-role.kubernetes.io/infra=true"}}}'
# or
oc delete project openshift-logging
oc adm new-project openshift-logging --node-selector='node-role.kubernetes.io/infra=true'
# check using below
oc get node --selector='node-role.kubernetes.io/infra=true'
```
>To control component placement; make sure all components have there node selector mentioned. This may not be required for empty node selector.

> TODO get the working ansible-vars here

#### If issues with storage is faced then apply below commnds to prepare pv
> TODO

* get the selinux tag and supplement group id from the project
```sh
oc get project openshift-logging -o yaml
```
* add the labels accordingly

```sh
chcon -R system_u:object_r:svirt_sandbox_file_t:s0:c1,c0 /<storage_path>/
chown -R 1000000000:1000000000 /<storage_path>/
```
* create the pv
```sh
oc create -f pv-es.yaml
```





#### to reset the pv attached in case elasticsearch is unable to write data
* set the volume to emptyDir to test
oc set volume deploymentconfig.apps.openshift.io/logging-es-data-master-20rr74d5 --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=emptyDir

oc set volume deploymentconfig.apps.openshift.io/logging-es-data-master-20rr74d5 --add --overwrite --name=elasticsearch-storage --containers=elasticsearch --mount-path=/elasticsearch/persistent --type=persistentVolumeClaim --claim-name=logging-es-2

/usr/share/elasticsearch/plugins/openshift-elasticsearch/sgadmin.sh \
        -cd ${HOME}/sgconfig \
        -i .searchguard.${HOSTNAME} \
        -ks /etc/elasticsearch/secret/searchguard.key \
        -kst JKS \
        -kspass kspass \
        -ts /etc/elasticsearch/secret/searchguard.truststore \
        -tst JKS \
        -tspass tspass \
        -nhnv \
        -icl

#### Number of Shards, Replicas and Data Nodes
Points to remember:
* Below is the data from elasticsearch documentation. 
>To summarize, each index can be split into multiple shards. An index can also be replicated zero (meaning no replicas) or more times. Once replicated, each index will have primary shards (the original shards that were replicated from) and replica shards (the copies of the primary shards).
>
>The number of shards and replicas can be defined per index at the time the index is created. After the index is created, you may also change the number of replicas dynamically anytime. You can change the number of shards for an existing index using the _shrink and _split APIs, however this is not a trivial task and pre-planning for the correct number of shards is the optimal approach.
>
>By default, each index in Elasticsearch is allocated 5 primary shards and 1 replica which means that if you have at least two nodes in your cluster, your index will have 5 primary shards and another 5 replica shards (1 complete replica) for a total of 10 shards per index.
>
>Note: Each Elasticsearch shard is a Lucene index. There is a maximum number of documents you can have in a single Lucene index. As of LUCENE-5843, the limit is 2,147,483,519 (= Integer.MAX_VALUE - 128) documents. You can monitor shard sizes using the _cat/shards API.

* Final Variables with storage provided as hostPath on the local device mount point /logging
```yaml
openshift_logging_es_cluster_size=3
openshift_logging_es_number_of_replicas=1
openshift_logging_es_number_of_shards=2
```
* Changes made to the number of shards and replica; post installation; needs to for next index to be created. As the indexes are created from template unique for each day; sysadmin has to wait for next day for it to reflect. E.g. Observe the index project.cicd-admin.*; number of shards were increased from 1 to 2 on 31-May-2019 and it got relfected on 01-Jun-2019 index. Observe the primary shards and replicas hosts per index.

```sh
sh-4.2$ curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/indices?v
health status index                                                               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .kibana.d033e22ae348aeb5660fc2140aec35850c4da997                    okQo4jqmS72t7d3brHvBnQ   1   0         16            7    268.3kb        268.3kb
green  open   project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.05.31  7-hak4qITYuYQmpuioQm6g   1   1      53021            0     60.7mb         30.3mb
green  open   project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.01  CKpsi6fJS5aKcuXBy8qpIA   2   1      37759            0     43.6mb         21.7mb
green  open   .searchguard                                                        FLoOywA6SgmJrt630d-nlA   1   1          5         1748    634.9kb        306.8kb
green  open   .operations.2019.06.01                                              lBtygC7_T9KuOsh5DL1B_w   2   1    9089362            0     24.7gb         12.4gb
green  open   .orphaned.2019.06.01                                                74dTzHumTkijQqrlSRYAqQ   2   1          5            0     52.2kb         26.1kb
green  open   .orphaned.2019.05.31                                                hvY6ny1jQ1u7BsLhetJZGg   1   1          0            0       382b           191b
green  open   project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.05.31      cd3Cq7IrQneBV_5cBMJ-3Q   1   1          8            0      128kb           64kb
green  open   .kibana                                                             P7f49hheTsuJdnKWUdvd5w   1   0          1            0      3.2kb          3.2kb
green  open   project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.05.31 dPK-baTDRe2lDpUl1K5tyg   1   1      25893            0     35.8mb         17.9mb
green  open   .operations.2019.05.31                                              ez0CzXY2Q3iUdXsNSwKJXw   1   1    7870464            0     21.2gb         10.6gb
green  open   .kibana.315f166c5aca63a157f7d41007675cb44a948b33                    usxAcWs4THKXMi9K8W5Pxg   1   0          5            3    123.2kb        123.2kb
green  open   project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.01 _wSD0xzZQfODO1fjeU-yQw   2   1      17819            0     25.4mb         12.7mb
```

```sh
sh-4.2$ curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/shards?v
index                                                               shard prirep state    docs   store ip            node
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.01  1     p      STARTED 18619  10.7mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.01  1     r      STARTED 18619  10.7mb 10.128.18.147 logging-es-data-master-shfsujug
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.01  0     p      STARTED 18346  10.6mb 10.128.24.166 logging-es-data-master-m08ycff1
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.01  0     r      STARTED 18346  10.6mb 10.128.18.147 logging-es-data-master-shfsujug
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.02 1     p      STARTED  5182   3.7mb 10.128.24.166 logging-es-data-master-m08ycff1
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.02 1     r      STARTED  5182   3.7mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.02 0     r      STARTED  5232   3.8mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.02 0     p      STARTED  5232   3.7mb 10.128.18.147 logging-es-data-master-shfsujug
.operations.2019.06.01                                              1     r      STARTED     5 679.2mb 10.128.24.166 logging-es-data-master-m08ycff1
.operations.2019.06.01                                              1     p      STARTED     2 729.9mb 10.128.20.108 logging-es-data-master-ufcuwwr4
.operations.2019.06.01                                              0     r      STARTED     1   3.3gb 10.128.20.108 logging-es-data-master-ufcuwwr4
.operations.2019.06.01                                              0     p      STARTED     1   3.3gb 10.128.18.147 logging-es-data-master-shfsujug
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.02  1     r      STARTED  9757   5.6mb 10.128.24.166 logging-es-data-master-m08ycff1
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.02  1     p      STARTED  9757   5.7mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.02  0     r      STARTED  9691   5.7mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.cicd-admin.391350b6-67a9-11e9-920b-fa163e7ec45b.2019.06.02  0     p      STARTED  9691   5.7mb 10.128.18.147 logging-es-data-master-shfsujug
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.01 1     r      STARTED 10433   7.2mb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.01 1     p      STARTED 10433   7.2mb 10.128.18.147 logging-es-data-master-shfsujug
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.01 0     p      STARTED 10047     7mb 10.128.24.166 logging-es-data-master-m08ycff1
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.06.01 0     r      STARTED 10047     7mb 10.128.18.147 logging-es-data-master-shfsujug
.kibana                                                             0     p      STARTED     1   3.2kb 10.128.24.166 logging-es-data-master-m08ycff1
.operations.2019.06.02                                              1     p      STARTED 30807  50.1mb 10.128.24.166 logging-es-data-master-m08ycff1
.operations.2019.06.02                                              1     r      STARTED 30892  51.9mb 10.128.18.147 logging-es-data-master-shfsujug
.operations.2019.06.02                                              0     r      STARTED 30799  52.2mb 10.128.20.108 logging-es-data-master-ufcuwwr4
.operations.2019.06.02                                              0     p      STARTED 30844  54.1mb 10.128.18.147 logging-es-data-master-shfsujug
.searchguard                                                        0     p      STARTED     5 585.9kb 10.128.24.166 logging-es-data-master-m08ycff1
.searchguard                                                        0     r      STARTED     5 714.2kb 10.128.18.147 logging-es-data-master-shfsujug
.kibana.315f166c5aca63a157f7d41007675cb44a948b33                    0     p      STARTED     8 152.8kb 10.128.24.166 logging-es-data-master-m08ycff1
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.02      1     p      STARTED  1036 846.8kb 10.128.24.166 logging-es-data-master-m08ycff1
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.02      1     r      STARTED  1036 823.5kb 10.128.18.147 logging-es-data-master-shfsujug
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.02      0     r      STARTED  1089   828kb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.02      0     p      STARTED  1089 736.4kb 10.128.18.147 logging-es-data-master-shfsujug
.kibana.d033e22ae348aeb5660fc2140aec35850c4da997                    0     p      STARTED    16 268.3kb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.01      1     r      STARTED     5  79.9kb 10.128.24.166 logging-es-data-master-m08ycff1
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.01      1     p      STARTED     5  79.9kb 10.128.20.108 logging-es-data-master-ufcuwwr4
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.01      0     r      STARTED    12 124.1kb 10.128.24.166 logging-es-data-master-m08ycff1
project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.06.01      0     p      STARTED    12 124.1kb 10.128.18.147 logging-es-data-master-shfsujug
.orphaned.2019.06.01                                                1     p      STARTED     0    191b 10.128.24.166 logging-es-data-master-m08ycff1
.orphaned.2019.06.01                                                1     r      STARTED     0    191b 10.128.20.108 logging-es-data-master-ufcuwwr4
.orphaned.2019.06.01                                                0     r      STARTED     0    191b 10.128.20.108 logging-es-data-master-ufcuwwr4
.orphaned.2019.06.01                                                0     p      STARTED     0    191b 10.128.18.147 logging-es-data-master-shfsujug
.operations.2019.05.31                                              1     r      STARTED     2 144.4kb 10.128.24.166 logging-es-data-master-m08ycff1
.operations.2019.05.31                                              1     p      STARTED     2 144.4kb 10.128.20.108 logging-es-data-master-ufcuwwr4
.operations.2019.05.31                                              0     r      STARTED     0    162b 10.128.24.166 logging-es-data-master-m08ycff1
.operations.2019.05.31                                              0     p      STARTED     0    162b 10.128.18.147 logging-es-data-master-shfsujug
```
