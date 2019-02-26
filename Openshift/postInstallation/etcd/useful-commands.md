* Load the etcd configuration after login to the etcd server

```sh
source /etc/etcd/etcd.conf
```

* List the etcd keys only

```sh
etcdctl3 --cert=$ETCD_PEER_CERT_FILE --key=$ETCD_PEER_KEY_FILE --cacert=$ETCD_TRUSTED_CA_FILE --endpoints=$ETCD_LISTEN_CLIENT_URLS get / --prefix --keys-only
```

```sh
etcdctl3 --cert=$ETCD_PEER_CERT_FILE --key=$ETCD_PEER_KEY_FILE --cacert=$ETCD_TRUSTED_CA_FILE --endpoints=$ETCD_LISTEN_CLIENT_URLS get / --prefix --keys-only | egrep -i kube-service-catalog

/kubernetes.io/configmaps/kube-service-catalog/cluster-info
/kubernetes.io/configmaps/kube-service-catalog/service-catalog-controller-manager
/kubernetes.io/controllerrevisions/kube-service-catalog/apiserver-5c69fcb9f4
/kubernetes.io/controllerrevisions/kube-service-catalog/controller-manager-69c9d9d556
/kubernetes.io/daemonsets/kube-service-catalog/apiserver
/kubernetes.io/daemonsets/kube-service-catalog/controller-manager
------------
------------
```

* Specific items can be deleted from etcd

```sh
etcdctl3 del /kubernetes.io/namespaces/kube-service-catalog
```