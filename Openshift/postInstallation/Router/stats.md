* get the user and password from router pod
oc describe pod router-1-ww52v | grep -i STAT
STATS_PASSWORD:                         rpGEKc8NHZ
      STATS_PORT:                             1936
      STATS_USERNAME:                         admin


* ssh to the machine where router is running
ssh -i quicklab.key node-0.rajranjarouter.lab.rdu2.cee.redhat.com

* use curl command to see the metrics in prometheus format
curl admin:rpGEKc8NHZ@10.10.92.209:1936/metrics


