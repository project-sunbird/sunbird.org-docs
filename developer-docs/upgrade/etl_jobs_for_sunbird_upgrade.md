---
title: ETL Jobs for Sunbird Upgrades
page_title:  ETL Jobs for Sunbird Upgrades
description:  ETL Jobs for Sunbird Upgrades
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0, etl jobs
---

## Overview
This page provides you details of the ETL jobs that you can run to upgrade from a prior version of Sunbird to Sunbird version 2.0.0.

### Masking User Email and Phone Number in Cassandra

As part of release-2.0.0, user's email and phone number is masked in the Cassandra DB. To do this, download the [Mask Email Phone Migration](https://github.com/project-sunbird/sunbird-utils/blob/release-2.0.0/cassandra-migration-etl/r1.15/maskEmailPhoneMigrationBin.zip) zip file into the Core Cassandra (master machine in case of cluster).

>For details, refer to the [Migration Script to Add User's Masked Email Address and Phone Number](/developer-docs/installation/mask_user_email_phone_migration.md) document to understand and run the script.

### Sync User Data from Cassandra to Elasticsearch
When you manually add a new column in the user database or make any schema changes, you need to sync the user data from Cassandra to Elasticsearch. If all user data needs synching, follow the steps mentioned in the Sync User document. 

>For details, refer to the [Sync User](/developer-docs/installation/sync_user.md) document to understand and run the script.

### Sync User and Organization Data
When you identify that there is a mismatch of data in your primary (Cassandra) database and your secondary database (Elasticsearch) you need to sync user and organization data. Follow the steps mentioned in the Sync User and Organization Data to sync either:
- All user data
- All organization data
- Specific user data
- Specific organization data

>For details, refer to the [Sync User and Organization](/developer-docs/installation/sync_user.md) document to understand and run the appropriate script. 

### Delete Users from Keycloak DB

Download the [Delete Key Cloak User](https://github.com/project-sunbird/sunbird-utils/blob/release-2.0.0/cassandra-migration-etl/r1.15/DeleteKeycloakUserBin.zip) zip file into the Core Cassandra (master machine in case of cluster)

>For details, refer to the [Delete Keycloak Users](/developer-docs/installation/delete_keycloak_users.md) document to understand and run the script.


### Sync Course Batches

>To sync course batches, refer to the [Static Mapping for Course Batches in Elasticsearch](/developer-docs/server-configurations/elasticsearch_static_mapping_course_batch.md) document and run the commands in only steps 3 and 4 complete the task.


### User Course Sync

Run the following command after the syncing course batches to sync users to courses:  

    curl -X POST \
      {{lms-base-url}}/api/data/v1/index/sync \
      -H 'accept: application/json' \
      -H 'authorization: Bearer {{api-key}}' \
      -H 'content-type: application/json' \
      -d '{"request":{"objectType":"user_course","objectIds":[]}}'
