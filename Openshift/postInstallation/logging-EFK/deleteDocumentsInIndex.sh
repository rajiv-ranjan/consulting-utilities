#!/bin/ksh
# file passed as parameter will have indexes that needs cleaning.
# One of the way to generate is: 
# curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/indices?v | grep -i '.operations' | awk {'print $3'} > indexes.in
# curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -XGET https://logging-es:9200/_cat/indices?v | grep -i '.orphaned' | awk {'print $3'} >> indexes.in
# cat indexes.in

file=$1
while IFS= read line
do
    echo "About to delete documents from index: $line"
    curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X POST "https://logging-es:9200/$line/_delete_by_query?conflicts=proceed" -H 'Content-Type: application/json' -d'
    {
        "query": {
        "match_all": {}
        }
    }'
	
done <"$file"