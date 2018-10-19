| Command | Purpose |
| --- | --- |
| docker login -u developer -p $(oc whoami -t) $(minishift openshift registry) | Log into the OpenShift Docker registry|
| docker tag my-app $(minishift openshift registry)/myproject/my-app| Tag the image against the OpenShift registry|
| docker push $(minishift openshift registry)/myproject/my-app| Push the image to the registry to create an image stream with the same name as the application|
| oc new-app --image-stream=my-app --name=my-app| Create new app from the image stream. |
| oc run myapp --image 172.30.1.1:5000/myproject/myapp| Create new app from the image directly. |