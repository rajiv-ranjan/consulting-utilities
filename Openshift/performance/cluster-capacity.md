> TODO: Cluster-analysis: https://docs.openshift.com/container-platform/3.11/admin_guide/cluster_capacity.html

* cluster-capacity is not installed by default. 
* Article talks about it but package reference "atomic-openshift-cluster-capacity" is incorrect. Package was found in repo. https://access.redhat.com/solutions/3645722
```sh
[root@node-0 ~]# yum search all "cluster-capacity"
Failed to set locale, defaulting to C
Loaded plugins: product-id, search-disabled-repos, subscription-manager
======================================================================================== Matched: cluster-capacity =========================================================================================
openshift-enterprise-cluster-capacity.x86_64 : TODO
```

* Refer to the github for openshift and follow the steps to compile the from source code. https://github.com/openshift/cluster-capacity