---
title: ETL Jobs for Sunbird Upgrades
page_title:  ETL Jobs for Sunbird Upgrades
description:  ETL Jobs for Sunbird Upgrades
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0, etl jobs
---

## Overview

### Cassandra User Email and Phone number masking:

As part of release-2.0.0, we are masking user's email and phone number in cassandra DB. Please follow the below steps to perform this task

Download the [file](https://github.com/project-sunbird/sunbird-utils/blob/release-2.0.0/cassandra-migration-etl/r1.15/maskEmailPhoneMigrationBin.zip) in the Core Cassandra (master machine in case of cluster)

Please refer to this document to [understand and run the script](https://github.com/project-sunbird/sunbird.org-docs/blob/b823b9b7e17758241095a869c221592bf11bb560/developer-docs/installation/mask_user_email_phone_migration.md)

### Sync user data from Cassandra to Elasticsearch:

Please refer to this document to [understand and run the script](https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/installation/sync_user.md)

### Delete users from Keycloak DB

Download this [file](https://github.com/project-sunbird/sunbird-utils/blob/release-2.0.0/cassandra-migration-etl/r1.15/DeleteKeycloakUserBin.zip) in the Core Cassandra (master machine in case of cluster)

Please refer to this document to [understand and run the script](https://github.com/project-sunbird/sunbird.org-docs/blob/b823b9b7e17758241095a869c221592bf11bb560/developer-docs/installation/delete_keycloak_users)


### Course batch sync:

Please refer to this [document](https://github.com/manzarul/sunbird.org-docs/blob/e6caf3226dbe8173c93becf6679529ba850c3900/developer-docs/configuring_sunbird/elasticsearch_static_mapping_course_batch) to run the command (Only Step 3 and Step 4 needs to be run)


### User course sync:

Please run this command also after previous step

    curl -X POST \
      {{lms-base-url}}/api/data/v1/index/sync \
      -H 'accept: application/json' \
      -H 'authorization: Bearer {{api-key}}' \
      -H 'content-type: application/json' \
      -d '{"request":{"objectType":"user_course","objectIds":[]}}'