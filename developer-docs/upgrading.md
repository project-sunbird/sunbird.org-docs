---
title: Upgrading Sunbird 
page_title: Upgrading Sunbird Services and Database Servers
description: Upgradation of services, dataset etc in Sunbird
published: true
allowSearch: true
---

## Overview

Upgrading to the latest version of Sunbird allows you to avail benefits of:

- Sunbird's new and enhanced features
- Fixes done for bugs raised on the platform
- The latest updated versions of any third party component used within Sunbird  
- From release 1.5 onwards:
  - All the services are maintained with same image gold version 
  - Cassandra migration is introduced to update cassandra database schema

## Prerequisites

Ensure that you have Python installed on the Cassandra machine

## Backup the Databases

1. SSH to the database server where you want to take a backup
2. Run the command `git clone https://github.com/project-sunbird/sunbird-devops`
3. `cd sunbird-devops`
4. Checkout the latest release tag `git checkout tags/release-1.9 -b release-1.9`
5. `cd deploy`

### Backup Cassandra

Ensure that the prerequisites are met. To backup the Cassandra database: 
   
1. Run the following script to take the backup:  
`./cassandra_backup.py -t <backup_dir_path> <cassandra_data_dir_path> <snapshotname>` 
	
2. This will create a *.tar.gz* extension backup file in the the **backup_dir_path**. 

**Example:** `./cassandra_backup.py -t /home/ubuntu /var/lib/cassandra/data my_backup`
		
> **Note:** Executing the command creates snapshots of all the keyspaces such as:  
> - **portal**         -  Stores the session data
> - **dialcodes**      -  Stores the energized text book details
> - **sunbirdplugin**  -  Stores the custom or plugin data(used in announcement feature (Object API)
> - **sunbird**	  -  Stores the organization ,user, course, batch, badger etc.
		
### Restore Cassandra

Ensure that the prerequisites are met. To restore the Cassandra database: 

1. Copy the Cassandra backup snapshot to the instance where you want to restore.
2. Extract the *.tar.gz* backup file using the following command: `tar -xvzf my_backup.tar.gz`
3. This will create a directory named `cassandra_backup`.
4. Run `cqlsh -f 'cassandra_backup/db_schema.cql'`. This will restore all the schemas.
5. Run the following script to restore the backup:  
`./cassandra_restore.py --host <cassandra_host_ip_address> <cassandra_backup_dir_path>` 

**Example:** `./cassandra_restore.py --host 10.10.10.10 /home/ubuntu/`

### Backup Postgres

To take a backup of the Postgres database: 

1. Run the following script to take the backup `./backup_postgres.sh`
		
> **Note:** Executing the command creates a backup txt file at `/tmp/postgresql-backup`

**Example:** `/tmp/postgresql-backup/postgresql_backup_UTC-2018-10-25-05-14-53.txt`

2. Postgres Backup includes the following databases:
       
- **api_manager** -	Used by kong
- **badger**      -	Used by badger services
- **Keycloak**    -	Used by Keycloak
- **quartz**      -	Used by sunbird backend services
	

### Restore Postgres

To restore the Postgres database: 

1. Run the following script to restore the backup: `./restore_postgres.sh <backup_file>`

**Example:** `./restore_postgres.sh postgresql_backup_UTC-2018-10-25-05-14-53.txt`

> **Note** Remember to keep the backups safe in another directory as the temporary folder - **/tmp** - will be cleared periodically by the operating system. If **/tmp/postgresql-backup** is removed by the operating system, ensure you create another backup directory and place the backup file in it before restore operation.

### Backup Elastic Search 

To take a backup of Elastic Search databases: 

1. Run the following script to take the backup: `./backup_elasticsearch.sh`
2. Note down the snapshot name as it will be required if you need to perform restore.
3. Snapshot name will be displayed in screen after backup operation. Example: `"snapshot":"snapshot_31_10_2018061552"`

> **Note:** 
> - Executing the command creates the backup file at **/etc/elasticsearch/backup**.
> - If you encounter *permission denied* error, run the script with sudo. 
> - If you encounter *repository_exception*, restart the elasticsearch service and run the backup script.
> - To restart the elasticsearch service, run the following command: `sudo systemctl restart es-1_elasticsearch.service`

 4. Elasticsearch backup includes the following databases: 
		
	a) searchindex      - Stores the user, org , course, batch data
	
	b) sunbirdplugin    - Stores the plugin related data (object API)
	
	c) sunbirddataaudit - Stores the user & organization audit history data

### Restore ElasticSearch

To restore the ElasticSearch databases:  

1. Run the following script to restore the backup: `./restore_elasticsearch.sh <snapshot_name>`

**Example:** `./restore_elasticsearch.sh snapshot_25_10_2018062400`

> **Note:** The snapshot name can be found at `/etc/elasticsearch/backup` in the `index-*` files.


## Upgrading Sunbird Services 

   1. Take a backup of your exisiting **config** file
   2. Pull the latest code of `project-sunbird/sunbird-devops` from its master branch
   3. Checkout the latest release tag `git checkout tags/release-1.9 -b release-1.9`
   4. It is recommended to take a full backup of all the databases before updating the schema 
   5. Follow the steps mentioned in the [Backup the Databases](developer-docs/upgrading/#backup-the-databases) section to take a backup 
   7. Update the **config** file if required.
   6. Run the following commands:  
   	`./sunbird_install.sh -s config`  
	`./sunbird_install.sh -s dbs`  
	`./sunbird_install.sh -s apis`  
	`./sunbird_install.sh -s proxy`  
	`./sunbird_install.sh -s core`  

> **Note:** 
> - Executing the command deploys the tagged version of Sunbird services and also updates the schema in the databases
> - The latest image versions of all the services are updated in the master branch. To get a hotfix image of any Sunbird service, update the minor version in the `sunbird-devops/deploy/deploy-core.sh` file and re-run the `sunbird-devops/deploy/deploy-core.sh` script.
