---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 3.8.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 3.7.0 to release 3.8.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. 

## Running the Builds 

**IMPORTANT**: 

1. Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.

3. Build and Deploy all the services mentioned in the table below.

The following is the list of jobs required to be built and deployed :

Order: Top down per column

| KP JOBS | Build Tag  |Deploy Tag|
|----------|-----------|--------- |
| FlinkJobs| release-3.8.0_RC4 |release-3.8.0|
| KafkaSetup|                  |release-3.8.0_RC2|
| Learning | release-3.8.0_RC9 |release-3.8.0|
| LoggingFileBeatsVM|          |release-3.8.0|
| Yarn     | release-3.8.0_RC9 |release-3.8.0|

| DP Provision | Provision Tag |
|----------|-------------------|
| AnalyticsSpark | release-3.8.0 | 

| DP JOBS |  Build Tag      |Deploy Tag|
|----------|----------------|-------------|
| AnalyticsCore| release-3.8.0_RC1 | release-3.8.0|
| AnalyticsFetchLogs | | release-3.8.0|
| CoreDataProducts | release-3.8.0_RC1 |release-3.8.0|
| ETLJobs | release-3.8.0_RC4 |  release-3.8.0|
| ETLUserCacheIndexer | release-3.8.0_RC4 |release-3.8.0_RC4|
| EdDataProducts | release-3.8.0_RC5 | release-3.8.0|
| FlinkPipelineJobs | release-3.8.0_RC4 |release-3.8.0|

| Core JOBS| Build Tag      | Deploy Tag| Comment|
|----------|----------------|-----------|--------|
| OfflineInstaller | release-3.8.0 |release-3.5.0|
| AdminUtils | release-3.7.0_RC1 | release-3.8.0|
| Assessment | release-3.8.0_RC2 |  release-3.8.0|
| Bot | release-3.8.0_RC1 |  release-3.8.0|
| Content | release-3.8.0_RC3 | release-3.8.0_RC7|
| DiscussionsMW | release-3.8.0_RC2 |release-3.8.0|
| Groups | release-3.7.0_RC5 | release-3.8.0|
| Keycloak | keycloak7 |  release-3.8.0| private branch: keycloak7|
| KnowledgeMW | release-3.8.0_RC3 |  release-3.8.0|
| Learner | release-3.8.0_RC9 |  release-3.8.0|
| Lms | release-3.8.0_RC5 |  release-3.8.0|
| LoggingFileBeatsVM |  |  release-3.8.0|
| Monitoring |  | release-3.8.0|
| Nodebb | release-3.7.0_RC6 |  release-3.8.0|
| OnboardAPIs |  |  release-3.8.0_RC1|
| Player | release-3.8.0_RC9 | release-3.8.0|
| Router | release-3.8.0_RC1 | release-3.8.0|
| Taxonomy | release-3.6.0_RC3 | release-3.8.0|


