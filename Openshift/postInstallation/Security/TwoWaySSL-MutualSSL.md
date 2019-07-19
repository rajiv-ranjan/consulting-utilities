> TODO Setup a two way SSL 
> https://developers.redhat.com/blog/2017/01/24/end-to-end-encryption-with-openshift-part-1-two-way-ssl/
> https://docs.openshift.com/container-platform/3.11/install_config/router/default_haproxy_router.html#mutual-tls-auth

```sh
openssl s_client -connect www.google.com:443
```