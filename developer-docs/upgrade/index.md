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
|||

### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|||Provision/DataPipeline/postgres-managed|release-4.0.0_RC5||
|||Provision/DataPipeline/Druid|release-4.0.0<br/>service:router<br/>remote:raw||
|||OpsAdministration/Core/ESMapping|release-4.0.0<br/>indices_name:userv2||
|||OpsAdministration/Core/GraylogMongoImport|release-4.0.0<br/>graylog_mongo_collections:all|This was deployed as 3.9.0 hotfix, so its not required to run again if it's already deployed|
|Build/Core/OfflineInstaller|release-4.0.0|Deploy/Core/OfflineInstaller|release-4.0.0_RC4||
|Build/DataPipeline/AnalyticsCore|release-4.0.0_RC1|Deploy/DataPipeline/AnalyticsCore|release-4.0.0_RC5|
|Build/DataPipeline/DruidAnomalyDetection|release-4.0.0|Deploy/DataPipeline/DruidAnomalyDetection|release-4.0.0||
|||Deploy/DataPipeline/AnalyticsReplayJobs|release-4.0.0_RC6 <br/>cql_query: 0 <br/>job_type: run-job <br/>job_id: userinfo-exhaust <br/>batch_identifier: 01330190903638425684 <br/>start_date: 2017-05-01 <br/>end_date: 2017-07-11 <br/>pause_min: 30 <br/>|Not required to be deployed QA team will run on need basis|
|Build/DataPipeline/EdDataProducts|release-4.0.0_RC5|Deploy/DataPipeline/EdDataProducts|release-4.0.0||
|||Deploy/KnowledgePlatform/KafkaSetup|release-4.0.0_RC5||
|||Deploy/DataPipeline/KafkaSetup|release-4.0.0_RC6||
|||Deploy/DataPipeline/Secor|release-4.0.0_RC6|Add error-telemetry-backup to job_names_to_deploy parameter in job and deploy selecting only this, If this is already done, then there is no need of deployment|
|||Deploy/DataPipeline/LoggingFileBeatsVM|release-4.0.0_RC6 <br/> tags: default hosts: select all|This was deployed as 3.9.0 hotfix, so its not required to run again if it's already deployed|
|Build/KnowledgePlatform/FlinkJobs|release-4.0.0_RC7|Deploy/KnowledgePlatform/FlinkJobs|release-4.0.0_RC5|Add "collection-cert-pre-processor", "Add auto-creator-v2", "collection-certificate-generator" to deploy job list<br/>Kill samza jobs: "certificate-pre-processor" and "course-certificate-generator-v2"|
|Build/KnowledgePlatform/Learning|release-4.0.0_RC4|Deploy/KnowledgePlatform/Learning|release-4.0.0_RC5||
|Build/KnowledgePlatform/Neo4jElasticSearchSyncTool|release-3.9.0_RC12|Deploy/KnowledgePlatform/Neo4jElasticSearchSyncTool|release-4.0.0_RC5<br/>command: sync<br/>parameters: --graph domain --objectType ObjectCategoryDefinition||
|Build/KnowledgePlatform/Yarn|release-4.0.0_RC4|Deploy/KnowledgePlatform/Yarn|release-4.0.0_RC5||
|Build/Kubernetes/Analytics|release-4.0.0_RC1|Deploy/Kubernetes/Analytics|release-4.0.0_RC4||
|Build/Kubernetes/Assessment|release-4.0.0_RC6|Deploy/Kubernetes/Assessment|release-4.0.0_RC4||
|Build/Kubernetes/Cassandra|release-4.0.0_RC2|Deploy/Kubernetes/Cassandra|release-4.0.0_RC4||
|Build/Kubernetes/Content|release-4.0.0_RC6|Deploy/Kubernetes/Content|release-4.0.0_RC4||
|Build/Kubernetes/DiscussionsMW|release-4.0.0_RC2|Deploy/Kubernetes/DiscussionsMW|release-4.0.0_RC4||
|Build/Kubernetes/Groups|release-4.0.0_RC10|Deploy/Kubernetes/Groups|release-4.0.0_RC4||
|||Deploy/Kubernetes/Keycloak|release-4.0.0_RC4||
|||Deploy/Kubernetes/UploadSchemas|release-4.0.0_RC4|restart taxonomy-service, content-service and assessment-service|
|Build/Kubernetes/Learner|release-4.0.0_RC18|Deploy/Kubernetes/Learner|release-4.0.0_RC4||
|Build/Kubernetes/Lms|release-4.0.0_RC3|Deploy/Kubernetes/Lms|release-4.0.0_RC4||
|||Deploy/Kubernetes/LoggingFileBeatsVM|release-4.0.0_RC4<br/>tags: current<br/>hosts: select all|This was deployed as 3.9.0 hotfix, so its not required to run again if it's already deployed|
|||Deploy/Kubernetes/Logging|release-4.0.0_RC4<br/>chart_name: oauth2_proxy|This was deployed as 3.9.0 hotfix, so its not required to run again if it's already deployed|
|||Deploy/Kubernetes/nginx-public-ingress|release-4.0.0_RC4||
|||Deploy/Kubernetes/OnboardAPIs|release-4.0.0_RC4||
|||Deploy/Kubernetes/OnboardConsumers|release-4.0.0_RC4||
|Build/Kubernetes/Player|release-4.0.0_RC59|Deploy/Kubernetes/Player|release-4.0.0_RC4||
|Build/Kubernetes/Search|release-4.0.0_RC6|Deploy/Kubernetes/Search|release-4.0.0_RC4||
|Build/Kubernetes/Taxonomy|release-4.0.0_RC6|Deploy/Kubernetes/Taxonomy|release-4.0.0_RC4||

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Delete jenkins job parameter from Keycloak deploy job|Delete sunbird_auth_branch_or_tag|
|Update the forms|Jira Links - [SB-24836](https://project-sunbird.atlassian.net/browse/SB-24836) [SB-24926](https://project-sunbird.atlassian.net/browse/SB-24926) [SB-24951](https://project-sunbird.atlassian.net/browse/SB-24951)|
|Created Google auth console for Android app|Jira Link - [SB-21678](https://project-sunbird.atlassian.net/browse/SB-21678)|
|DF TABLE MIGRATIONS|[Migration](https://project-sunbird.atlassian.net/browse/SB-24753)|
|Run scripts mentioned in link in learning-service | [Script 1](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC3/scripts/framework-master-category/framework-master-category) [Script 2](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC4/scripts/framework-master-category/framework-master-category)|
|Add job_id in AnalyticsReplayJob|job_id: cassandra-migration [PR LINK](https://github.com/project-sunbird/sunbird-devops/pull/2635/files)|
|Sprak Script for user-association|[Script](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2609741876/SB-23200+AssociationType+update+for+user+in+user+organisation+table)|
|ES Migration Script|[Script](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2632581222/SB-24689+User+mapping+for+roles+changes+Array+of+String+to+Array+of+Map)|
