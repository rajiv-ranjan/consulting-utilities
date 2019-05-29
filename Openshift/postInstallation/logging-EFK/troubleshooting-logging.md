oc exec logging-es-ops-data-master-6gsh7iga-2-cd8cw -- curl -s --key /etc/elasticsearch/secret/admin-key --cert /etc/elasticsearch/secret/admin-cert --cacert /etc/elasticsearch/secret/admin-ca -XDELETE https://localhost:9200/.searchguard

curl -s --key /etc/elasticsearch/secret/admin-key --cert /etc/elasticsearch/secret/admin-cert --cacert /etc/elasticsearch/secret/admin-ca -XDELETE https://localhost:9200/.kibana.598bb1b6e4c0a3f3a6760bf781f813c9e6217b4d




logging-es-ops-data-master-6gsh7iga-2-cd8cw
logging-es-ops-data-master-cudwh0jv-2-lptpf
logging-es-ops-data-master-kkko26zg-2-2nw2z
logging-es-ops-data-master-ypnhdx6d-2-s2wsd


oc exec $es_pod -- curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/indices?v 


curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/indices?v | grep searchguard


curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cluster/state


curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cluster/state?pretty


$ oc exec $es_pod -- curl -s --key /etc/elasticsearch/secret/admin-key --cert /etc/elasticsearch/secret/admin-cert --cacert /etc/elasticsearch/secret/admin-ca -XDELETE https://localhost:9200/<index_name>


$ oc exec $es_pod -- curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/indices?v 


* To get the list of categories
oc exec $es_pod -- curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat

* To get the allocations
oc exec $es_pod -- curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/allocation?v

* To get the health of the cluster
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/shards | grep UNASSIGNED | awk {'print $1'} | xargs -i curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key  -XDELETE "https://logging-es:9200/{}"
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED 
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/health?v
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/allocation?v
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cluster/allocation/explain?pretty
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/indices?v 




curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es-ops:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED 
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es-ops:9200/_cat/health?v
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es-ops:9200/_cat/allocation?v
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es-ops:9200/_cluster/allocation/explain?pretty
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es-ops:9200/_cat/indices?v 

export logging-es-pod=logging-es-ops-data-master-6gsh7iga-3-l6rh6
oc exec logging-es-ops-data-master-6gsh7iga-3-l6rh6 — curl -s —key /etc/elasticsearch/secret/admin-key —cert /etc/elasticsearch/secret/admin-cert —cacert /etc/elasticsearch/secret/admin-ca https://localhost:9200/.operations.2019.05.24/_search? | python -mjson.tool | more

4e74cbe9-8538-4b25-869b-0babbc5a29a5
10.128.62.79
~~~~~~~~~~~~~~~~



curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/_cat/health?v

* To delete the searchgaurd es_util can be used from the pod

```sh
# Delete any index via es_util
es_util --query=.searchguard -XDELETE
```
* To check the health of the elasticsearch cluster; run below from es pod

```sh
es_cluster_health

{
  "cluster_name" : "logging-es",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 3,
  "number_of_data_nodes" : 3,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```

* Elasticsearch shows duplicated logs and poor performance in OpenShift Container Platform
https://access.redhat.com/solutions/3214991

* Delete the documents in index

curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/indices?v | grep -i '.operations' | awk {'print $3'} | xargs -i curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X POST "https://localhost:9200/{}/_delete_by_query?conflicts=proceed" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}
'

.operations.2019.05.16
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.05.14
.operations.2019.04.26
.operations.2019.04.24
.operations.2019.05.04
.operations.2019.05.09
.operations.2019.05.13
.operations.2019.04.28
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.05.15
.operations.2019.05.10
.operations.2019.05.15
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.05.16
project.app-storage.d04ea3b7-48b9-11e9-adf0-fa163e7ec45b.2019.05.11
.operations.2019.05.12
.operations.2019.05.05
.operations.2019.05.11
.operations.2019.05.14
.operations.2019.04.27
.operations.2019.05.07
.operations.2019.05.03
.operations.2019.05.06

for index in 

curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X POST "https://localhost:9200/.operations.2019.05.12/_delete_by_query?conflicts=proceed" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}
'


* How to delete shards
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/shards | grep UNASSIGNED | awk {'print $1'} | xargs -i curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key  -XDELETE "https://logging-es:9200/{}"


* GET Queries

```sh
export indexName=project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.05.17
curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key https://logging-es:9200/$indexName/_search?pretty -d '{ "query": {"match_all" : {}} }'
```



* to change the fields coming in app logs

curl  -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X PUT "https://logging-es:9200/project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.05.15/_mapping/com.redhat.viaq.common" -H 'Content-Type: application/json' -d'
{
    "properties": {
        "appGreeterName": {
            "type": "text"
        },
        "appPodIp": {
            "type": "text"
        }       
    }
}'

curl   -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X PUT "https://logging-es:9200/project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.05.15/_mapping/com.redhat.viaq.common?update_all_types" -H 'Content-Type: application/json' -d'
{
    "properties": {
        "appGreeterName": {
            "type": "text",
            "analyzer": "standard",
            "search_analyzer": "whitespace" 
        },
        "appPodIp": {
            "type": "text"
        }       
    }
}'

curl   -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X PUT "https://logging-es:9200/project.fuse-3.cc88c784-741a-11e9-82a0-fa163e0bcd4d.2019.05.15/_mapping/com.redhat.viaq.common?update_all_types" -H 'Content-Type: application/json' -d'
{
    "properties": {
        "appGreeterName": {
            "type": "text"
        },
        "appPodIp": {
            "type": "text"
        }       
    }
}'