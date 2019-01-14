---
title: User Login-Id Migration
page_title: User Login-Id Migration
description: User Login-Id Migration
published: true
allowSearch: true
---

## Overview
Migration job to set login id for users, when it is not present, based on username and channel value of the users


## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters needs to be passed as arguments for the user login-id migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_cassandra_keyspace  | Cassandra DB Keyspace Name | demodb 
6 | sunbird_encryption_algorithm  | Encryption Algorithm to encrypt login-id | DES/AES/RSA 
7 | sunbird_encryption_iteration_count  | Encryption Iteration Count to encrypt login-id | 5 
8 | dry_run  | if enabled, only report generation and not actual migration happens | true 

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Environment Variables
The following parameters needs to be set in environment variables

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_encryption_key | Encryption Key to encrypt login-id | Encryption Key
2 | sunbird_cipher_key | Cipher Key to encrypt login-id | Cipher Key 

## Migration Script

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/r1.14/UserMigrationSetLoginIdBin.zip)

2. Navigate to UserMigrationSetLoginIdBin/UserMigrationSetLoginId/ which contains the script file - UserMigrationSetLoginId_run.sh

3. For dry-run, run the following command
<pre> 
UserMigrationSetLoginId_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_encryption_algorithm="{sunbird_encryption_algorithm}" --context_param sunbird_encryption_iteration_count="{sunbird_encryption_iteration_count}" --context_param dry_run=true
</pre>

4. For user login-id migration, run the following command
<pre> 
UserMigrationSetLoginId_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_encryption_algorithm="{sunbird_encryption_algorithm}" --context_param sunbird_encryption_iteration_count="{sunbird_encryption_iteration_count}" --context_param dry_run=false
</pre>

5. On completion of dry-run/migration, following logs will be generated and the logs path will be shown

 S.No. | Log File | Description | Example 
-------|-----------|-------------|---------
1 | setLoginIdLogs_timestamp.csv | Login Ids that can be generated and set by this job | setLoginIdLogs_1546937413175.csv
2 | toSync.csv | User Ids to be synced(This file will be generated only in migration) | toSync.csv 

6. In case of migration, Sync job has to be run for user ids captured in toSync.csv file to sync the migrated data from cassandra to elastic search
