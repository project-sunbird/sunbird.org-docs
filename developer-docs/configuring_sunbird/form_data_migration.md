---
type: landing
directory: developer-docs/configuring_sunbird/
title: Form Data migration
page_title: Form Data migration
description: Form Data migration
published: ture
allowSearch: true
---

## Overview

Sunbird, from release version 1.11 onwards, started using  Extensibility framework. Form api's are provided as plugins using Ext-framework. Ext-framework creates new keyspace for each plugin and provides access to plugin for its own keyspace. Ext-framework restricts plugins from accessing tables form other keyspaces. As of release 1.10 form data are stored in ```sunbird``` keyspace in ```tenant_preference``` table.

## Prerequisites

To run the migration script, ensure you have:

1. Access to Cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters
The following parameters needs to be set as environment variable for the channel value migration job

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | ```sunbird_cassandra_urls``` | Cassandra DB IP Address| 198.168.1.1


## Migration Script

To migrate form data:

1. checkout release 1.11 sunbird portal from Github.

2. Move to ```src/app/cassandra_migration/release-1.11/form-plugin-migration```

3. RUN Command `./form-migration`
   
