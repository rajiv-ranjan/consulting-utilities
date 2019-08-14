### Connectivity and Credential check
* enable the rhsm logs in debug mode

```sh
vi /etc/rhsm/rhsm.conf

[logging]
default_log_level =DEBUG
subscription_manager = DEBUG
subscription_manager.managercli = DEBUG
rhsm = DEBUG
rhsm.connection = DEBUG
rhsm-app = DEBUG
rhsm-app.rhsmd = DEBUG
```

* check the orgs

```sh
# Method 1
subscription-manager orgs
```

```sh
# Method 2: Below will give the list of API tht can be called further.
#curl -v -k -u "<USERNAME>:<PASSWORD>" --proxy "<PROXY USERNAME>:<PROXY PASSWORD>@http://<PROXY HOSTNAME> :<PROXY PORT>" https://subscription.rhsm.redhat.com:443/subscription/

curl -k -u 'rajranja@redhat.com' https://subscription.rhsm.redhat.com:443/subscription/users
```

* check the logs