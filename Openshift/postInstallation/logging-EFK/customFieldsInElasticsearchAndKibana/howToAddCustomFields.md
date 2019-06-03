## Approach 1
* Generate the logs in json format. Steps for a Fuse spring boot app is [here](https://github.com/rajiv-ranjan/consulting-utilities/blob/master/Fuse-Camel/generateLogsInJsonFormat.md)
* Fluentd will pick the docker logs from stdout and if json then will merge with the meta data. Post that it ships the json payload to es.
* refresh the fields in the kibana for a particular index.
* Use the fields for filter, visualisation and dashboards

## Approach 2
* logs can be generated in the default journald format.
* Follow the below two links to add new fields to templates.
https://richm.github.io/add-fields-to-index-template
https://richm.github.io/how-to-add-fields-to-kibana
* Use the fields for filter, visualisation and dashboards