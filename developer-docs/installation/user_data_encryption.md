---
title: Encryption of user PII data
page_title: Encryption of user PII data
description: Encryption of user PII data
published: true
allowSearch: true
---

## Overview
The purpose of this document is to describe usage of a script to encrypt PII data of specified users using Sunbird Encryption API.

## Pre-requisites

To run this script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration parameters
The following parameters needs to be passed as arguments for the identifying unencrypted users data job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | user_id_csv_file_path | Path to CSV file where user IDs are stored | /home/user/userids.csv 
2 | encryption_service_api_url | Encryption API endpoint URL | {{host}}/api/data/v1/user/encrypt
3 | authorization | Authorization key received from administrator for using Sunbird APIs. | Bearer ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
4 | x_authenticated_user_token | Access token of registered user performing given API request. | ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890

## Running the script

1. Extract the archive file UserEncryptionBin.zip that contains the script for making Sunbird Encryption API call to encrypt user's PII data.

2. Run the script using following command.

``` 
UserEncryption_run.sh --context_param user_id_csv_file_path="{user_id_csv_file_path}"  --context_param authorization="{authorization}" --context_param x_authenticated_user_token="{x_authenticated_user_token}" --context_param encryption_service_api_url="{encryption_service_api_url}"
```

3. On successful completion, it will encrypt all the user data whose user ID is mentioned in the CSV file at path {user_id_csv_file_path}.

4. To cross-check whether it encrypted successfully use below CQL query for few user IDs in given CSV file to ensure that PII data is not in plain text.

```
select * from user where id = '{user-id}';
```
