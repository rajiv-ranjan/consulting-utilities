# useful network commands across OS

#### Scenario - Listening connections

```sh
netstat -tuplena
```

```sh
# Full TCP port scan using with service version detection - usually my first scan, You will find T4 more accurate than T5 and still "pretty quick".

nmap -p 1-65535 -sV -sS -T5 node-0.rajranjamaster.lab.pnq2.cee.redhat.com
```

```sh
telnet server port
```