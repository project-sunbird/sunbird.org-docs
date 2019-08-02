---
title: Core Elasticsearch Upgrade
page_title:  Core Elasticsearch Upgrade
description:  Core Elasticsearch Upgrade
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0, Core, elasticsearch
---


Core Elasticsearch has been upgraded from 5.x version to 6.x. This is done in order to remove overheads in maintaining two versions of elasticsearch - One for Core services and other for Knowledge Platform. With this upgrade, we will be able to use a single elasticsearch cluster for both Core services and Knowledge Platform thereby benefitting in cost and maintenance. Please follow the below steps for this process.



Backup:
Take backup of Core elasticsearch indexes 

Switch to root user and ensure you have these values available in elasticsearch.yml file under /etc/elasticsearch/your_node_name/elasticseach.yml

cloud.azure.storage.default.account:              # Your azure backup account name

cloud.azure.storage.default.key:                     # Your azure backup account key

Install elastisearch azure plugin if its not already installed

export ES_PATH_CONF=/etc/elasticsearch/your_node_name

cd /usr/share/elasticsearch/

bin/elasticsearch-plugin install repository-azure

Restart elasticsearch service 

sudo systemctl restart your_node_name_elasticsearch.service

curl -XPUT http://localhost:9200/_snapshot/azurebackup -H 'Content-Type: application/json' -d '{ "type": "azure", "settings": { "container": "elasticsearch-snapshots", "base_path": "application_elasticsearch"} }'

curl -XPUT http://localhost:9200/_snapshot/azurebackup/snapshot_back_name -H 'Content-Type: application/json' -d '{"include_global_state": false}'

Install jq

sudo apt-get install jq

Verify your backup was successful - curl http://localhost:9200/_snapshot/azurebackup/_all | jq

The above command will give you the snapshot name - "snapshot": "snapshot_1563878417" and "state": "SUCCESS"

Or you can use this command to check status - 

curl -XPUT http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_status | jq

Login to azure and verify in the storage account that backup files are created. The container name will be elasticsearch-snapshots and blob name will be application_elasticsearch



Restore:

Go to the Knowledge platform elasticsearch machine machine and restore the indexes which we took in previous step

Switch to root user and ensure you have these values available in elasticsearch.yml file under /etc/elasticsearch/your_node_name/elasticseach.yml

cloud.azure.storage.default.account:              # Your azure backup account name

cloud.azure.storage.default.key:                     # Your azure backup account key

Note: The account and key should be same as the one used for backup

Install elastisearch azure plugin if its not already installed

export ES_PATH_CONF=/etc/elasticsearch/your_node_name

cd /usr/share/elasticsearch/

bin/elasticsearch-plugin install repository-azure

Restart elasticsearch service 

sudo systemctl restart your_node_name_elasticsearch.service

curl -XPOST http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_restore

curl -XPOST http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_status | jq

The above command will give you the snapshot name - "snapshot": "snapshot_1563878417" and "state": "SUCCESS"

The state of the indexes might take some time to turn in YELLOW state



For more information on backup, restore and advanced configurations for the azure plugin, please refer

https://www.elastic.co/guide/en/elasticsearch/reference/6.4/modules-snapshots.html



ES Mapping:

Ensure your core inventory is updated with the IP of the new Elasticsearch cluster (Knowledge platform ES cluster)

Go to jenkins and run the job ESMapping located under Deploy → Core → ESMapping

For more information on what this job does, take a loot at this reference Elasticsearch mapping update job steps.



Migration of core elasticsearch data from old index to new indices:

Since mapping types are deprecated with the new version of elasticsearch, we will have to reindex our indexes to be compatible with the new ES. Below are the set of commands that need to be run on the Knowledge platform ES VM.

curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"user"},"dest":{"index":"user","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"org"},"dest":{"index":"org","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"location"},"dest":{"index":"location","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usernotes"},"dest":{"index":"usernotes","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"badgeassociations"},"dest":{"index":"badgeassociations","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"cbatch"},"dest":{"index":"cbatch","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"userprofilevisibility"},"dest":{"index":"userprofilevisibility","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usercourses"},"dest":{"index":"usercourses","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcement"},"dest":{"index":"announcement","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcementtype"},"dest":{"index":"announcementtype","type":"_doc"}}'
curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"metrics"},"dest":{"index":"metrics","type":"_doc"}}'

For more information of mapping typee deprecation, please take a look at this reference - Sunbird Elasticsearch migration to multi index

This completes the first 3 steps of the upgrade related to Elasticsearch