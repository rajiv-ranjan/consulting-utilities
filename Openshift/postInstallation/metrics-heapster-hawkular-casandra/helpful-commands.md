#### remove the all kubernetes objects and pv related to metrics

oc delete all -l metrics-infra=hawkular-cassandra
oc delete all -l metrics-infra=hawkular-metrics
oc delete all -l metrics-infra=heapster

> please note that if the storage type is changing then delete that as well.
oc delete pvc metrics-cassandra-1