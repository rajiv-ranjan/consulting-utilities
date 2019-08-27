#! /bin/bash

mkdir -p $HOME/github/rajiv-ranjan/
cd $HOME/github/rajiv-ranjan/
export GO111MODULE=on
operator-sdk new sample-operator --repo github.com/rajiv-ranjan/sample-operator
cd sample-operator
operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=AppService
operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService


operator-sdk build quay.io/rajivranjan/operators
docker push quay.io/rajivranjan/operators

# this is specific to OSX
sed -i "" 's|REPLACE_IMAGE|quay.io/rajivranjan/operators|g' deploy/operator.yaml

oc create -f deploy/service_account.yaml
oc create -f deploy/role.yaml
occreate -f deploy/role_binding.yaml
oc create -f deploy/crds/app_v1alpha1_appservice_crd.yaml
oc create -f deploy/operator.yaml

# Cleanup
oc delete -f deploy/crds/app_v1alpha1_appservice_cr.yaml
oc delete -f deploy/operator.yaml
oc delete -f deploy/role.yaml
oc delete -f deploy/role_binding.yaml
oc delete -f deploy/service_account.yaml
oc delete -f deploy/crds/app_v1alpha1_appservice_crd.yaml