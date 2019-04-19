> TODO pick up the steps from https://docs.openshift.com/container-platform/3.11/install_config/configuring_authentication.html#LDAPPasswordIdentityProvider 

* Master configuration
```sh
  identityProviders:
  - name: "ldap_bastion"
    challenge: true
    login: true
    mappingMethod: claim
    provider:
      apiVersion: v1
      kind: LDAPPasswordIdentityProvider
      attributes:
        id:
        - dn
        name:
        - cn
        preferredUsername:
        - uid
      bindDN: "cn=ldapadmin,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com"
      bindPassword: "***SOMEPASSWORD***"
      insecure: true
      url: "ldap://node-0.rajranjabastion.lab.pnq2.cee.redhat.com/ou=People,dc=rajranjabastion,dc=lab,dc=pnq2,dc=cee,dc=redhat,dc=com?uid"
```