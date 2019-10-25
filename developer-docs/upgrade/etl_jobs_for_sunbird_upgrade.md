---
title: ETL Jobs for Sunbird Upgrades
page_title:  ETL Jobs for Sunbird Upgrades
description:  ETL Jobs for Sunbird Upgrades
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, etl jobs
---

## Overview

### Cassandra Decrypt

As part of release-2.0.0, we were encrypting all user external identity in cassandra, but since this is not private data
from 2.2.0 we are storing it as plain text. For data which is already encrypted, the following Jenkins job decrypts the 
data.

Job Name | Job Path |
--- | --- |
CassandraDecrypt |  Deploy/\<env\>/Core/CassandraDecrypt |

### Sync User Data from Cassandra to Elasticsearch

>This job is optional

When you manually add a new column in the user database or make any schema changes, you need to sync the user data from Cassandra to Elasticsearch. If all user data needs synching, follow the steps mentioned in the Sync User document. 

>For details, refer to the [Sync User](/developer-docs/installation/sync_user.md) document to understand and run the script.

### Sync User and Organization Data

>This job is optional

When you identify that there is a mismatch of data in your primary (Cassandra) database and your secondary database (Elasticsearch) you need to sync user and organization data. Follow the steps mentioned in the Sync User and Organization Data to sync either:
- All user data
- All organization data
- Specific user data
- Specific organization data

>For details, refer to the [Sync User and Organization](/developer-docs/installation/sync_user_org.md) document to understand and run the appropriate script. 
