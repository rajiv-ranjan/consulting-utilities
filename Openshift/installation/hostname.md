Value of hostname and hostname -f should be same. There should be a separate DNS server resolving the host FQDN.

```sh
hostname
node1

hostname -d
mydomain.local

hostnamectl --static set-hostname node1.mydomain.local

hostname && hostname -f
node1.mydomain.local
node1.mydomain.local
```