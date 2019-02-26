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