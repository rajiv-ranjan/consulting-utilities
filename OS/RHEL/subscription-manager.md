|Command|Purpose|
|----|----|
|||
|subscription-manager repos --enable=rh-gluster-3-client-for-rhel-7-server-rpms |To enable glusterfs repo|

subscription-manager list --available

subscription-manager attach --auto

subscription-manager attach --pool=7b64f895519e98de4138735cea132a

subscription-manager list --consumed



/etc/yum.repos.d/redhat.repo
yum repolist
yum-config-manager --enable rhel-6-server-sam-rpms

subscription-manager unregister
subscription-manager clean