
```yml
assetConfig:
  extensionScripts:
  - /etc/origin/master/openshift-ansible-catalog-console.js
  logoutURL: ''
  masterPublicURL: https://openshift-master.private.dani.com:8443
  publicURL: https://openshift-master.private.dani.com:8443/console/
  servingInfo:
    bindAddress: 0.0.0.0:8443
    bindNetwork: tcp4
    certFile: master.server.crt
    clientCA: ''
    keyFile: master.server.key
    maxRequestsInFlight: 0
    requestTimeoutSeconds: 0

...
oauthConfig:
  masterURL: https://openshift-master-int.private.dani.com:8443
....

# In OCP version 3.11 below section alone is sufficient.
servingInfo:
  bindAddress: 0.0.0.0:8443
  bindNetwork: tcp4
  certFile: master.server.crt
  clientCA: ca.crt
  keyFile: master.server.key
  maxRequestsInFlight: 1000
  requestTimeoutSeconds: 3600
  namedCertificates:
  - certFile: named_certificates/fullchain.pem
    keyFile: named_certificates/openshift-master.private.dani.com.key.pem
    names:
      - "openshift-master.private.dani.com"
```


> namedCertificates.certFile should contain the certificate, intermediate CA (if you are using an intermediate CA as the guide I shared does) and the root CA certificate, in that order. Note that an intermediate CA is not required but must be added to the certFile if you have one and the certFile would be a chain containing cert -> int CA -> root CA.

> The root CA certificate then must be added to the browser/system trust in order to not receive a warning from the browser unless the root CA would already be trusted by your browser/system which would be the case with letsencrypt, digicert, etc.
