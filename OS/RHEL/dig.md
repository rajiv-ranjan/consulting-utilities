# Query DNS servers for various DNS records


###### Add few more here from https://www.cyberciti.biz/faq/unix-linux-dns-lookup-command/ 
###### lilke list of all entries (A record, SOA record, ) for a FQDN in the DNS
###### also highlight the parts of the response that's useful.


### DNS query without name server
By default with no name server specified the DNS resolver in the /etc/resolv.conf file will be used, dig will also look for an A record with no other options specified.
```bash
dig google.com
```

### DNS query with name server
we are now specifying some external name server to query, our network needs to permit outbound access to this destination on port 53, otherwise the query will fail.
```bash
dig @8.8.8.8 google.com
```
### DNS query with specific record type
Generally the record with the lowest priority will be used first.
```bash
dig @8.8.8.8 google.com MX
```
#todo: add the record types

### Reverse DNS lookup
use the dig command to perform a reverse DNS lookup, that is we can query an IP address and find the domain name that it points to by querying the PTR record. This is done by using the -x option followed by the IP address to query.
```bash
dig -x 216.58.220.110
```
### Trace the DNS path
Perform a trace on the DNS lookup path with the +trace option, as shown below while querying google.com we can see what actually happens. First the root name servers for '.' are looked up, followed by the name servers for the .com domain, and then finally the name servers for google.com are returned, followed by the DNS records for it.
```bash
dig google.com +trace
```
### Reduce answer size
only ip will be returned
```bash
dig google.com +short
```

### Use custom name server port
By default the dig command queries port 53 which is the standard DNS port, however we can optionally specify an alternate port if required. This may be useful if an external name server is configured to use a non standard port for some reason. We specify the port to query with the -p option, followed by the port number. In the below example we perform a DNS query to port 5300.
```bash
dig @8.8.8.8 -p 5300 google.com
```