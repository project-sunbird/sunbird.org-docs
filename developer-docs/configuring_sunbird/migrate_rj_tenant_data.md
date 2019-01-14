---
title: Migrating user and content data from Rajasthan Pilot to Rajasthan tenant
page_title: Migrating user and content data from Rajasthan Pilot to Rajasthan tenant
description: Migrating user and content data from Rajasthan Pilot to Rajasthan tenant
keywords: user, org, content, migration, ETL
allowSearch: true
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are usually done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.

As we migrate the data from one tenant (root organisation) to another, following scripts will take care of migrating the data within Cassandra as well as Elasticsearch. As Rajasthan Pilot tenant does NOT have sub organisations and badges, this document only provides information about relavant scripts responsible for migration of user, user-org and course-batch information.

Lastly, it will inactivate the old (Rajasthan Pilot) tenant. For security reasons, these migration scripts are hardcoded with from root organisation ID of 01241408242723225614 (i.e. Rajasthan Pilot tenant) and to root organisation ID of 01246375399411712074 (i.e. Rajasthan tenant).

## Prerequisites

Following are the pre-requisites for running the migration scripts:
1. Access to Cassandra database
2. API Key to access the Sync API
3. Access to Neo4j database

Note: Take database backup before running any of the migration scripts.

## Migration of data in cassandra

### Configuration parameters

SNo. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. | abc@xyz.com 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB.| password 
5 | dry_run | This boolean parameter will be used to determine whether to actually update the cassandra data or just generate the target data to be updated for validtion purpose, before the actual run. | true
6 | sunbird_output_file | This parameter will be used to output the data for dry run. It will also act as input file for syncing data to ES. | /home/username/output/user.csv

> Note: If you do not need to authenticate access to the cassandra, pass `""` value for the **username** and **password** parameters.

### Steps

Run each migration script first in dry run mode to verify the records that will be migrated.

1. Extract RJPilotUserMigrationBin.zip that contains the script to migrate data in user table. 

[dry_run=true] 
````
cd RJPilotUserMigration
sh RJPilotUserMigration_run.sh --context_param dry_run="true" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/user_migration_output.csv"
````

Verify user IDs in "user_migration_output.csv".

[dry_run=false]
````
sh RJPilotUserMigration_run.sh --context_param dry_run="false" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/user_migration_output.csv"
````

2. Extract RJPilotUserOrgMigrationBin.zip that contains the script to migrate data in user_org table.

[dry_run=true]
````
cd RJPilotUserOrgMigration
sh RJPilotUserOrgMigration_run.sh --context_param dry_run="true" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/user_org_migration_output.csv"
````

Verify user_org IDs in "user_org_migration_output.csv".

[dry_run=false]
````
sh RJPilotUserOrgMigration_run.sh --context_param dry_run="false" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/user_org_migration_output.csv"
````

3. Extract RJPilotCourseBatchMigrationBin.zip that contains the script to migrate data in course_batch table.

[dry_run=true]
````
cd RJPilotCourseBatchMigration
sh RJPilotCourseBatchMigration_run.sh --context_param dry_run="true" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/course_batch_migration_output.csv" 
````

Verify user_org IDs in "course_batch_migration_output.csv".

[dry_run=false]
````
sh RJPilotCourseBatchMigration_run.sh --context_param dry_run="false" --context_param sunbird_cassandra_server="{cassandra-server-host}" --context_param sunbird_cassandra_port="{cassandra-server-port}" --context_param sunbird_cassandra_username="{cassandra-username}" --context_param sunbird_cassandra_password="{cassandra-user-password}"  --context_param sunbird_cassandra_keyspace="{sunbird-keyspace}" --context_param sunbird_output_file="{base_output_path}/course_batch_migration_output.csv" 
````

## Sync of migrated data from cassandra to elasticsearch

### Configuration parameters

SNo.  | Parameter | Description | Example
-------|-----------|-------------|---------
1 | sunbird_sync_api_endpoint  | [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
2 | sunbird_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
3 | sunbird_sync_block_size | The number of object records to be synced per API call. | 1000
4 | sunbird_sync_sleep_time | The time interval in milliseconds between API calls. | 5000
5 | sunbird_sync_object_type | Object type for which sync is triggered | user
6 | sunbird_sync_id_file | Output file from migration dry-run which contains object IDs to be synced

### Steps

1. Run following command to sync user data.

````
cd Sync
sh Sync_run.sh --context_param sunbird_cassandra_table="user" --context_param sunbird_sync_api_endpoint="{api_base_url}/api/data/v1/index/sync" --context_param sunbird_sync_api_key="{api-key}" --context_param sunbird_sync_block_size="{block-size}" --context_param sunbird_sync_sleep_time="{sleep-time}" --context_param sunbird_sync_object_type="user" --context_param sunbird_sync_id_file="{base_output_path}/user_migration_output.csv"
````

2. Run following command to sync course_batch data.

````
sh Sync_run.sh --context_param sunbird_cassandra_table="course_batch" --context_param sunbird_sync_api_endpoint="{api_base_url}/api/data/v1/index/sync" --context_param sunbird_sync_api_key="{api-key}" --context_param sunbird_sync_block_size="{block-size}" --context_param sunbird_sync_sleep_time="{sleep-time}" --context_param sunbird_sync_object_type="batch" --context_param sunbird_sync_id_file="{base_output_path}/course_batch_migration_output.csv"
````

## Migration of data in Neo4j

1. Run the following CQL command to migrate created contents from one channel to another in Neo4j. Update channel IDs as required in the below CQL command.

````
MATCH (n:domain) WHERE n.channel ="0126741568685424647" SET n.channel = "0126741573767413761";
MATCH (n:domain) WHERE n.createdFor = ["0126741568685424647"] SET n.createdFor = ["0126741573767413761"];
````
