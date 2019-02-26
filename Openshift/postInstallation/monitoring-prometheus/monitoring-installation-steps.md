#### the inventory file entry looks like below:
```ini
############## MONITORING #################
openshift_cluster_monitoring_operator_install=true
openshift_cluster_monitoring_operator_prometheus_storage_enabled=true
openshift_cluster_monitoring_operator_prometheus_storage_capacity=3Gi
openshift_cluster_monitoring_operator_alertmanager_storage_enabled=false
#openshift_cluster_monitoring_operator_alertmanager_storage_capacity=
openshift_cluster_monitoring_operator_node_selector={"node-role.kubernetes.io/infra":"true"}
openshift_cluster_monitoring_operator_alertmanager_config=
openshift_cluster_monitoring_operator_prometheus_storage_class_name=
#openshift_cluster_monitoring_operator_alertmanager_storage_class_name=
```

#### PV and PVC requirements
Prometheus has two replicas and Alertmanager has three replicas, which amounts to *five PVs*




chcon -R system_u:object_r:svirt_sandbox_file_t:s0:c9,c4 /exports/nfs/monitoring
chown -R 1000080000:1000080000 /exports/nfs/monitoring