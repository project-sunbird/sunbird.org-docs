---
title: Organisation channel migration
page_title: Organisation channel migration
description: Organisation channel migration
published: true
allowSearch: true
---

## Overview
Sunbird, from its release version 1.13 captures the channel details of the tenant organization for all sub-organisations. This data is captured in the channel column of the organisation table in cassandra database. Sub-organisations created prior to this release version will not have channel values. Thus to ensure data consistency this migration has to be done to set the channel value for all the existing sub-organisations based on their root organisation ID.

## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters must be passed as arguments for the channel value migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_cassandra_keyspace  | Cassandra DB Keyspace Name | demodb 
6 | sunbird_org_channel_migration_log_file | Path to CSV file where migration logs are stored | \home\channel_migration_log.csv 

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Migration Script

To migrate channel value for the organisations:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/r1.13/OrgMigrationUpdateChannelBin.zip) that contains the script for channel value migration

2. Run the following command to migrate the data
<pre> 
OrgMigrationUpdateChannel_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_org_channel_migration_log_file="{sunbird_org_channel_migration_log_file}"
</pre>

On successful migration, the log is available in the configured file {sunbird_org_channel_migration_log_file}. To cross-check whether all organisations have channel value, the following queries can be used

 - Query to fetch number of organisations
     ```select count(*) from organisation;```
 - Query to fetch number of organisations with channel value
     ```select count(channel) from organisation;```
   
