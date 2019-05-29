>TODO https://access.redhat.com/articles/3135421

* Dockerfile that makes the container can be retrieved from 

```sh
oc exec $POD_NAME -- ls -lrt /root/buildinfo
total 20
-rw-r--r--. 1 root root 2924 Aug  1  2018 Dockerfile-rhel7-7.5-409.1533127727
-rw-r--r--. 1 root root 2554 Sep 25  2018 Dockerfile-jboss-base-rhel7-1.1-26
-rw-r--r--. 1 root root 2214 Oct 17  2018 Dockerfile-jboss-openjdk18-rhel7-1.1-29.1539812312
-rw-r--r--. 1 root root 4751 Oct 17  2018 Dockerfile-fuse7-fuse-java-openshift-1.1-4.1539812368
```

* Some more diagnostics are [here](https://github.com/rajiv-ranjan/xpaas-diagnostics)