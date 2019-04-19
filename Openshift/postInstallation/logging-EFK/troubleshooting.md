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
