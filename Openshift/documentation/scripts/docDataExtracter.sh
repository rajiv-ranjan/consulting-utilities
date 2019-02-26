#! /bin/bash

# unset the variables
unset MASTER_PUBLIC_URL MASTER_INTERNAL_URL WILDCARD_APP_SUBDOMAIN 
unset INVENTORY_FILE_PATH MASTER_PUB_CERT_FILE_PATH WILDCARD_APP_CERT_FILE_PATH 
unset INTERMEDIATE_CERT_FILE_PATH ROOT_CERT_FILE_PATH


usage()
{
  echo "Usage: $0 [-n INVENTORY_FILE_PATH] 
                             [-I MASTER_INTERNAL_URL] 
                             [-P MASTER_PUBLIC_URL ] 
                             [-p MASTER_PUB_CERT_FILE_PATH]
                             [-A WILDCARD_APP_SUBDOMAIN ]
                             [-a WILDCARD_APP_CERT_FILE_PATH]
                             [-y INTERMEDIATE_CERT_FILE_PATH]
                             [-z ROOT_CERT_FILE_PATH]"
  exit 2
}


while getopts 'n:I:P:p:A:a:y:z:' c
do
    case $c in
        n) INVENTORY_FILE_PATH=$OPTARG;;
        I) MASTER_INTERNAL_URL=$OPTARG;;
        P) MASTER_PUBLIC_URL=$OPTARG;;
        p) MASTER_PUB_CERT_FILE_PATH=$OPTARG;;
        A) WILDCARD_APP_SUBDOMAIN=$OPTARG;;
        a) WILDCARD_APP_CERT_FILE_PATH=$OPTARG;;
        y) INTERMEDIATE_CERT_FILE_PATH=$OPTARG;;
        z) ROOT_CERT_FILE_PATH=$OPTARG;;
        h|?) usage ;;
    esac
done

############# MAIN PROGRAM STARTS HERE

mkdir documentation && cd documentation

############# COLLECT RHEL DETAILS
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'timedatectl' > timedatectl.log
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'lscpu' > lscpu.log
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'cat /proc/meminfo' > meminfo.log
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'df -h' > df.log
ansible -i $INVENTORY_FILE_PATH OSEv3  -a 'getenforce' > selinux.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'hostname -f' > hostname-f.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'hostname' > hostname.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/resolv.conf' > DNS_resolve.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/environment' > environment-file.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'env' > env.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'subscription-manager status' > subs-manager.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'yum repolist' > repo-list.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/redhat-release' > redhat-release.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/sysconfig/docker-storage-setup' > docker-storage-setup.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/sysconfig/docker-storage' > docker-storage.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'systemctl is-active docker' > docker-isactive.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'lsblk' > lsblk.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'cat /etc/ntp.conf' > ntp.log
ansible -i $INVENTORY_FILE_PATH OSEv3 -a 'ifconfig' > ifconfig.log

# run below from bastion server
# get app wild card resolution
dig abc.$WILDCARD_APP_SUBDOMAIN > dig-app-wildcard-subdomain.log
# get details of master public certs
openssl x509 -noout -text -in $MASTER_PUB_CERT_FILE_PATH > master-public-certs-description.log
# get details of app router certs
openssl x509 -noout -text -in $WILDCARD_APP_CERT_FILE_PATH > app-certs-description.log
# get details of intermediate certs
openssl x509 -noout -text -in $INTERMEDIATE_CERT_FILE_PATH > intermediate-certs-description.log
# get details of root certs
openssl x509 -noout -text -in $ROOT_CERT_FILE_PATH > root-certs-description.log
# get user details
id

############# COLLECT OPENSHIFT CLUSTER DETAILS
oc login -u $OPENSHIFT_CLUSTER_ADMIN_USERNAME -p $OPENSHIFT_CLUSTER_ADMIN_PASSWORD $MASTER_PUBLIC_URL

oc get nodes -o wide > nodes.log

#user management
oc get users
oc get identities

# storage data
oc get pv > pv.log
oc get sc > sc.log

# network details
oc get clusternetwork > clusternetwork.log
oc get hostsubnets > hostsubnets.log
oc get netnamespaces > netnamespaces.log

# components health
oc get componentstatuses > componentstatuses.log

############# EXTRACT K8S OBJECT DETAIL FROM OC PROJECTS
./extractK8sObjects
