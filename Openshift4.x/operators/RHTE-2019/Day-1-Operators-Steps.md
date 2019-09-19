> TODO : Follow the link to create local demo
> https://github.com/openshift-labs/lab-build-an-operator

## Intro to the Operator SDK
As a user of an OpenShift cluster, most of the time you would only be a consumer of existing operators which have been installed into the cluster. The primary use case would be to help you provision applications such as databases, or middleware products, including message queuing systems, rules management systems etc. A typical developer should never have a need to create their own operator.

If you do have a need to implement an operator to manage use of an application, perhaps as a way of making it easier for users to consume your own product, to make that task easier, you can use the Operator SDK. The Operator SDK can be installed on your own development system, and supports the creation of operators using the Go programming language, Ansible, or by bundling up Helm charts into an operator.

In this part of the workshop you will use the Operator SDK to create an operator implemented in the Go programming language.

The benefit of using the Go Operator SDK is that it uses the controller-runtime library from the Kubernetes project, to make writing operators easier. The SDK provides:

High level APIs and abstractions to write the operational logic more intuitively.
Tools for scaffolding and code generation to bootstrap a new project quickly.
Extensions to cover more common operator use cases.
The general steps for creating an operator using the SDK which you will be guided through are:

Creating a new operator project using the SDK CLI.
Creating a new Custom Resource Definition API Type using the SDK CLI.
Defining the Spec and Status sections of the Custom Resource.
Adding your Custom Resource Definition (CRD) to the Kubernetes cluster.
Creating a new Controller for your Custom Resource Definition API.
Writing the reconciliation logic for your Controller.
Running the operator to test your code against the Kubernetes cluster.
Using the SDK CLI to build and generate the operator Deployment manifests.
The example operator you will be creating implements a common pattern of operators. That is, the creation and management of a set of pods, and scaling the number of pods.

## Initial Project Scaffolding

The Operator SDK client tools have already been installed for you. The command line client is called operator-sdk.

To see what type of operation the Operator SDK command line client supports run:

operator-sdk --help
The first step you need to do in creating your operator is to generate the initial project scaffolding. Do this by running:

operator-sdk new podset-operator --type=go --skip-git-init
We are using the directory podset-operator as the project directory. Change to that directory as subsequent steps must be run from that directory.

cd podset-operator
To see the contents of the generated project directory, run:
ll

The purposes of the directories are as follows.

cmd - Contains the file manager/main.go, which is the main program of the operator. This instantiates a new manager which registers all custom resource definitions under the directory pkg/apis/... and starts all controllers under the directory pkg/controllers/....

pkg/apis - The directory tree containing the files that specify the APIs of the Custom Resources. For each custom resource (kind), it is necessary to edit the pkg/apis/<group>/<version>/<kind>_types.go file to define the API. These will be imported into their respective controllers to watch for changes in these resource types.

pkg/controller - Contains the implementation of the controllers. For each custom resource, it is necessary to edit the pkg/controller/<kind>/<kind>_controller.go file to define the controller's reconciliation logic for handling that resource type.

build - Contains the Dockerfile and build scripts used to build the operator.

deploy - Contains the YAML manifests for registering the custom resources, setting up any special role base access control (RBAC) access as required by the operator, and deploying the operator.

vendor - The vendor folder that contains the local copies of any external dependencies that satisfy the imports of this project.

Note that when generating the scaffolding for an operator, you can specify whether the operator should be configured so as to only monitor a single namespace, or all namespaces in a cluster.


## Define the Custom Resource

To provide a definition for the custom resource that the operator is to respond to, you need to create a Custom Resource Definition (CRD). For this example, the custom resource type name we will use is PodSet.

Because developers of different operators may choose to use the same name for a custom resource, resource types are grouped under an API group, where different developers would use their own unique name for the group.

To support the evolution of a custom resource over time, a version name also needs to be specified. The combination of the API group name and the version name is referred to as the API version.

For this example the API version app.example.com/v1alpha1 is used, corresponding to the API group of app.example.com and the version name of v1alpha1. See the Kubernetes documentation for more information on API versioning and API groups.

To generate the code and YAML files corresponding to the PodSet custom resource type, run:

operator-sdk add api --api-version=app.example.com/v1alpha1 --kind=PodSet
The output from the command will list the files generated.

 Note that this command may show Go compiler errors about unknown imports and finish with a usage error message from the operator-sdk program. This is due to an incompatibility between the version of the operator-sdk used and the Go compiler. The required files should have been generated okay, so you can ignore the errors and keep going with the following steps.

To inspect the generated CRD, which describes the PodSet custom resource, run:

cat deploy/crds/app_v1alpha1_podset_crd.yaml
To see an example of the custom resource with appropriate API version and resource type name, run:

cat deploy/crds/app_v1alpha1_podset_cr.yaml
Although the sample custom resource shows a spec.size attribute, this is an example only. The next step required is to update the generated Go code file corresponding to the resource type and define the custom attributes the resource is to have.

## Adding Custom Attributes
When you defined the name for your custom resource a Go code file was generated corresponding to the resource type. This code is used to specify what custom attributes your resource type will have. Initially the code file does not define any attributes.

To see the initial code file generated, and the structures it contains corresponding to the custom resource type, run:

cat pkg/apis/app/v1alpha1/podset_types.go
The key structures are:

type PodSetSpec struct {
        // INSERT ADDITIONAL SPEC FIELDS
}

type PodSetStatus struct {
        // INSERT ADDITIONAL STATUS FIELD
}

type PodSet struct {
        metav1.TypeMeta   `json:",inline"`
        metav1.ObjectMeta `json:"metadata,omitempty"`

        Spec   PodSetSpec   `json:"spec,omitempty"`
        Status PodSetStatus `json:"status,omitempty"`
}
For this example operator, we want to add a replicas attribute to the spec portion of the custom resource. This will specify how many instances of the application we want. The PodSetSpec structure therefore needs to be updated to:

type PodSetSpec struct {
        Replicas int32 `json:"replicas"`
}
To record the names of the pods corresponding to those instances, we also add a podNames attribute to the status portion of the custom resource. The status portion is where the operator keeps any attributes to report the status of the deployment based on the custom resource.

type PodSetStatus struct {
        PodNames []string `json:"podNames"`
}
To patch the podset_types.go file with these changes, run:

patch -p0 < $HOME/patches/podset_types.go.diff
After making any changes to the Go code files containing the custom resource definitions, you need to run:

operator-sdk generate k8s
This will re-generate code files which depend on the definition of the custom resource.

Also run:

operator-sdk generate openapi
This will re-generate the CRD file, updating the OpenAPI schema definition which describes the attributes. The schema is used to validate that a custom resource is valid. It is also consulted when oc explain is run on a custom resource type to generate information about it.

For more information on the schema, see the Kubernetes documentation on specifying a structural schema.

To see the updated version of the CRD file run:

cat deploy/crds/app_v1alpha1_podset_crd.yaml
The schema definition for the custom resource can be found under the spec.validation.openAPIV3Schema field.


## Load CRD into the Cluster
Before you can start creating instances of your custom resource and run an operator which relies on it, you need to load the CRD for the custom resource into the cluster.

To load the CRD, run:

oc apply -f deploy/crds/app_v1alpha1_podset_crd.yaml
You can load the CRD because in this workshop environment you are a cluster admin. In your own cluster, if you are not a cluster admin, you would need to request a cluster admin to do it.

To verify that the CRD has been loaded run:

oc describe crd/podsets.app.example.com
This will display details about the custom resource described by the CRD. To perform queries against the schema, you can use oc explain.

To see the custom attributes added to the spec for the custom resource, run:

oc explain podset.spec
At the moment no descriptions have been provided for the custom attributes, so only information about the type of the attributes will be shown.

To check that you can now create instances of the podset resource, run:

oc auth can-i create podset
It should respond with yes.

This will work because you are a cluster admin in this workshop environment, and can create resources of any type.

After the operator is deployed to a project namespace, if users who are not cluster admins need to be able to create instances of the new podset resource type, it will be necessary to create a cluster role which describes that right, and create a role binding against the users or group of users who need it.

The cluster role for being able to work with the podset resource would be:

apiVersion: authorization.openshift.io/v1
kind: ClusterRole
metadata:
  name: podset-operator-user
rules:
- apiGroups:
  - "app.example.com"
  resources:
  - podsets
  verbs:
  - get
  - list
  - watch
  - create
  - delete
  - patch
  - update
You would use the oc adm policy add-cluster-role-to-user command to bind the role to the users requiring it.

## Adding the Controller Code
In order for the operator to be able to respond to the custom resource, a controller for the resource type must be added to the operator code. To create the controller code run:

operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=PodSet
This will register the controller with the operator main program and set up a watcher for the custom resource, such that when any changes are made, the reconciliation loop of the operator is invoked and any appropriate action can take place.

You can view the initial generated code for the controller by running:

cat pkg/controller/podset/podset_controller.go
The add() function in the generated code file is what sets up a watcher for the PodSet custom resource.

// Watch for changes to primary resource PodSet
err = c.Watch(&source.Kind{Type: &appv1alpha1.PodSet{}}, &handler.EnqueueRequestForObject{})
The creation of new instances of the PodSet custom resource, or changes to existing instances of the custom resource, will result in the Reconcile() function being called. This is where your custom logic needs to be added to respond to any changes.

For a new instance of the PodSet custom resource, we want the operator to start up as many pods as the custom resource defines in the spec.replicas attribute.

In the case of an existing instance of the custom resource being updated, and the value of spec.replicas changed, the operator needs to correspondingly adjust the number of pods up or down.

If the custom resource is deleted, then all the pods need to be deleted.

In addition to the operator watching for changes to the custom resource, it also needs to monitor the pods corresponding to each instance of the custom resource. This is so that if a pod is shutdown, or deleted, that a new pod can be started in its place. In order to do this, the operator code also needs to watch instances of a Pod. This is also setup in the add() function.

// TODO(user): Modify this to be the types you create that are owned by the primary resource
// Watch for changes to secondary resource Pods and requeue the owner PodSet
err = c.Watch(&source.Kind{Type: &corev1.Pod{}}, &handler.EnqueueRequestForOwner{
        IsController: true,
        OwnerType:    &appv1alpha1.PodSet{},
})
If you look at the generated code for the controller, you will see this already exists. This is because the scaffolding generated by the Operator SDK code includes it as a sample. The sample however only includes code for creating a single pod for each instance of a custom resource. When starting a pod, the sample code is using the busybox image. The pod is created from the newPodForCR() function in this example.

## Define the Reconcile Function
The Reconcile() function is what needs to perform state reconciliation for your operator. That is, ensure that the current state of resources created by the operator, match what the custom resource has specified they need to be.

For our operator, as previously described, we need to update the operator code to handle a set of pods, the number of which is dictated by spec.replicas.

To apply the required changes, run:

patch -p0 < $HOME/patches/podset_controller.go.diff
To view the changes to the Reconcile() function run:

grep -A90 "^func.* Reconcile.*"  pkg/controller/podset/podset_controller.go
We will not be delving further into how to write the code for the operator than we have. For further information see the Operator SDK user guide.

## Local Testing of the Operator
Having made a set of changes it is a good idea to test them.

To make the task of testing your operator easier, the Operator SDK provides the operator-sdk up local command. This launches the operator on the local machine by building the operator binary and then running it against the Kubernetes cluster you are connected to.

The command for this would have been:

operator-sdk up local --namespace lab-build-an-operator-lab-operator-user1
Unfortunately, because the workshop environment, and the terminal you are using, is running in a container inside of the cluster, the operator thinks it to is running inside of the cluster, rather than outside. As a result, it attempts to perform leader election, which fails, because to perform leader election it needs to know the name of the pod the operator is deployed as. Because there isn't yet an instance of the operator running in the cluster, that cannot be determined and it fails.

We will therefore skip local testing and move onto deploying the operator in the cluster. You would though be able to perform local testing if you were developing the operator on your own machine.

## Building the Operator Image
Instead of running the operator locally and testing it against the cluster, we will build a container image for the operator, push the image to the internal image registry of the cluster, and then create a deployment for it.

Before building the image for the operator, we first need to ensure that vendor packages are available and up to date. Run:

go mod vendor
Now build the image using the operator-sdk build command. The image name we provide here is what the final name for the image will be when pushed to the internal image registry. We will be using buildah to build the image.

To start the build run:

operator-sdk build --image-builder buildah image-registry.openshift-image-registry.svc:5000/lab-build-an-operator-lab-operator-user1/podset-operator:0.1.0
 This will take a while the first time it is run (up to 5 minutes in this workshop environment).

The steps in the build process are to compile all the Go code which makes up the operator and the packages it uses. It will then build the container image using the Dockerfile in the build directory, with the compiled binaries as input.

Once the build completes, to see that the container image has been created, run:

podman images
To push the image to the internal image registry, you first need to login to the registry.

podman login -u default -p `oc whoami -t` image-registry.openshift-image-registry.svc:5000
Now push the image to the registry:

podman push image-registry.openshift-image-registry.svc:5000/lab-build-an-operator-lab-operator-user1/podset-operator:0.1.0
Verify that the image has been uploaded by querying the image stream:
oc get is/podset-operator

## Deploying the Operator Image
When you use the Operator SDK it will create the resource definitions for deploying the operator into the cluster. To view the deployment configuration which was generated, run:

cat deploy/operator.yaml
In this resource definition you will see that spec.template.spec.containers.image is set as:

image: REPLACE_IMAGE
We need to update REPLACE_IMAGE, changing it to reference the image from the internal image registry where we pushed it. To change this, run:

sed -i.bak -e "s#REPLACE_IMAGE#image-registry.openshift-image-registry.svc:5000/lab-build-an-operator-lab-operator-user1/podset-operator:0.1.0#" deploy/operator.yaml
Before we create this resource, we first need to create the service account which the deployment has been set up to run as:

oc apply -f deploy/service_account.yaml
We also need to create a role indicating what actions the service account can take:

oc apply -f deploy/role.yaml
Then bind the role to the service account:

oc apply -f deploy/role_binding.yaml
Finally we can create the deployment:

oc apply -f deploy/operator.yaml
To monitor that the pod for the operator has started up run:

watch oc get pods -l name=podset-operator
When the status has transitioned to "Running", stop the watch.

<ctrl-c>
So we can monitor what the operator is doing as we test it, grab the name of the pod:

POD=`oc get pods -l name=podset-operator --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
Now tail the logs for the pod:
oc logs $POD -f

## Testing the Deployed Operator
The operator will watch for any instances of the PodSet custom resource. Let's update the original sample resource file for PodSet which was created for us to have the spec.replicas attribute which the operator implements. Run:

cat > deploy/crds/app_v1alpha1_podset_cr.yaml << EOF
apiVersion: app.example.com/v1alpha1
kind: PodSet
metadata:
  name: example-podset
spec:
  replicas: 3
EOF
Now create an instance of the custom resource from this resource file:

oc apply -f deploy/crds/app_v1alpha1_podset_cr.yaml
You should see the operator logs update as it responds to the custom resource, creates the corresponding pods, and then update the custom resource status with the list of pods.

To see the list of pods created corresponding to the custom resource, run:

oc get pods -l app=example-podset
Now verify that these are the pod names recorded in the status of the custom resource:

oc get podset/example-podset -o yaml
Stop the tailing of the log file.

<ctrl-c>
Instead, run a watch on the pods:

watch oc get pods -l app=example-podset
Grab the name of one of the running pods:

POD=`oc get pods -l app=example-podset --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
Delete the pod:

oc delete $POD
You should see from the watch that the pod starts terminating and at the same time is replaced. Because the pod is running sleep within busybox, and doesn't respond correctly to signals, it will take a little while before it completely disappears.

Check the status of the custom resource to verify the list of current pods has been updated:

oc get podset/example-podset -o yaml
Next confirm that the operator handles scaling the number of pods correctly, by changing the number of replicas. We will scale it down to one replica.

oc patch podset/example-podset --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value":1}]'
Two of the pods should be terminated, leaving just one.

Stop the watch for the pods.

<ctrl-c>

## Workshop Summary

In this workshop you learned a bit about how an Operator works, is implemented and used. The following links provide additional information about Operators.

For further information on custom resources and controllers in Kubernetes, see:

https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/
The original CoreOS web site on Operators can be found at:

https://coreos.com/operators/
The Operator Framework project and the repositories for it's component parts can be found at:

https://github.com/operator-framework
This includes the key repositories for:

Operator SDK
Operator Lifecycle Manager (OLM)
Operator Marketplace
Operator Metering
Details of the Kubernetes controller-runtime library which the Operator Framework uses, can be found at:

https://github.com/kubernetes-sigs/controller-runtime
For a catalog of Operators available from different software vendors, including Red Hat, and the community, see the Operator Hub at:

https://operatorhub.io/