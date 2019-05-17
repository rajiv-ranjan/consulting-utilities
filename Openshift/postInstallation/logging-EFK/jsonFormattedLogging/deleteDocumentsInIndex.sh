#!/bin/ksh
file=$1
while IFS= read line
do
    echo "About to delete documents from index: $line"
    curl -s -k --cert /etc/elasticsearch/secret/admin-cert --key /etc/elasticsearch/secret/admin-key -X POST "https://localhost:9200/$line/_delete_by_query?conflicts=proceed" -H 'Content-Type: application/json' -d'
    {
        "query": {
        "match_all": {}
        }
    }'
	
done <"$file"