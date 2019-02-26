* Set the component install to true

```ini
openshift_enable_service_catalog=true
ansible_service_broker_install=false
template_service_broker_install=true
```


## Uninstall the service catalog

* Set the removal explicitly in the host inventory file

```ini
openshift_service_catalog_remove=true
template_service_broker_remove=true
ansible_service_broker_remove=true
```

* Set the component install to false

```ini
openshift_enable_service_catalog=false
ansible_service_broker_install=false
template_service_broker_install=false
```