---
title: Migration Script to Add User's Masked Email Address and Phone Number
page_title: Migration Script to Add User's Masked Email Address and Phone Number
description: Migration script to add user's masked email address and phone
published: true
allowSearch: true
keywords: migration script, making user email, masking user phone, masking
---

## Overview
Sunbird, encrypts and stores the user's email address and phone number in Cassandra. However, it is also required that the user's email address and phone number is added to the databse in a masked form. This migration script reads the encrypted email address or phone number, decrypts it and generates a masked form of the email address and phone number, which it in turn adds into two new columns as maskedemail and maskedphone for all existing users.

## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of Sunbird keyspace in the Cassandra DB.
3. Added the columns **maskedemail** and **maskedphone** in the Cassandra script.

## Configuration Parameters
The following parameters needs to be passed as arguments for the mask email phone migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_cassandra_keyspace  | Cassandra DB Keyspace Name | sunbird 
6 | sunbird_encryption_algorithm  | Encryption Algorithm to encrypt email | AES 
7 | sunbird_encryption_iteration_count  | Encryption Iteration Count to encrypt email | 3 
8 | dry_run  | if enabled, only report generation and not actual migration happens | true


> Note: If authentication is not required, pass `""` for parameters, username, and password

## Environment Variables
Set the following environment variables:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_encryption_key | Encryption Key to encrypt email | Encryption Key
2 | sunbird_cipher_key | Cipher Key to encrypt email | Cipher Key 

## Migration Script

1. Extract the archive file **maskEmailPhoneMigrationBin.zip**.

2. Run the script using the following commands 
> Note: Perform a dry run first to verify that everything runs properly and then perform the actual migration.

(dry_run: true)
``` 
sh maskEmailPhoneMigration_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_encryption_algorithm="{sunbird_encryption_algorithm}" --context_param sunbird_encryption_iteration_count="{sunbird_encryption_iteration_count}" --context_param dry_run=true
```

Verify the records identified to be updated.

(dry_run: false)  
``` 
sh maskEmailPhoneMigration_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_encryption_algorithm="{sunbird_encryption_algorithm}" --context_param sunbird_encryption_iteration_count="{sunbird_encryption_iteration_count}" --context_param dry_run=false
```

3. The script generates the following logs.

 S.No. | Log File | Description | Example 
-------|-----------|-------------|---------
1 | maskFailure.csv | Email Ids or phones which decryption and masking failed | maskFailure.csv
2 | toSync.csv | User Ids to be synced (This file will be generated only in migration) | toSync.csv 

4. In case of migration, the sync job has to be run for user IDs captured in toSync.csv file to sync the migrated data from Cassandra to Elasticsearch.
