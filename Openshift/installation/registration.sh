#!/bin/bash

# $1    :   subscriber
# $2    :   subscriber password
# $3    :   pool id

### registering the host 
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
    do echo "##### Registering : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo subscription-manager register --force --username=$1 --password=$2 && sudo subscription-manager refresh && sudo subscription-manager attach --pool=$3 && sudo subscription-manager refresh "; \
done

### preparing the repolist
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
    do echo "########## Preparing the repo for : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo subscription-manager repos --disable=\"*\" && sudo yum repolist && sudo yum-config-manager --disable \\* && sudo subscription-manager repos --enable='rhel-7-server-rpms' --enable='rhel-7-server-extras-rpms' --enable='rhel-7-server-ose-3.11-rpms' --enable='rhel-7-server-ansible-2.6-rpms' "; \
done











