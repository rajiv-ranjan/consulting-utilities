#!/bin/bash

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
    do echo "##### checking the docker-pool lv for : $host ##########" && ssh -t -i quicklab.key -l quicklab $host "sudo systemctl enable docker && sudo systemctl start docker && sudo systemctl is-active docker"; \
done

