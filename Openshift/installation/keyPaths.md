|Paths|Purpose|
|----|----|
|/usr/share/ansible|folder contains ansible roles and plugins|
|/usr/share/ansible/openshift-ansible|folder contains ansible roles and plugins for OpenShift|
|/etc/origin/node/node-config.yaml|You must not modify a node host as Any changes are overwritten by the configuration that is defined in the ConfigMap the node uses.|
|$HOME/.kube|configurations that affects kubectl|
|/etc/origin/master/session-secrets.yaml|master session secrets are managed from here.|
|/etc/origin/master/named_certificates/|certificates on master nodes|
|||