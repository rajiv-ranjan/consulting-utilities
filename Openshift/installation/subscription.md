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

curl -k -u 'rajranja@redhat.com' https://subscription.rhsm.redhat.com:443/subscription/
[{"rel":"","href":"/"},{"rel":"deleted_consumers","href":"/deleted_consumers"},{"rel":"consumertypes","href":"/consumertypes"},{"rel":"crl","href":"/crl"},{"rel":"entitlements","href":"/entitlements"},{"rel":"guestids","href":"/consumers/{consumer_uuid}/guestids"},{"rel":"pools","href":"/pools"},{"rel":"products","href":"/products"},{"rel":"activation_keys","href":"/activation_keys"},{"rel":"statistics/generate","href":"/statistics/generate"},{"rel":"distributor_versions","href":"/distributor_versions"},{"rel":"owners","href":"/owners"},{"rel":"cdn","href":"/cdn"},{"rel":"roles","href":"/roles"},{"rel":"events","href":"/events"},{"rel":"consumers","href":"/consumers"},{"rel":"atom","href":"/atom"},{"rel":"content_overrides","href":"/consumers/{consumer_uuid}/content_overrides"},{"rel":"rules","href":"/rules"},{"rel":"content","href":"/content"},{"rel":"hypervisors","href":"/hypervisors"},{"rel":"users","href":"/users"},{"rel":"migrations","href":"/migrations"},{"rel":"status","href":"/status"},{"rel":"admin","href":"/admin"},{"rel":"serials","href":"/serials"},{"rel":"jobs","href":"/jobs"},{"rel":"subscriptions","href":"/subscriptions"},{"href":"/consumers/{consumer_uuid}/packages","rel":"packages"}]
```

* check the logs