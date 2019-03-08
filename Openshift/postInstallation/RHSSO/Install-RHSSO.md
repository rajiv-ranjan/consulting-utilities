* Login to OCP cluster as system admin

```sh
oc login -u system:admin
```
* Pull all the templates for SSO

```sh
for resource in sso73-image-stream.json \
  sso73-https.json \
  sso73-mysql.json \
  sso73-mysql-persistent.json \
  sso73-postgresql.json \
  sso73-postgresql-persistent.json \
  sso73-x509-https.json \
  sso73-x509-mysql-persistent.json \
  sso73-x509-postgresql-persistent.json
do
  oc replace -n openshift --force -f \
  https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso73-dev/templates/${resource}
done
```

* Install RHSSO 7.3 in openshift namespace

```sh
oc -n openshift import-image redhat-sso73-openshift:1.0
```


```sh
oc process template/sso72-https -n openshift \
-p APPLICATION_NAME=sso \
-p HOSTNAME_HTTPS=secure-sso-sso-app-demo.apps.c1-ocp.surakshakavach.com  \
-p HOSTNAME_HTTP=sso-sso-app-demo.apps.c1-ocp.surakshakavach.com \
-p HTTPS_KEYSTORE=sso-https.jks \
-p HTTPS_PASSWORD=password \
-p HTTPS_SECRET=sso-ssl-secret \
-p JGROUPS_ENCRYPT_KEYSTORE=jgroups.jceks \
-p JGROUPS_ENCRYPT_PASSWORD=password \
-p JGROUPS_ENCRYPT_SECRET=sso-jgroup-secret \
-p SSO_REALM=demorealm \
-p SSO_SERVICE_USERNAME=sso-mgmtuser \
-p SSO_SERVICE_PASSWORD=password \
-p SSO_ADMIN_USERNAME=admin \
-p SSO_ADMIN_PASSWORD='adminPassword@123' \
-p SSO_TRUSTSTORE=truststore.jks \
-p SSO_TRUSTSTORE_SECRET=sso-ssl-secret \
-p SSO_TRUSTSTORE_PASSWORD=password \
| oc create -f -
```