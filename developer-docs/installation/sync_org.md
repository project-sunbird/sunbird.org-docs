---
title: Syncing Organisation Data
page_title: Syncing Organisation Data
description: Details on how to sync organisation's data
keywords: sync, org sync, org sync job 
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.
In case of Cassandra migration that affects all organisation's data (e.g. OrgExternalIdentityMigration, OrgChannelMigration, etc.), this job is used to sync all organisation's data from Cassandra to Elasticsearch.

## Prerequisites

To sync organisation data, you need:

1. Access to Cassandra database
2. API Key to access the Sync API

## Configuration Parameters

Pass the following parameters as arguments for the organisation sync job:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. | abc@xyz.com 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB.| password 
5 | sunbird_sync_api_endpoint  | [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
6 | sunbird_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
7 | sunbird_sync_block_size | The number of org records to be synced per API call. | 1000 
8 | sunbird_sync_sleep_time | The time interval in milliseconds between API calls. | 5000

> Note: If you do not need to authenticate access to the cassandra, pass `""` value for the **username** and **password** parameters.

## Syncing Organisation Data

To sync organisation data from Cassandra to Elasticsearch:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/r1.13/OrgSyncBin.zip) that contains the script to sync the organisation's data.

2. Run the following command to sync all organisation's data.

````
OrgSync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}"
````
3. On completion, refer to the success and failure logs that are generated 
