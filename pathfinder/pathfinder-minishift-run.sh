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


minishift start --password $MINISHIFT_PASSWORD 

# Setup OC CLI
eval $(minishift oc-env)

#Login admin user
oc login -u admin -p admin
oc project pathfinder
minishift console 