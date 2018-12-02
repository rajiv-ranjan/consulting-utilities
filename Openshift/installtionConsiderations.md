### Bastion Host
It's required as this machine will run installation connetions with the rest of the openshift infrastructure. Remember it's not part of the openshift cluster. This can be a laptop/workstation that has access to openshift servers/VMs.

Some Key paths/locations
|Location/Path|Purpose|Sizing|Growth|
|----|----|----|----|
|/var/lib/openshift|Used for etcd storage only when in single master mode and etcd is embedded in the *atomic-openshift-master* process|Less than 10GB.|Will grow slowly with the environment. Only storing metadata.|
|/var/lib/etcd|Used for etcd storage when in Multi-Master mode or when etcd is made standalone by an administrator.|Less than 20 GB.|Will grow slowly with the environment. Only storing metadata|
|/var/lib/docker|When the run time is docker, this is the mount point. Storage used for active container runtimes (including pods) and storage of local images (not used for registry storage). Mount point should be managed by docker-storage rather than manually.|50 GB for a Node with 16 GB memory.Additional 20-25 GB for every additional 8 GB of memory.|Growth is limited by the capacity for running containers.|
|/var/lib/containers|When the run time is CRI-O, this is the mount point. Storage used for active container runtimes (including pods) and storage of local images (not used for registry storage).|50 GB for a Node with 16 GB memory.Additional 20-25 GB for every additional 8 GB of memory.|Growth limited by capacity for running containers|
|/var/lib/origin/openshift.local.volumes|Ephemeral volume storage for pods. This includes anything external that is mounted into a container at runtime. Includes environment variables, kube secrets, and data volumes not backed by persistent storage PVs.|Varies|Minimal if pods requiring storage are using persistent volumes. If using ephemeral storage, this can grow quickly.|
|/var/log|Log files for all components.|10 to 30 GB|Log files can grow quickly; size can be managed by growing disks or managed using log rotate.|
|/usr/share/openshift/examples/  /etc/origin/examples/|the default image stream and template files. First is for rpm based and second is for atomic host based.|
|/usr/local/bin/|master node needs this for --- |||
|/var/tmp /tmp|System's temp file system. First one persists across reboots and second one doesn't|||
|https://access.redhat.com/articles/2176281|Red Hat Supported configurations|||
