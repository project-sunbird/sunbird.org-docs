---
title: Form Data migration
page_title: Form Data migration
description: Details on how to migrate form data on Sunbird
published: ture
allowSearch: true
---

## Overview

Sunbird's extensibility framework is available, from release version 1.11 onwards. Form APIs are provided as plugins using the extensibilityframework. The extensibility framework creates a new keyspace for each plugin and provides access to the plugin for its own keyspace. The extensibility framework restricts plugins from accessing tables of other keyspaces. As of Sunbird release version 1.10, form data is stored in the **sunbird** keyspace of the **tenant_preference** table.

## Prerequisites

To run the migration script, ensure you have:

1. Access to Cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters needs to be set as environment variable for the form data migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | ```sunbird_cassandra_urls``` | Cassandra DB IP Address| 198.168.1.1


## Migration Script

To migrate form data:

1. checkout release 1.11 sunbird portal from Github.

2. Move to ```src/app/cassandra_migration/release-1.11/form-plugin-migration```

3. RUN Command `./form-migration`
   
