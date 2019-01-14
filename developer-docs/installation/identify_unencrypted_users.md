---
title: Identify users with unencrypted PII data 
page_title: Identify users with unencrypted PII data
description: Identify users with unencrypted PII data
published: true
allowSearch: true
---

## Overview
Very old users of Sunbird may have some PII (Personally Identifiable Information) data that is unencrypted. 

The purpose of this document is to describe usage of a script to identify such users with unencrypted PII data so that subsequently PII data of such users can be encrypted.

## Pre-requisites

To run this script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration parameters

The following parameters needs to be passed as arguments for the identifying unencrypted users data job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | cassandra_keyspace  | Cassandra DB Keyspace Name | sunbird 
4 | user_id_csv_file_path | Path to output CSV file where user IDs are stored | /home/user/userids.csv

## Running the script

To identify unencrypted user data from cassandra:

1. Extract the archive file IdentifyUnencryptedUserIdsBin.zip that contains the script for identifying unencrypted user data.

2. Run the following command to identify unencrypted user data.

```
cd IdentifyUnencryptedUserIds
IdentifyUnencryptedUserIds_run.sh --context_param cassandra_server="{cassandra_server_ip}" --context_param cassandra_port="{cassandra_port}" --context_param cassandra_keyspace="{keyspace_name}" --context_param user_id_csv_file_path="{user_id_csv_file_path}"
```

3. On successful completion, the CSV containing user IDs is available at the configured file path {user_id_csv_file_path}.

4. To cross-check whether it fetched only those user IDs whose data is unencrypted run below CQL query with few user IDs in CSV file generated.

 ```
 select * from user where id = '{user-id}';
 ```
 
