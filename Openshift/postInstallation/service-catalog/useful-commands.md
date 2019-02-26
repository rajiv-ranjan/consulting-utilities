* Get the list of apis supported; run below from one of the master

```sh
curl -vvv https://apiserver.kube-service-catalog.svc:443/ --insecure

{
  "paths": [
    "/apis",
    "/apis/servicecatalog.k8s.io",
    "/apis/servicecatalog.k8s.io/v1beta1",
    "/apis/settings.servicecatalog.k8s.io",
    "/healthz",
    "/healthz/etcd",
    "/healthz/ping",
    "/healthz/poststarthook/generic-apiserver-start-informers",
    "/healthz/poststarthook/start-service-catalog-apiserver-informers",
    "/metrics",
    "/swaggerapi",
    "/version"
  ]
}
```

* Get the endpoints of apiserver

```sh
oc get endpoints -n kube-service-catalog apiserver
```

* Get the service catalog api details from the endpoint

```sh
curl -vvv https://10.128.0.39:6443/apis/servicecatalog.k8s.io/v1beta1 --insecure


```