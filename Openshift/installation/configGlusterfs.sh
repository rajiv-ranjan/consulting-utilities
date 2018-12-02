#!/bin/bash

#Red Hat Gluster Storage Software Requirements

###
yum install glusterfs-fuse

###
subscription-manager repos --enable=rh-gluster-3-client-for-rhel-7-server-rpms

###
yum update glusterfs-fuse