---
title: Syncing Rajasthan Pilot data to Rajasthan tenant
page_title: Syncing Rajasthan Pilot data to Rajasthan tenant
description: Details on how to sync organisation's data
keywords: user, org, migration, ETL
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.
As we migrate the data from one tenant(root organisation) to other, following scripts will take care of migrating the data within Cassandra as well as Elasticsearch. The data it will migrate is - user, user-org association, course-batches.
Lastly it will also inactivate the old tenant. This migration scripts are specifically migrating the data from tenant with Id: 01241408242723225614 and name : ETB Pilot Rajasthan to tenant with Id: 01246375399411712074 and name : Rajasthan

## Prerequisites

To sync organisation data, you need:

1. Access to Cassandra database
2. API Key to access the Sync API

## Configuration Parameters for Migration within Cassandra

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. | abc@xyz.com 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB.| password 
5 | dry_run | This parameter will be used to determine whether to actually update the cassandra data or just generate the target data to be updated for validtion purpose, before the actual run. True/False | true
6 | sunbird_output_file | This parameter will be used to output the data for dry-run. It will also act as input file for syncing data to ES | /home/username/output/user.csv

## Configuration Parameters for syncing the cassandra data to ElasticSearch

S.No.  | Parameter | Description | Example
-------|-----------|-------------|---------
1 | sunbird_sync_api_endpoint  | [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
2 | sunbird_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
3 | sunbird_sync_block_size | The number of org records to be synced per API call. | 1000 
4 | sunbird_sync_sleep_time | The time interval in milliseconds between API calls. | 5000
5 | sunbird_sync_object_type | object type for which the sync is triggered | course_batch, user
6 | sunbird_sync_id_file | output file of dry-run from previous step


> Note: If you do not need to authenticate access to the cassandra, pass `""` value for the **username** and **password** parameters.

## Migration of data within cassandra

1. Extract the [archive file](https://github.com/project-sunbird/sunbird-utils/tree/master/cassandra-migration-etl/common/tenant-migration.zip) that contains the script to sync the organisation's data.

> ## Important: 
>It is recommended to take back-up of the cassandra database and run the scripts in dry run mode, to verify the final effect of migration.

2. Run the following command with dry_run = true to sync all users data from old tenant to new tenant.

````
cd user_root_org_migration_run
sh user_root_org_migration_run.sh --context_param dry_run="{boolean_value}" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{Cassandra-username}" --context_param sunbird_cassandra_password="{Cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}"--context_param sunbird_output_file="{base_output_path}/user_migration.csv"
````

> Verify the output, which shows the data to be migrated. Once verified run above command with dry_run = false, or by skipping the parameter

3. Run the following command with dry_run = true to sync all user-org entries associated with old tenant to new tenant.

````

cd ../user_org_root_org_migration_run
sh user_org_root_org_migration_run.sh --context_param dry_run="{boolean_value}" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{Cassandra-username}" --context_param sunbird_cassandra_password="{Cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}"--context_param sunbird_output_file="{base_output_path}/user_org_migration.csv"
````
>Verify the output, which shows the data to be migrated. Once verified run above command with dry_run = false, or by skipping the parameter

4.  Run the following command with dry_run = true to sync course-batch entries associated with old tenant to new tenant
````
cd ../course_batch_root_org_migration_run
sh course_batch_root_org_migration_run.sh --context_param dry_run="{boolean_value}" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{Cassandra-username}" --context_param sunbird_cassandra_password="{Cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}"--context_param sunbird_output_file="{base_output_path}/course_batch_migration.csv" 
````

5. Run the following command to sync the user data from cassandra to ElasticSearch
````
cd ../Sync_job_run
sh Sync_job_run.sh --context_param sunbird_cassandra_table="user"  --context_param sunbird_sync_api_endpoint="{app_base_url}/v1/data/sync" --context_param sunbird_sync_api_key="{api-key}" --context_param sunbird_sync_block_size={block-size} --context_param sunbird_sync_sleep_time={sleep-time} --context_param sunbird_sync_object_type=user --context_param sunbird_sync_id_file="{base_output_path}/user_migration.csv"
````

6. Run the following command to sync the course batch data from cassandra to ElasticSearch

````
sh Sync_job_run.sh --context_param sunbird_cassandra_table="course_batch"  --context_param sunbird_sync_api_endpoint="{app_base_url}/v1/data/sync" --context_param sunbird_sync_api_key="{api-key}" --context_param sunbird_sync_block_size={block-size} --context_param sunbird_sync_sleep_time={sleep-time} --context_param sunbird_sync_object_type=batch --context_param sunbird_sync_id_file="{base_output_path}/course_batch_migration.csv"
````


7. Run the following command to update the pilot root organisation status to inactive

````
sh change_org_status_run.sh --context_param --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{Cassandra-username}" --context_param sunbird_cassandra_password="{Cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}"--context_param status=0
````
8. Run the following command to migrate created content from one channel to another. This cql will against neo4j
````
MATCH (n:domain) WHERE n.channel ="0126741568685424647" SET n.channel = "0126741573767413761";
MATCH (n:domain) WHERE n.createdFor = ["0126741568685424647"] SET n.createdFor = ["0126741573767413761"];
````
