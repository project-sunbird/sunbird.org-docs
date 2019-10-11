---
title: Syncing User Data
page_title: Syncing User Data
description: Details on how to sync users data
keywords: sync, user sync, user sync job 
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.
In case of Cassandra migration that affects all users data (e.g. UserProfileVisibilityReset, UserChannelMigration, etc.), this job is used to sync all user's data from Cassandra to Elasticsearch.

## Prerequisites

To sync user data, you need:

1. Access to Cassandra database
2. API Key to access the Sync API

## Configuration Parameters

Pass the following parameters as arguments for the sync job:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. | abc@xyz.com 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB.| password 
5 | sunbird_user_sync_api_endpoint  | The [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
6 | sunbird_user_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
7 | sunbird_user_sync_block_size | The number of user records to be synced per API call. | 100 
8 | sunbird_user_sync_sleep_time | The time interval in milliseconds between API calls. | 10000
9 | sunbird_sync_id_file | Path of csv file, with no headers, containing user ids to be synced | /home/userIds.csv
10| sunbird_cassandra_table | Name of the table in cassandra to be synced to elastic search | user
11| sunbird_sync_object_type | Type of the object to be synced to elastic search | user

> Note: If you do not need to authenticate access to the API, pass `""` value for the **username** and **password** parameters.

## Syncing User Data

To sync user data from Cassandra to Elasticsearch:

1. Extract the [archive file](https://github.com/project-sunbird/sunbird-utils/tree/master/cassandra-migration-etl/common/UserSyncBin.zip) that contains the script to sync the user's data.

2. Run the following command to sync **all users** data.

````
UserSync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_user_sync_api_endpoint="{sunbird_user_sync_api_endpoint}" --context_param sunbird_user_sync_api_key="{sunbird_user_sync_api_key}" --context_param sunbird_user_sync_block_size="{sunbird_user_sync_block_size}" --context_param sunbird_user_sync_sleep_time="{sunbird_user_sync_sleep_time}" --context_param sunbird_cassandra_table="user" --context_param sunbird_sync_object_type="user"
````
This job doesn't supports for specified users.

3. On completion, refer to the success and failure logs that are generated 
