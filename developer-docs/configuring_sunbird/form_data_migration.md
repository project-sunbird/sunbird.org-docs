---
title: Migrate Form Data 
page_title: Migrate Form Data
description: Details on how to migrate form data on Sunbird
published: true
allowSearch: true
---

## Overview

Sunbird supports the extensibility framework from version 1.11 onwards. Starting from Sunbird version 1.11, form APIs are provided as plugins using the extensibility framework. The extensibility framework creates a new keyspace for each plugin and provides access to the plugin for its own keyspace. The extensibility framework restricts plugins from accessing tables of other keyspaces. 
As of Sunbird release version 1.10, form data is stored in the **sunbird** keyspace of the **tenant_preference** table.
This page provides you information to manually migrate the database from any lower version of Sunbird to version 1.11.

## Prerequisites

To run the migration script, ensure you have:

1. Access to Cassandra database
2. A backup of Sunbird keyspace in Cassandra DB

## Configuration Parameters
The following parameter needs to be set as an environment variable for the form data migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_urls | The IP address of the Cassandra DB. This parameter is required as an input to the migration script to identify the server on which the database resides | 198.168.1.1


## Migration Script

To migrate form data:

1. Checkout Sunbird Release 1.11 from Github.

2. Go to the **src/app/cassandra_migration/release-1.11/form-plugin-migration** folder

3. Run the command `./form-migration`

The data is migrated from the **sunbird.tenant_preference** table to the **qmzbm_form_service.form_data** table. 
   
