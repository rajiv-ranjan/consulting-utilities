# Default routes at skeleton deployment time

- Console output on default routes created during the installation

```sh
➜  install-03-opentlc oc get routes --all-namespaces
NAMESPACE                            NAME                HOST/PORT                                                                            PATH   SERVICES                   PORT      TERMINATION            WILDCARD
openshift-authentication             oauth-openshift     oauth-openshift.apps.cluster-8344.sandbox1668.opentlc.com                                   oauth-openshift            6443      passthrough/Redirect   None
openshift-console                    console             console-openshift-console.apps.cluster-8344.sandbox1668.opentlc.com                         console                    https     reencrypt/Redirect     None
openshift-console                    downloads           downloads-openshift-console.apps.cluster-8344.sandbox1668.opentlc.com                       downloads                  http      edge/Redirect          None
openshift-monitoring                 alertmanager-main   alertmanager-main-openshift-monitoring.apps.cluster-8344.sandbox1668.opentlc.com            alertmanager-main          web       reencrypt/Redirect     None
openshift-monitoring                 grafana             grafana-openshift-monitoring.apps.cluster-8344.sandbox1668.opentlc.com                      grafana                    https     reencrypt/Redirect     None
openshift-monitoring                 prometheus-k8s      prometheus-k8s-openshift-monitoring.apps.cluster-8344.sandbox1668.opentlc.com               prometheus-k8s             web       reencrypt/Redirect     None
openshift-monitoring                 thanos-querier      thanos-querier-openshift-monitoring.apps.cluster-8344.sandbox1668.opentlc.com               thanos-querier             web       reencrypt/Redirect     None
```
