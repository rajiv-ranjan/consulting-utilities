### Role description
oc describe clusterrole.rbac admin basic-user

* what can a user do?
    oc policy can-i --list --loglevel=8
    oc policy can-i <verb> <resource> --scopes=user:info


### Create User
* oc create clusterrolebinding NAME --clusterrole=NAME [--user=username] [--group=groupname]
```sh
$ oc create clusterrolebinding cluster-wide-superadmin --clusterrole=cluster-admin --user=admin
clusterrolebinding.rbac.authorization.k8s.io/cluster-wide-superadmin created
```

### Create Group
* oc adm groups new <group_name> <user1> <user2>
* oc get groups

