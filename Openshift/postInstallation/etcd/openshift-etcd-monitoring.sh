#!/bin/bash

# This OpenShift Monitoring Script is prepared for version 3.7
# Written by Alex Alexandrov (aalexand@redhat.com) and Shah Zobair (szobair@redhat.com)
# Recommended to execute by cronjob from each Master nodes
# For example to execute it for every 5 mins: 
# #crontab -e
# */5 * * * *	/root/openshift_monitoring.sh >/dev/null 2>&1

#oc login -u system:admin --config=/etc/origin/master/admin.kubeconfig 

DATE=`date`
SERVER=`grep server /etc/origin/master/openshift-master.kubeconfig | cut -f6 -d" "`

# Get a configmap from current Master to check the execution time
{ time oc get cm -n logging --config=/etc/origin/master/admin.kubeconfig --server=$SERVER; } > /root/output 2>&1

OC_OUTPUT=`grep -o NAME /root/output`

if [[ -n $OC_OUTPUT ]];then

 REAL_TIME=`grep real /root/output | cut -f2`

 # Collect Master API and Controller data
 oc get --raw /metrics --config=/etc/origin/master/admin.kubeconfig --server=$SERVER > /root/output_metrics_api

 SERVER=`echo $SERVER | sed s/:8443//g`

 oc get --raw /metrics --config=/etc/origin/master/admin.kubeconfig --server=$SERVER:8444 > /root/output_metrics_controller

 AUTH_USER_COUNT=`grep "authenticated_user_requests{username=" output_metrics_controller | cut -f2 -d" "`

 API_SERVICE_ADD_COUNT=`grep "^APIServiceRegistrationController_adds" output_metrics_api  | cut -f2 -d" "`


else

 REAL_TIME=ERROR
 AUTH_USER_COUNT=ERROR
 API_SERVICE_ADD_COUNT=ERROR

fi


#####################
#etcd_average_latency_check.sh
#####################

cat /etc/origin/master/master.etcd-client.crt /etc/origin/master/master.etcd-client.key > /tmp/etcd-client.crt

SELF_URL=`grep ETCD_LISTEN_CLIENT_URLS /etc/etcd/etcd.conf | sed s/'ETCD_LISTEN_CLIENT_URLS='//g`
LEADER_URL=`etcdctl -C $SELF_URL --ca-file=/etc/origin/master/master.etcd-ca.crt --cert-file=/etc/origin/master/master.etcd-client.crt --key-file=/etc/origin/master/master.etcd-client.key member list | grep "isLeader=true" | awk '{print $4}' | sed s/'clientURLs='//g`
AVERAGE_LATENCY=`curl -s -k -E /tmp/etcd-client.crt --cacert /etc/origin/master/master.etcd-ca.crt $LEADER_URL/v2/stats/leader | python -mjson.tool | grep "average" | sed s/'"average": '//g | sed s/' '//g | sed s/','//g | sort -n -r | head -n 1`

#echo $AVERAGE_LATENCY

#####################
#etcd_current_latency_check.sh
#####################

# 0.008 Sec is WARNING
# 0.011 Sec is Critical
#No JSON object could be decoded

MAX_LATENCY=`curl -s -k -E /tmp/etcd-client.crt --cacert /etc/origin/master/master.etcd-ca.crt $LEADER_URL/v2/stats/leader | python -mjson.tool | grep "current" | sed s/'"current": '//g | sed s/' '//g | sed s/','//g | sort -n -r | head -n 1`

if [[ "$MAX_LATENCY" == "No JSON object could be decoded" ]]
then
        MAX_LATENCY=NA
fi

#####################
#etcd_receive_append_request_check.sh
#####################

RECIEVE_APPEND=`curl -s -k -E /tmp/etcd-client.crt --cacert /etc/origin/master/master.etcd-ca.crt $SELF_URL/v2/stats/self | python -mjson.tool | grep "recvAppendRequestCnt" | sed s/'"recvAppendRequestCnt": '//g | sed s/' '//g | sed s/','//g`

#echo $RECIEVE_APPEND

#####################
#All Output
#####################
ETCD_OUTPUT=`echo "ETCD_AVERAGE_LATENCY=$AVERAGE_LATENCY|ETCD_MAX_LATENCY=$MAX_LATENCY|ETCD_RECIEVE_APPEND_COUNT=$RECIEVE_APPEND"`
OUTPUT=`echo "$DATE|$(hostname -f)|GET_CM_TIME=$REAL_TIME|CONTROLLER_AUTH_USER_COUNT=$AUTH_USER_COUNT|API_SERVICE_ADD_COUNT=$API_SERVICE_ADD_COUNT|$ETCD_OUTPUT"`

#echo $OUTPUT
#echo $OUTPUT >> /var/log/messages
echo $OUTPUT >> /var/log/openshift_monitoring.log