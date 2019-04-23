---
title: Deleting Users from Keycloak
page_title: Deleting Users from Keycloak
description: Deleting Users from Keycloak
published: true
allowSearch: true
---

## Overview
In Keycloak, earlier the users data is stored in plain format and is vulnerable for misuse. From release 1.15.0 onwards, Keycloak is customised to use user details from Sunbird learner service. As such, users stored in Keycloak are obsolete and hence need to be deleted. This migration scripts loads all the users from Cassandra, and invokes Keycloak Delete User API call for each user by skipping specified admin users.

## Prerequisites

To run the migration script, ensure you have:

1. Take a backup of PostgreSQL DB used by Keycloak
2. Access to Cassandra DB
3. Access to postgres DB
4. Ensure [Deployment Steps for Keycloak User Federation](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1021673496/Deployment+Steps+for+Keycloak+User+Federation) are performed before running this script.

## Configuration Parameters
The following parameters needs to be passed as arguments for the delete keycloak user migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 
5 | sunbird_cassandra_keyspace  | Cassandra DB Keyspace Name | sunbird 
6 | sunbird_keycloak_admin_username  | Keycloak admin username | admin 
7 | sunbird_keycloak_admin_password  | Keycloak admin password | admin
8 | sunbird_keycloak_base_url  | Keycloak base url | http://localhost:8080/auth
9 | sunbird_keycloak_client_id  | Keycloak client id | admin-cli
10 | sunbird_keycloak_realms  | Keycloak realms | master
11 | sunbird_postgres_server | Cassandra DB IP Address| 198.168.1.1
12 | sunbird_postgres_port | Cassandra DB Port Number | 5432 
13 | sunbird_postgres_username* | Cassandra DB User Name | username 
14 | sunbird_postgres_password* | Cassandra DB Password | password 
15 | sunbird_postgres_schema  | Cassandra DB Keyspace Name | public 
16 | sunbird_postgres_database  | Cassandra DB Keyspace Name | keycloak
17 | dry_run  | if enabled, only report generation and not actual migration happens | true

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Migration Script

1. Extract the archive file DeleteKeycloakUserBin.zip.

2. Run the script using below commands (first with dry run option for verification purpose and later without out it perform actual migration).

(dry_run: true)
``` 
sh DeleteKeycloakUser_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_keycloak_admin_username="{keycloak_admin_username}" --context_param sunbird_keycloak_admin_password="{keycloak_admin_password}" --context_param sunbird_keycloak_base_url="{keycloak_base_url}" --context_param sunbird_keycloak_client_id="{keycloak_client_id}" --context_param sunbird_keycloak_realms="{keycloak_realms}" --context_param sunbird_postgres_server="{sunbird_postgres_server}" --context_param sunbird_postgres_port="{sunbird_postgres_port}" --context_param sunbird_postgres_username="{sunbird_postgres_username}" --context_param sunbird_postgres_password="{sunbird_postgres_password}" --context_param sunbird_postgres_schema="{sunbird_postgres_schema}" --context_param sunbird_postgres_database="{sunbird_postgres_database}" --context_param dry_run=true
```

Verify the records identified to be updated.

(dry_run: false)  
``` 
sh DeleteKeycloakUser_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_keycloak_admin_username="{keycloak_admin_username}" --context_param sunbird_keycloak_admin_password="{keycloak_admin_password}" --context_param sunbird_keycloak_base_url="{keycloak_base_url}" --context_param sunbird_keycloak_client_id="{keycloak_client_id}" --context_param sunbird_keycloak_realms="{keycloak_realms}" --context_param sunbird_postgres_server="{sunbird_postgres_server}" --context_param sunbird_postgres_port="{sunbird_postgres_port}" --context_param sunbird_postgres_username="{sunbird_postgres_username}" --context_param sunbird_postgres_password="{sunbird_postgres_password}" --context_param sunbird_postgres_schema="{sunbird_postgres_schema}" --context_param sunbird_postgres_database="{sunbird_postgres_database}" --context_param dry_run=false
```

3. The script generates the following logs.

 S.No. | Log File | Description | Example 
-------|-----------|-------------|---------
1 | KeycloakDeleteUserSuccess_timestamp.csv | User Ids which were successfully deleted (This file will be generated only in migration) | KeycloakDeleteUserSuccess_1554113623396.csv
2 | KeycloakDeleteUserFailue_timestamp.csv | User Ids for which deletion failed (This file will be generated only in migration) | KeycloakDeleteUserFailue_1554113623396.csv 
3 | KeycloakUserNotFound.csv | UserIds which were not found in keycloak | KeycloakUserNotFound.csv

> Note: Please note that the limit for user delete is set to 20000, Hence this etl job needs to run multiple time.
