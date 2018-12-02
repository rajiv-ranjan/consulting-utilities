#!/bin/bash

## CLARIFY

#To configure the log file, edit the /etc/sysconfig/docker file. For example, to set the maximum file size to 1 MB and always keep the last three log files, set the following options:

# OPTIONS='--insecure-registry=172.30.0.0/16 --selinux-enabled --log-opt max-size=1M --log-opt max-file=3'
# See Docker’s documentation for additional information on how to configure logging drivers https://docs.docker.com/engine/admin/logging/overview/#/options .

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
    do echo "##### checking the docker-pool lv for : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo systemctl restart docker"; \
done


