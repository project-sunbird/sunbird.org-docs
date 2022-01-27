---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.6.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.5.0 to release 4.6.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Variables for Sunbird

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
| sunbird_portal_cdn_blob_url | Player | Change value from 'https://sunbirdstagingpublic.blob.core.windows.net/uci' to 'https://sunbirdstagingpublic.blob.core.windows.net/uci/' |  |  |
| Add host group | Monitoring | [redis-exporter-targets:children]<br>lp-redis<br>dp-redis<br><br>[redis-cluster:children]<br>redis-exporter-targets<br><br>[core:children]<br>redis-cluster |  |  |



### Build and Deploy for Sunbird

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
| Build/Plugins/ContentPlayer | release-4.6.0_RC1 | Deploy/staging/Plugins/ContentPlayer | release-4.6.0_RC2 |  |
| Build/Plugins/ContentPlugins | release-4.6.0_RC2 | Deploy/staging/Plugins/ContentPlugins | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Core/KafkaSetup | release-4.6.0_RC2 |  |
| Build/Kubernetes/Cassandra | release-4.6.0_RC1 | Deploy/staging/Kubernetes/Cassandra | release-4.6.0_RC2 |  |
| Build/Core/OfflineInstaller | release-4.6.0_RC25 | Deploy/staging/Core/OfflineInstaller | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/Keycloak | release-4.6.0_RC2 |  |
| Build/Kubernetes/Assessment | release-4.6.0_RC2 | Deploy/staging/Kubernetes/Assessment | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/APIManager | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/Analytics | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/CertRegistry | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/KnowledgeMW | release-4.6.0_RC2 |  |
| Build/Kubernetes/Content | release-4.6.0_RC2 | Deploy/staging/Kubernetes/Content | release-4.6.0_RC2 |  |
| Build/Kubernetes/DiscussionsMW | release-4.6.0_RC3 | Deploy/staging/Kubernetes/DiscussionsMW | release-4.6.0_RC2 |  |
| Build/Kubernetes/Learner | release-4.6.0_RC6 | Deploy/staging/Kubernetes/Learner | release-4.6.0_RC2 |  |
| Build/Kubernetes/Lms | release-4.6.0_RC3 | Deploy/staging/Kubernetes/Lms | release-4.6.0_RC2 |  |
| Build/Kubernetes/Nodebb | release-4.6.0_RC3 | Deploy/staging/Kubernetes/Nodebb | release-4.6.0_RC2 |  |
| Build/Kubernetes/Notification | release-4.6.0_RC2 | Deploy/staging/Kubernetes/Notification | release-4.6.0_RC2 |  |
| Build/Kubernetes/Player | release-4.6.0_RC25 | Deploy/staging/Kubernetes/Player | release-4.6.0_RC2 |  |
| Build/Kubernetes/Search | release-4.6.0_RC2 | Deploy/staging/Kubernetes/Search | release-4.6.0_RC2 |  |
| Build/Kubernetes/Taxonomy | release-4.6.0_RC2 | Deploy/staging/Kubernetes/Taxonomy | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/managed-learn/ml-analytics-service | release-4.6.0_RC2 |  |
| Build/managed-learn/ml-core-service | release-4.6.0_RC3 | Deploy/staging/managed-learn/ml-core-service | release-4.6.0_RC2 |  |
| Build/managed-learn/ml-projects-service | release-4.6.0_RC4 | Deploy/staging/managed-learn/ml-projects-service | release-4.6.0_RC2 |  |
| Build/managed-learn/ml-survey-service | release-4.6.0_RC4 | Deploy/staging/managed-learn/ml-survey-service | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/UCI/fusionauth | release-4.6.0_RC2 |  |
| Build/UCI/Inbound | release-4.6.0 | Deploy/staging/UCI/Inbound | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/UCI/odk | release-4.6.0_RC2 |  |
| Build/UCI/Orchestrator | release-4.6.0 | Deploy/staging/UCI/Orchestrator | release-4.6.0_RC2 |  |
| Build/UCI/Outbound | release-4.6.0 | Deploy/staging/UCI/Outbound | release-4.6.0_RC2 |  |
| Build/UCI/Transformer | release-4.6.0 | Deploy/staging/UCI/Transformer | release-4.6.0_RC2 |  |
| Build/UCI/UCI | release-4.6.0 | Deploy/staging/UCI/UCI | release-4.6.0_RC2 |  |
|  |  | OpsAdministration/staging/Core/GraylogMongoImport | release-4.6.0_RC2 | graylog_mongo_collections: grok_patterns,pipeline_processor_pipelines,pipeline_processor_pipelines_streams,pipeline_processor_rules |
|  |  | Deploy/staging/Kubernetes/OnboardConsumers | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/OnboardAPIs | release-4.6.0_RC2 |  |
|  |  | Deploy/staging/Kubernetes/Monitoring | release-4.6.0_RC2 |  |
| Build/KnowledgePlatform/FlinkJobs | release-4.6.0_RC5 | Deploy/staging/KnowledgePlatform/FlinkJobs | release-4.6.0_RC1 |  |
| Build/DataPipeline/EdDataProducts | release-4.6.0_RC2 | Deploy/staging/DataPipeline/EdDataProducts | release-4.6.0_RC2 |  |
| Build/DataPipeline/FlinkPipelineJobs | release-4.6.0_RC1 | Deploy/staging/DataPipeline/FlinkPipelineJobs | release-4.6.0_RC2 |  |


### Manual Configurations for Sunbird

|Manual Step|Instruction|
|--------------------|--------------------|
| Create Kafka Topic | Topic Name - {{env_name}}.ml.projects.submissions<br><br>This has to be accessible for consumption by data pipeline |
| Add refresh_data in ETLUserCacheIndexer | Job Name: ETLUserCacheIndexer<br>parameter: refresh_data<br><br>"Please add refresh_data as another parameter in ETLUserCacheIndexer job.<br><br>make default value as (""false"")"<br><br>https://github.com/project-sunbird/sunbird-devops/pull/3154/files |
| spark-script  | https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/3050930177/SB-28196+User+org+association+issue+-+Data+correction |

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure


### Build and Deploy for Vidayadaan

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
| Build/Kubernetes/Assessment | release-4.6.0_RC2 | Deploy/DockStaging/Kubernetes/Assessment | release-4.6.0-vdn |  |
| Build/Kubernetes/Content | release-4.6.0_RC2 | Deploy/DockStaging/Kubernetes/Content | release-4.6.0-vdn |  |
| Build/Kubernetes/Player | release-4.6.0_RC9 | Deploy/DockStaging/Kubernetes/Player | release-4.6.0-vdn |  |
| Build/Kubernetes/Program | release-4.6.0_RC6 | Deploy/DockStaging/Kubernetes/Program | release-4.6.0-vdn |  |
| Build/Kubernetes/Search | release-4.6.0_RC2 | Deploy/DockStaging/Kubernetes/Search | release-4.6.0-vdn |  |
| Build/Kubernetes/Taxonomy | release-4.6.0_RC2 | Deploy/DockStaging/Kubernetes/Taxonomy | release-4.6.0-vdn |  |
|  |  | Deploy/DockStaging/Kubernetes/Upload_CollectionHierarchy_CSV | release-4.6.0-vdn |  |
|  |  |  |  |  |
|  |  | Deploy/DockStaging/Kubernetes/OnboardAPIs | release-4.6.0-vdn |  |
|  |  | Deploy/DockStaging/Kubernetes/OnboardConsumers | release-4.6.0-vdn |  |
|  |  |  |  |  |
| Build/KnowledgePlatform/FlinkJobs | release-4.6.0_RC5 | Deploy/DockStaging/KnowledgePlatform/FlinkJobs | release-4.6.0_RC1 |  |
|  |  |  |  |  |
| Build/DataPipeline/EdDataProducts | release-4.6.0_RC2 | Deploy/DockStaging/DataPipeline/EdDataProducts | release-4.6.0_RC2 |  |

### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Config update for Exam Question Set object type for Haryana tenant | Sourcing Circle - VDN<br>https://project-sunbird.atlassian.net/browse/SB-28508 |
| Config update for enabling Multiple Choice question in a question set for Haryana tenant | Sourcing Circle - VDN<br>https://project-sunbird.atlassian.net/browse/SB-28509 |
| Config update for enabling Subjective question in a question set for Haryana tenant | Sourcing Circle - VDN<br>https://project-sunbird.atlassian.net/browse/SB-28509 |
