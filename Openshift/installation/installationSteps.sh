#!/bin/bash

### Parameters to the script
### $1  :   subscriber username
### $2  :   password of the subscriber
### $3  :   pool id with openshift subscription

### infra provisioned


######################################################################################################
###             Preparing your hosts
######################################################################################################

###### Operating system requirements
### Install RHEL 7.5 (>=7.4). VMs provisioned had RHEL 7.6 installed
cat /etc/redhat-release

###### Setting PATH
### Done as part of OS installation
if [[ -d /bin ]] || [[ -d /sbin ]] || [[ -d /usr/bin ]] || [[ -d /usr/sbin ]]; then
    echo "PATH CHECK SUCCESS"
else
    echo "PATH CHECK FAIL"
fi
echo "PATH = $PATH" 

###### Ensuring host access
### Generate passwordless key pair
#ssh-keygen

# distribute key pair to all hosts
#for host in master.example.com \
#    master.example.com \ 
#    node1.example.com \  
#    node2.example.com; \ 
#    do ssh-copy-id -i ~/.ssh/id_rsa.pub $host; \
#done
#for host in master.example.com \
#    master.example.com \ 
#    node1.example.com \  
#    node2.example.com; \ 
#    do ssh -v -i ~/.ssh/id_rsa $host; \
#done

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




##### Setting proxy overrides
##
## Master and node host names or their domain suffix.
## Other internal host names or their domain suffix.
## Etcd IP addresses. You must provide IP addresses and not host names because etcd access is controlled by IP address.
## Kubernetes IP address, by default 172.30.0.1. Must be the value set in the openshift_portal_net parameter in your inventory file.
## Kubernetes internal domain suffix, cluster.local.
## Kubernetes internal domain suffix, .svc.
## no_proxy=.internal.example.com,10.0.0.1,10.0.0.2,10.0.0.3,.cluster.local,.svc,localhost,127.0.0.1,172.30.0.1




### Subscription will register the system and make the correct repolist available
./registration.sh $1 $2 $3


### Installing base packages
./installBasePackages.sh 

### Installing Docker
./installDocker.sh

### Config thin pool logical volume for docker storage
./setDockerStorageToThinPoolStorage.sh

### start docker service
./startDockerService.sh

### restrict the docker log size
./restrictDockerLogSize.sh


### restrict local volume usage
./restrictLocalVolumeUsages.sh

### config glusterfs as per need
./configGlusterfs.sh

### check the DNS name resolution
# below will show all the entries for the FQDN in DNS. Run a loop for all the hosts.
# dig +noall +answer lb-0.rajranja.lab.pnq2.cee.redhat.com