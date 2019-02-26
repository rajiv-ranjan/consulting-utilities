### Scenario 2 - End to end demo
* git clone https://github.com/rajiv-ranjan/openshift-cd-demo.git
* run the deploy with quay
```sh
./scripts/provision.sh deploy --enable-quay --quay-username rajivranjan --quay-password YOUR-QUAY-PASSWORD --user admin --project-suffix rr --ephemeral true --oc-options --server https://master.c1-ocp.surakshakavach.com:443
```


### Scenario 1 - Images are available in Quay (external Docker registry). Pipeline to deploy across env.
#### Dev Env
1. Create a shared project for CI/CD
```sh
oc new-project custom-cicd 
export CICD_NAMESPACE=custom-cicd
```

2. Deploy Jenkins 

```sh
oc new-app jenkins-ephemeral -n custom-cicd
oc set resources dc/jenkins --limits=cpu=2,memory=2Gi --requests=cpu=100m,memory=512Mi

# OR jenkins with persistence.

oc new-app jenkins-persistent --param ENABLE_OAUTH=true --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true
```

3. Create the jenkins agent pod
```sh

oc new-build  -D $'FROM docker.io/openshift/jenkins-agent-maven-35-centos7:v3.11 \n
      USER root\nRUN yum -y install skopeo && yum clean all\n
      USER 1001' --name=jenkins-agent-appdev -n ${CICD_NAMESPACE}

# verify the image stream created
oc get is
```
4. *TODO* add the steps for defining the jenkins slave pods

5. Create the secret for connecting to Quay.
   
```sh
export QUAY_USERNAME=''
export QUAY_PASSWORD=''
oc create secret generic quay-cicd-secret --from-literal="username=${QUAY_USERNAME}" --from-literal="password=${QUAY_PASSWORD}" -n ${CICD_NAMESPACE}
oc label secret quay-cicd-secret credential.sync.jenkins.openshift.io=true -n ${CICD_NAMESPACE}
```

##### Dev Env   
1. Set the Quay repo name
```sh
export QUAY_REPOSITORY=tasks-app
```
2. Create Dev environment

```sh
oc new-project dev-env
export DEV_PROJECT=dev-env
```
2. Create secret for quay in dev-env
```sh
oc create secret docker-registry quay-cicd-secret --docker-server=quay.io --docker-username="${QUAY_USERNAME}" --docker-password="${QUAY_PASSWORD}" --docker-email=rajranja@redhat.com -n ${DEV_PROJECT}
```
3. Create the deployment config to pull from quay.
```sh
oc new-app --name=tasks --docker-image=quay.io/${QUAY_USERNAME}/${QUAY_REPOSITORY}:latest --allow-missing-images -n ${DEV_PROJECT}
```
4. Clean up for jenkins pipeline to control the app roll out
```sh
oc set triggers dc tasks --remove-all -n ${DEV_PROJECT}
oc patch dc tasks -p '{"spec": {"template": {"spec": {"containers": [{"name": "tasks", "imagePullPolicy": "Always"}]}}}}' -n ${DEV_PROJECT}
oc delete is tasks -n ${DEV_PROJECT}
```
5. Link secret to image pull
```sh
oc secrets link default quay-cicd-secret --for=pull -n ${DEV_PROJECT}
```
6. Create a route for the app
```sh
oc expose dc/tasks --port=8080 -n ${DEV_PROJECT}
oc expose svc/tasks -n ${DEV_PROJECT}
```
7. Add readiness and liveliness probes
```sh
oc set probe dc/tasks --readiness --get-url=http://:8080/ws/demo/healthcheck --initial-delay-seconds=30 --failure-threshold=10 --period-seconds=10 -n ${DEV_PROJECT}

oc set probe dc/tasks --liveness  --get-url=http://:8080/ws/demo/healthcheck --initial-delay-seconds=180 --failure-threshold=10 --period-seconds=10 -n ${DEV_PROJECT}
```
8. Cancel any roll out in staging env
```sh
oc rollout cancel dc/tasks -n ${STAGE_PROJECT}
```

##### Stage Env

1. Create staging env
```sh
export STAGE_PROJECT=stage-env
oc new-project ${STAGE_PROJECT}
```
2. Similar to dev set up staging env
```sh
oc create secret docker-registry quay-cicd-secret --docker-server=quay.io --docker-username="${QUAY_USERNAME}" --docker-password="${QUAY_PASSWORD}" --docker-email=cicd@redhat.com -n ${STAGE_PROJECT}

oc new-app --name=tasks --docker-image=quay.io/${QUAY_USERNAME}/${QUAY_REPOSITORY}:stage --allow-missing-images -n ${STAGE_PROJECT}

oc set triggers dc tasks --remove-all -n ${STAGE_PROJECT}

oc patch dc tasks -p '{"spec": {"template": {"spec": {"containers": [{"name": "tasks", "imagePullPolicy": "Always"}]}}}}' -n ${STAGE_PROJECT}

oc delete is tasks -n ${STAGE_PROJECT}

oc secrets link default quay-cicd-secret --for=pull -n ${STAGE_PROJECT}

oc expose dc/tasks --port=8080 -n ${STAGE_PROJECT}

oc expose svc/tasks -n ${STAGE_PROJECT}

oc set probe dc/tasks --readiness --get-url=http://:8080/ws/demo/healthcheck --initial-delay-seconds=30 --failure-threshold=10 --period-seconds=10 -n ${STAGE_PROJECT}

oc set probe dc/tasks --liveness  --get-url=http://:8080/ws/demo/healthcheck --initial-delay-seconds=180 --failure-threshold=10 --period-seconds=10 -n ${STAGE_PROJECT}

oc rollout cancel dc/tasks -n ${DEV_PROJECT}
```

2. Create build config with jenkins build strategy
   1. inline jenkinsfile content
```sh


```
   2. git reference to jenkins file
3. Create deployment config
4. Define