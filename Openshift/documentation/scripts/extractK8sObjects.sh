#! /bin/bash

PROJECTS=`oc projects --short=true`
RESOURCES_NAMESPACED=`oc api-resources --namespaced=true -o name`
RESOURCES_NOT_NAMESPACED=`oc api-resources --namespaced=false -o name`


for PROJECT in $PROJECTS
do
        echo "removing old directory: $PROJECT"
        rm -rf $PROJECT
        echo "creating project folder: $PROJECT"
        mkdir -p $PROJECT && cd $PROJECT
        echo "switching to project: $PROJECT"
        oc project $PROJECT
        echo "extract status for project: $PROJECT"
        oc status -n $PROJECT > $PROJECT-status.log

        for OBJECT in $RESOURCES_NAMESPACED
        do
                echo "export data from object: $OBJECT and namespace: $PROJECT"
                oc get -o yaml --export $OBJECT > $OBJECT.yaml
        done
        echo "Exporting project object definition for $PROJECT and other k8s objects"
        oc get project $PROJECT -o yaml > $PROJECT.yaml
        oc get -o yaml --export all > $PROJECT-objects.yaml
        cd ..
done

for OBJECT in $RESOURCES_NOT_NAMESPACED
do
        echo "export data from object: $OBJECT"
        oc get -o yaml --export $OBJECT > $OBJECT.yaml
done