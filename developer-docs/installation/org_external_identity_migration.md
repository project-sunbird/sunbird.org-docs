---
title: Organisation external identity migration
page_title: Organisation external identity migration
description: Organisation external identity migration
published: true
allowSearch: true
---

## Overview
Sunbird, from its release version 1.13 onwards, captures the external id details of the organisations in a separate table(org_external_identity) in cassandra database. External Id details of organisations created before this release(which are captured in organisation table) has to populated in this new table to ensure data consistency. This migration job will take care of that activity.

## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters needs to be passed as arguments for the organisation external identity migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_cassandra_keyspace  | Cassandra DB Keyspace Name | demodb 
6 | sunbird_org_externalid_migration_log_file | Path to CSV file where migration logs are stored | \home\externalid_migration_log.csv 

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Migration Script

To migrate external identity value for the organisations:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/r1.13/OrgExternalIdentityMigrationBin.zip) that contains the script for external identity migration

2. Run the following command to migrate the data
<pre> 
OrgExternalIdentityMigration_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_org_externalid_migration_log_file="{sunbird_org_externalid_migration_log_file}"
</pre>
3. On successful migration, the log is available in the configured file {sunbird_org_externalid_migration_log_file}

4. To cross-check whether all external ids has been populated to the org_external_identity table, the following queries can be used

 - Query to fetch number of organisations with external id
     ```select count(externalid) from organisation;```
 - Query to fetch number of records from org_external_identity table
     ```select count(*) from org_external_identity;```
   
