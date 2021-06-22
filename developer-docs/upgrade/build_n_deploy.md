---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.0.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 3.9.0 to release 4.0.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.

### Variables

|Variable Name|Service Name|Comments|
|-------------|------------|--------|

### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|||Provision/DataPipeline/Druid|release-4.0.0 service:router<br/>remote:raw||
|||OpsAdministration/Core/ESMapping|release-4.0.0 indices_name:userv2||
|||OpsAdministration/Core/GraylogMongoImport|release-4.0.0 graylog_mongo_collections:all||
|Build/Core/OfflineInstaller|release-4.0.0|Deploy/Core/OfflineInstaller|release-4.0.0||
|Build/DataPipeline/DruidAnomalyDetection|release-4.0.0|Deploy/DataPipeline/DruidAnomalyDetection|release-4.0.0||
|||Deploy/DataPipeline/AnalyticsReplayJobs|release-4.0.0 <br/>cql_query: 0 <br/>job_type: run-job <br/>job_id: userinfo-exhaust <br/>batch_identifier: 01330190903638425684 <br/>start_date: 2017-05-01 <br/>end_date: 2017-07-11 <br/>pause_min: 30 <br/>||
|Build/DataPipeline/EdDataProducts|release-4.0.0_RC4|Deploy/DataPipeline/EdDataProducts|release-4.0.0||
|Build/DataPipeline/FlinkPipelineJobs|release-4.0.0_RC4|Deploy/DataPipeline/FlinkPipelineJobs|release-4.0.0 <br/>job_names_to_deploy:Select all jobs||
|||Deploy/KnowledgePlatform/KafkaSetup|release-4.0.0||
|||Deploy/DataPipeline/KafkaSetup|release-4.0.0||
|||Deploy/DataPipeline/LoggingFileBeatsVM|release-4.0.0 <br/> tags: default hosts: select all||
|Build/KnowledgePlatform/FlinkJobs|release-4.0.0_RC7|Deploy/KnowledgePlatform/FlinkJobs|release-4.0.0||
|Build/KnowledgePlatform/Learning|release-4.0.0_RC4|Deploy/KnowledgePlatform/Learning|release-4.0.0||
|Build/KnowledgePlatform/Neo4jElasticSearchSyncTool|release-3.9.0_RC12|Deploy/KnowledgePlatform/Neo4jElasticSearchSyncTool|release-4.0.0<br/>command: sync<br/>parameters: --graph domain --objectType ObjectCategoryDefinition||
|Build/KnowledgePlatform/Yarn|release-4.0.0_RC4|Deploy/KnowledgePlatform/Yarn|release-4.0.0||
|Build/Kubernetes/Analytics|release-4.0.0_RC1|Deploy/Kubernetes/Analytics|release-4.0.0||
|Build/Kubernetes/Assessment|release-4.0.0_RC6|Deploy/Kubernetes/Assessment|release-4.0.0||
|Build/Kubernetes/Cassandra|release-4.0.0_RC2|Deploy/Kubernetes/Cassandra|release-4.0.0||
|Build/Core/Groups|release-4.0.0_RC1|Deploy/Kubernetes/Groups|release-4.0.0_RC9||
|Build/Core/Keycloak|release-4.0.0_RC1|Deploy/Kubernetes/Keycloak|release-4.0.0_RC9|This was done as part of release-3.9.0 hotfix. In this release we have only changed telemetry pdata version, so only a redeploy is required if you are already on Keycloak 7|
|Build/Core/KnowledgeMW|release-4.0.0_RC3|Deploy/Kubernetes/KnowledgeMW|release-4.0.0_RC9||
|Build/Core/Learner|release-4.0.0_RC27|Deploy/Kubernetes/Learner|release-4.0.0_RC9||
|Build/Core/Lms|release-4.0.0_RC7|Deploy/Kubernetes/Lms|release-4.0.0_RC9||
|Build/Core/Nodebb|release-4.0.0_RC1|Deploy/Kubernetes/Nodebb|release-4.0.0_RC9|Provide value as `v1.16.0` for the jenkins job parameter `nodebb_branch` in the build phase|
|Build/Core/Player|release-4.0.0_RC52|Deploy/Kubernetes/Player|release-4.0.0_RC9||
|Build/Core/Router|release-4.0.0_RC1|Deploy/Kubernetes/Router|release-4.0.0_RC1||
|Build/Core/Search|release-4.0.0_RC6|Deploy/Kubernetes/Search|release-4.0.0_RC9||
|Build/Core/Taxonomy|release-4.0.0_RC6|Deploy/Kubernetes/Taxonomy|release-4.0.0_RC9||
|Build/KnowledgePlatform/KnowledgePlatform|release-4.0.0_RC10|Deploy/KnowledgePlatform/Learning|release-4.0.0_RC10||
|Build/KnowledgePlatform/Yarn|release-4.0.0_RC10|Deploy/KnowledgePlatform/Yarn|release-4.0.0_RC10|Kill `course-batch-updater` samza job, delete its tar file and it's extracted folder in the Yarn Master before deployment|

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Delete jenkins job parameter from Keycloak deploy job|Delete sunbird_auth_branch_or_tag|
|Update the forms|Jira Links - [SB-24836](https://project-sunbird.atlassian.net/browse/SB-24836) [SB-24926](https://project-sunbird.atlassian.net/browse/SB-24926) [SB-24951](https://project-sunbird.atlassian.net/browse/SB-24951)|
|Created Google auth console for Android app|Jira Link - [SB-21678](https://project-sunbird.atlassian.net/browse/SB-21678)|
|DF TABLE MIGRATIONS|[Migration](https://project-sunbird.atlassian.net/browse/SB-24753)|
|Run scripts mentioned in link in learning-service | [Script 1](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC3/scripts/framework-master-category/framework-master-category) [Script 2](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC4/scripts/framework-master-category/framework-master-category)|
|Add job_id in AnalyticsReplayJob|job_id: cassandra-migration|
