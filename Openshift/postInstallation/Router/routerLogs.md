>TODO https://access.redhat.com/solutions/3397701


oc set env dc/router ROUTER_SYSLOG_ADDRESS=127.0.0.1 ROUTER_LOG_LEVEL=debug -n default

cat > /etc/rsyslog.d/haproxy.conf <<EOF
\$ModLoad imudp
\$UDPServerRun 514
\$UDPServerAddress 127.0.0.1
local1.*  /var/log/haproxy.log
EOF
systemctl restart rsyslog 
systemctl status rsyslog 





systemctl restart rsyslog 

 egrep -i 'ucip-mock-route' /var/log/haproxy.log | awk '{print $10}' | rev | cut -c1-3 | rev


 #!/bin/bash

for i in {1..100}
do
  echo "iteration: $i"
  tail -n 500 /var/log/haproxy.log | egrep -i 'ucip-mock-route'  | awk '{print $10 $7}'
done
