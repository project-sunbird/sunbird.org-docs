---
title: Migrate Form Data 
page_title: Migrate Form Data
description: Details on how to migrate form data on Sunbird
published: ture
allowSearch: true
---

## Overview

Sunbird version 1.11 onwards supports the extensibility framework. Form APIs are provided as plugins using the extensibility framework. The extensibility framework creates a new keyspace for each plugin and provides access to the plugin for its own keyspace. The extensibility framework restricts plugins from accessing tables of other keyspaces. As of Sunbird release version 1.10, form data is stored in the **sunbird** keyspace of the **tenant_preference** table.

## Prerequisites

To run the migration script, ensure you have:

1. Access to Cassandra database
2. A backup of Sunbird keyspace in Cassandra DB

## Configuration Parameters
The following parameter needs to be set as an environment variable for the form data migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_urls | The IP address of the Cassandra DB. | 198.168.1.1


## Migration Script

To migrate form data:

1. Checkout release 1.11 sunbird portal from Github.

2. Move to ```src/app/cassandra_migration/release-1.11/form-plugin-migration```

3. RUN Command `./form-migration`
   
