---
title: user data encryption
page_title: user data encryption
description: user data encryption
published: true
allowSearch: true
---

## Overview
This job will make a call to encryption service api to encrypt user data.

## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters needs to be passed as arguments for the identifying unencrypted users data job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | cassandra_port | Cassandra DB Port Number | 9042 
3 | cassandra_keyspace  | Cassandra DB Keyspace Name | demodb 
4 | user_id_csv_file_path | Path to CSV file where user ids are stored | \home\userids.csv 
5 | authorization | api gateway key | Bearer {api-key}
6 | x_authenticated_user_token | user auth token | {user-auth-token}
7 | encryption_service_api_url | encryption service api url | {{host}}v1/user/data/encrypt


## Script

To identify unencrypted user data from cassandra:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/common/UserEncryptionBin.zip) that contains the script for making rest api call to encryption service api.

2. Run the following command to make rest api call to encryption service api.
<pre> 
UserEncryption_run.sh --context_param cassandra_keyspace="{keyspace_name}" --context_param cassandra_port="{cassandra_port}" --context_param cassandra_server="{cassandra_server_ip}" --context_param user_id_csv_file_path="{user_id_csv_file_path}"  --context_param authorization="{authorization}" --context_param x_authenticated_user_token="{x_authenticated_user_token}" --context_param encryption_service_api_url="{encryption_service_api_url}"
</pre>
3. On successful completion, it will encrypt all the user data whose user id is mentioned in the csv file {user_id_csv_file_path}

4. To cross-check whether it fetched only those user ids whose data is unecrypted run below query with the user ids in csv

 - Query to fetch user 
     ```select * from user where id = '{user-id}';```
 