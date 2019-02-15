---
title: Syncing Data from cassandra to Elasticsearch
page_title: Syncing Data
description: Details on how to sync data
keywords: sync, sync job 
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.
In case of Cassandra migration that affects data (e.g. UserProfileVisibilityReset, UserChannelMigration, etc.), this job is used to sync data from Cassandra to Elasticsearch.

## Prerequisites

To sync data, you need:

1. Access to Cassandra database
2. API Key to access the Sync API

## Configuration Parameters

Pass the following parameters as arguments for the user sync job:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. This is optional parameter incase system don't have pass it as '""' empty| cassandra username 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. This is optional parameter incase system don't have pass it as '""' empty| password 
5 | sunbird_sync_api_endpoint  | [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
6 | sunbird_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
7 | sunbird_sync_block_size | The number of user records to be synced per API call. | 100 
8 | sunbird_sync_sleep_time | The time interval in milliseconds between API calls. | 5000
9 | sunbird_sync_id_file | The file location consisting ids in csv file to be synced | \home\userIds.csv (this id can be user, organisation , course-batch or batch and one file should have only one type of ids.
10 | sunbird_cassandra_table | the table to refer in case of full sync without id file | user, course_batch
11 | sunbird_sync_object_type | the object type which needs to be synced | user, batch,organisation,user_course 
12 | dry_run | default to true, dry run will not make the sync call to server, can be used to check id in generated file before rerun with dry_run false | true


## Syncing Data

To sync data from Cassandra to Elasticsearch:

1. Extract the [archive file](https://github.com/project-sunbird/sunbird-utils/tree/master/cassandra-migration-etl/common/SyncBin.zip) that contains the script to sync the data.

2. Run the following command to sync data.

````
Sync_run.sh --context_param dry_run={dry_run} --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}" --context_param sunbird_cassandra_table="{sunbird_cassandra_table}" --context_param sunbird_sync_object_type="{sunbird_sync_object_type}" --context_param sunbird_sync_id_file="{sunbird_sync_id_file}"
````
3. On completion, refer to the success and failure logs that are generated 