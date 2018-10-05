---
title: Syncing User Data
page_title: Syncing User Data
description: Details on how to sync users data
keywords: sync, user sync, user sync job 
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in cassandra and read operations are done in elastic search.
Post write operations in cassandra, the data is written into elastic search as well, asynchronously.
In the event of any cassandra migration(UserProfileVisibilityReset, UserChannelMigration, etc..) affecting all users data, this job can be used to sync all users data from cassandra to elastic search.

## Prerequisites

To sync the users data, ensure you have:

1. Access to cassandra database
2. API Key to access Sync API

## Configuration Parameters

The following parameters needs to be passed as arguments for the user sync job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_user_sync_api_endpoint  | Sync API endpoint | {{domain}}/api/data/v1/index/sync 
6 | sunbird_user_sync_api_key | API Key to access Sync API | {{api_key}} 
7 | sunbird_user_sync_block_size | Number of user records to be synced per api call | 100 
8 | sunbird_user_sync_sleep_time | Time interval in milliseconds between api calls | 10000

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Syncing User Data

To sync the data of all the users from cassandra to elastic search:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/common/UserSyncBin.zip) that contains the script to sync the users data

2. Run the following command to sync all users data
<pre> 
UserSync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_user_sync_api_endpoint="{sunbird_user_sync_api_endpoint}" --context_param sunbird_user_sync_api_key="{sunbird_user_sync_api_key}" --context_param sunbird_user_sync_block_size="{sunbird_user_sync_block_size}" --context_param sunbird_user_sync_sleep_time="{sunbird_user_sync_sleep_time}"
</pre>

3. On completion, success and failure logs would be generated and shown
