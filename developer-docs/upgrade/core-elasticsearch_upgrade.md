---
title: Core Elastic Search
page_title: Core Elastic Search 
description:  Core Elasticsearch Upgrade
published: true
allowSearch: true
keywords: Upgrade, Sunbird 3.7.0, Core, elasticsearch
---

## Overview

Core Elasticsearch has been upgraded from 5.x version to 6.x. This is done in order to remove overheads in maintaining two versions of elasticsearch for Core services and Knowledge Platform. With this upgrade, we will be able to use a single elasticsearch cluster for both Core services and Knowledge Platform thereby benefitting in cost and maintenance. 

Follow the steps to upgrade core Elasticsearch.

### Backup

1.Take backup of Core elasticsearch indexes.

2.Switch to root user and ensure you have these values available in elasticsearch.yml file under `/etc/elasticsearch/your_node_name/elasticseach.yml`

`cloud.azure.storage.default.account:  `    // Your azure backup account name

`cloud.azure.storage.default.key:`          // Your azure backup account key


### Install Elastisearch Azure Plugin 

3.Install Elasticsearch plugin in case it is not installed. 

        export ES_PATH_CONF=/etc/elasticsearch/your_node_name

        cd /usr/share/elasticsearch/

        bin/elasticsearch-plugin install repository-azure

4.Restart Elasticsearch service 

        sudo systemctl restart your_node_name_elasticsearch.service

5.Create Azure repository and take the backup. Use the following steps:

        curl -XPUT http://localhost:9200/_snapshot/azurebackup -H 'Content-Type: application/json' -d '{ "type": "azure", "settings": { "container": "elasticsearch-snapshots", "base_path": "application_elasticsearch"} }'

        curl -XPUT http://localhost:9200/_snapshot/azurebackup/snapshot_back_name -H 'Content-Type: application/json' -d '{"include_global_state": false}'

6.Verify your backup        
        Install jq

        sudo apt-get install jq
         curl http://localhost:9200/_snapshot/azurebackup/_all | jq

The above command will give you the snapshot name - "snapshot": "snapshot_1563878417" and "state": "SUCCESS"

Or you can use this command to check status - 

        curl -XPUT http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_status | jq

7.Login to azure and verify in the storage account that backup files are created. The container name will be elasticsearch-snapshots and blob name will be application_elasticsearch



### Restore
Once backup is completed, restore the Elasticsearch indexes.

1.Go to the Knowledge platform elasticsearch machine and restore the indexes which we took in previous step

2.Switch to root user and ensure you have these values available in elasticsearch.yml file under `/etc/elasticsearch/your_node_name/elasticseach.yml`

`cloud.azure.storage.default.account:  `    // Your azure backup account name

`cloud.azure.storage.default.key:`          // Your azure backup account key

Note: The account and key should be same as the one used for backup

3.Install Elasticsearch plugin in case it is not installed. 

        export ES_PATH_CONF=/etc/elasticsearch/your_node_name

        cd /usr/share/elasticsearch/

        bin/elasticsearch-plugin install repository-azure

4.Restart Elasticsearch service 

        sudo systemctl restart your_node_name_elasticsearch.service

5.Run the following commands to start restoration:

        curl -XPOST http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_restore

6.Verify your restoration:

        curl -XPOST http://localhost:9200/_snapshot/azurebackup/snapshot_back_name/_status | jq

The above command will give you the snapshot name - "snapshot": "snapshot_1563878417" and "state": "SUCCESS".

The state of the indexes might take some time to turn in YELLOW state

For more information on backup, restore and advanced configurations for the azure plugin, please refer https://www.elastic.co/guide/en/elasticsearch/reference/6.4/modules-snapshots.html



### Elasticsearch Mapping

Ensure your core inventory is updated with the IP of the new Elasticsearch cluster (Knowledge platform ES cluster)

Go to jenkins and run the job ESMapping located under **Deploy** → **Core** → **ESMapping**

For more information on what this job does, take a look at this reference Elasticsearch mapping update job steps.


### Migration of Core Elasticsearch Data from the Old Index to New Indices

Since mapping types are deprecated with the new version of elasticsearch, we will have to reindex our indexes to be compatible with the new ES. Below are the set of commands that need to be run on the Knowledge platform ES VM.

{es-ip}: Elasticsearch ip
{es-port}:Elasticsearch port

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

For more information of mapping type deprecation, refer - [Sunbird Elasticsearch Migration to Multi-index](developer-docs/migration)

This completes the first 3 steps of the upgrade related to Elasticsearch

