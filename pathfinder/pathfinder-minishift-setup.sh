#!/bin/bash

### PRE-REQUISITE
# minishift
# env with variable MINISHIFT_USERNAME, MINISHIFT_PASSWORD, REGISTRY_USERNAME, REGISTRY_PASSWORD
###

if [[ ( -z "${MINISHIFT_USERNAME}" ) || ( -z "${MINISHIFT_PASSWORD}" ) || ( -z "${REGISTRY_USERNAME}" ) || ( -z "${REGISTRY_PASSWORD}" ) ]]; then
    echo "Atleast one of the environment variable MINISHIFT_USERNAME, MINISHIFT_PASSWORD not set.";
    echo "MINISHIFT_USERNAME=$MINISHIFT_USERNAME";
    echo "MINISHIFT_PASSWORD=$MINISHIFT_PASSWORD";
    echo "REGISTRY_USERNAME=$REGISTRY_USERNAME";
    echo "REGISTRY_PASSWORD=$REGISTRY_PASSWORD";
    exit;
fi

minishift profile set pathfinder
minishift profile list
minishift config set cpus 2
minishift config set disk-size 20GB
minishift config set memory 8GB
minishift config set network-nameserver 8.8.8.8
minishift config set username $MINISHIFT_USERNAME
minishift config set addon-env "REGISTRY_USERNAME=$REGISTRY_USERNAME"
minishift config set addon-env "REGISTRY_PASSWORD=$REGISTRY_PASSWORD"
minishift addons enable anyuid
minishift addons enable redhat-registry-login
minishift addons enable registry-route
minishift addons enable xpaas

# START Minishift
#minishift start --password $MINISHIFT_PASSWORD --addon-env REGISTRY_USERNAME=$REGISTRY_USERNAME --addon-env REGISTRY_PASSWORD=$REGISTRY_PASSWORD
minishift start --password $MINISHIFT_PASSWORD 

# Setup OC CLI
minishift oc-env
eval $(minishift oc-env)

#Setup admin user
oc login -u system:admin
oc create user admin --full-name=admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin

# Setup pathfinder
wget https://raw.githubusercontent.com/redhat-cop/pathfinder/master/pathfinder-full-template.yaml
oc new-project pathfinder
oc new-app --template=mongodb-persistent --param=MONGODB_DATABASE=pathfinder
oc process -f pathfinder-full-template.yaml|oc create -f-

