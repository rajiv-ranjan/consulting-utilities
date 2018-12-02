#!/bin/bash

# cat serverList.in > while IFS=' ' read -f serverName
# do 
# echo "serverName : $serverName"
# done

#cat serverList.in
# export allServers = "read serverList.in"
# echo "All values are : $allServers"
# for host in $allServers;
# do echo $host;
# done

echo "Connecting Passwordless to all the hosts from bastion server"
for host in \
    master-0.rajranja.lab.pnq2.cee.redhat.com \
    master-1.rajranja.lab.pnq2.cee.redhat.com \
    master-2.rajranja.lab.pnq2.cee.redhat.com \
    infra-0.rajranja.lab.pnq2.cee.redhat.com \
    infra-1.rajranja.lab.pnq2.cee.redhat.com \
    node-0.rajranja.lab.pnq2.cee.redhat.com \
    node-1.rajranja.lab.pnq2.cee.redhat.com \
    node-2.rajranja.lab.pnq2.cee.redhat.com \
    node-3.rajranja.lab.pnq2.cee.redhat.com \
    node-4.rajranja.lab.pnq2.cee.redhat.com \
    node-5.rajranja.lab.pnq2.cee.redhat.com \
    node-6.rajranja.lab.pnq2.cee.redhat.com \
    node-7.rajranja.lab.pnq2.cee.redhat.com \
    node-8.rajranja.lab.pnq2.cee.redhat.com \
    node-9.rajranja.lab.pnq2.cee.redhat.com \
    lb-0.rajranja.lab.pnq2.cee.redhat.com;  \
do ssh -t -i quicklab.key -l quicklab $host "hostname";
done