* Adding longer timeout for the operations to complete.

```sh
ansible-playbook --timeout=40  -i /home/rajranja/hosts playbooks/openshift-service-catalog/config.yml  -vvvv
```

* Run the playbook in screen mode and direct the log to a file to view/debug

```sh
screen
openshift-ansible]$ ansible-playbook --timeout=40  -i /home/rajranja/hosts playbooks/openshift-service-catalog/config.yml  -vvvv | tee /home/rajranja/service-catalog/config_01.log
tail -f /home/rajranja/service-catalog/config_01.log
```

