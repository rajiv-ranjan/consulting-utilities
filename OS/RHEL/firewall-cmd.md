* Get the list of overridding rules

```sh
$ firewall-cmd --direct --get-all-rules

ipv4 raw PREROUTING 0 -p udp --dport 53 -j NOTRACK
ipv4 raw PREROUTING 0 -p udp --sport 53 -j NOTRACK
ipv4 raw OUTPUT 0 -p udp --dport 53 -j NOTRACK
ipv4 raw OUTPUT 0 -p udp --sport 53 -j NOTRACK
```