---
title: Deleting Users from Keycloak
page_title: Deleting Users from Keycloak
description: Deleting Users from Keycloak 
published: true
allowSearch: true
keywords: Deleting users, keycloak
---

## Overview
In Keycloak, earlier, the user data was stored in plain format and was vulnerable to misuse. From release 1.15.0 onwards, Keycloak is customised to use user details from the Sunbird learner service. As a result, user data stored in Keycloak, if created using Sunbird's releases before version 1.15.0, is obsolete and hence need to be deleted. This migration script loads all the user data from Cassandra and invokes the Keycloak Delete User API call for each user, by skipping specified admin users.

## Prerequisites
To run the migration script, ensure you:

1. Take a backup of PostgreSQL DB used by Keycloak
2. Access to Cassandra DB
3. Access to postgres DB
4. Ensure Deployment Steps for Keycloak User Federation are performed before running this script.

## Configuration Parameters
The following parameters need to be passed as arguments for the delete keycloak user migration job

|S.No.|	Parameter|	Description |	Example |
|------|----------|--------------|------------|
|1|sunbird_cassandra_server|	Cassandra DB IP Address|	198.168.1.1|
|2|sunbird_cassandra_port|	Cassandra DB Port Number|	9042|
|3|sunbird_cassandra_username*|	Cassandra DB User Name|username|
|4|	sunbird_cassandra_password*|	Cassandra DB Password|	password|
|5|	sunbird_cassandra_keyspace|	Cassandra DB Keyspace Name|	sunbird|
|6|	sunbird_keycloak_admin_username|	Keycloak admin username|	admin|
|7|	sunbird_keycloak_admin_password|	Keycloak admin password|	admin|
|8|	sunbird_keycloak_base_url|	Keycloak base url|	http://localhost:8080/auth|
|9|	sunbird_keycloak_client_id|	Keycloak client id|	admin-cli|
|10|	sunbird_keycloak_realms|	Keycloak realms|	master|
|11|	sunbird_postgres_server|	postgres DB IP Address|	198.168.1.1|
|12	sunbird_postgres_port|	postgres DB Port Number|	5432|
|13|	sunbird_postgres_username*|	postgres DB User Name|	username|
|14|	sunbird_postgres_password*|	postgres DB Password|	password|
|15|	sunbird_postgres_schema|	postgres DB Keyspace Name|	public
|16|	sunbird_postgres_database|	postgres DB Keyspace Name|	keycloak
|17|	dry_run|	if enabled, only report generation and not actual migration happens|	true

>Note: If authentication is not required, pass "" for parameters, username, and password

## Migration Script

1. Extract the archive file **DeleteKeycloakUserBin.zip**
2. Run the script using the following commands. Run the dry run option first to verify the task and then do the actual migration.

(dry_run: true)
```
sh DeleteKeycloakUser_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_keycloak_admin_username="{keycloak_admin_username}" --context_param sunbird_keycloak_admin_password="{keycloak_admin_password}" --context_param sunbird_keycloak_base_url="{keycloak_base_url}" --context_param sunbird_keycloak_client_id="{keycloak_client_id}" --context_param sunbird_keycloak_realms="{keycloak_realms}" --context_param sunbird_postgres_server="{sunbird_postgres_server}" --context_param sunbird_postgres_port="{sunbird_postgres_port}" --context_param sunbird_postgres_username="{sunbird_postgres_username}" --context_param sunbird_postgres_password="{sunbird_postgres_password}" --context_param sunbird_postgres_schema="{sunbird_postgres_schema}" --context_param sunbird_postgres_database="{sunbird_postgres_database}" --context_param dry_run=true
```
Verify the records that are identified for an update.

(dry_run: false)

```
sh DeleteKeycloakUser_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_cassandra_keyspace="{sunbird_cassandra_keyspace}" --context_param sunbird_keycloak_admin_username="{keycloak_admin_username}" --context_param sunbird_keycloak_admin_password="{keycloak_admin_password}" --context_param sunbird_keycloak_base_url="{keycloak_base_url}" --context_param sunbird_keycloak_client_id="{keycloak_client_id}" --context_param sunbird_keycloak_realms="{keycloak_realms}" --context_param sunbird_postgres_server="{sunbird_postgres_server}" --context_param sunbird_postgres_port="{sunbird_postgres_port}" --context_param sunbird_postgres_username="{sunbird_postgres_username}" --context_param sunbird_postgres_password="{sunbird_postgres_password}" --context_param sunbird_postgres_schema="{sunbird_postgres_schema}" --context_param sunbird_postgres_database="{sunbird_postgres_database}" --context_param dry_run=false
```
The script generates the following logs.

|S.No.|	Log File|	Description|	Example|
|-----|---------|------------|----------|
|1|	KeycloakDeleteUserSuccess_timestamp.csv|	User IDs that are successfully deleted. This file is generated only during migration.|	KeycloakDeleteUserSuccess_1554113623396.csv|
|2|	KeycloakDeleteUserFailue_timestamp.csv|	User IDs for which deletion failed. This file is generated only in migration.| KeycloakDeleteUserFailue_1554113623396.csv|
|3|	KeycloakUserNotFound.csv|	UserIds that are not found in keycloak.	KeycloakUserNotFound.csv|

>Note: You can delete a maximum of 20000 users at a time. Hence, this etl job needs to run multiple time.
