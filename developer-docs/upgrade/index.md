---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.7.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.6.0 to release 4.7.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Variables for Sunbird

|Variable Name|Service Name|Value|Comments|
|-------------|------------|-----|--------|
|`reportsListVersion`|_Player_|`v2`|Add in `Core/common.yml`|



### Build and Deploy for Sunbird

| SERVICE TO BE BUILD                     | BUILD TAG          | SERVICE TO DEPLOY                          | DEPLOY TAG                                                                                                                                                       | COMMENTS                                  |
|-----------------------------------------|--------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
|                                         |                    | Deploy/KnowledgePlatform/CassandraDbUpdate | release-4.7.0_RC3                                                                                                                                                |                                           |
| Build/KnowledgePlatform/FlinkJobs       | release-4.7.0_RC9  | Deploy/KnowledgePlatform/FlinkJobs         | release-4.7.0_RC3                                                                                                                                                | `job_names_to_deploy: Choose all`         |
| Build/KnowledgePlatform/Learning        | release-4.7.0_RC3  | Deploy/KnowledgePlatform/Learning          | release-4.7.0_RC3                                                                                                                                                |                                           |
| Build/KnowledgePlatform/Yarn            | release-4.7.0_RC3  | Deploy/KnowledgePlatform/Yarn              | release-4.7.0_RC3                                                                                                                                                |                                           |
| Build/DataPipeline/FlinkPipelineJobs    | release-4.7.0_RC1  | Deploy/DataPipeline/FlinkPipelineJobs      | release-4.7.0_RC2                                                                                                                                                | `job_names_to_deploy: Choose all`         |
| Build/DataPipeline/EdDataProducts       | release-4.7.0_RC1  | Deploy/DataPipeline/EdDataProducts         | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | OpsAdministration/Core/GraylogMongoImport  | release-4.7.0_RC2                                                                                                                                                | `graylog_mongo_collections:` <br> `event_notifications` <br> `grants` <br> `index_sets` <br> `pipeline_processor_pipelines` <br> `pipeline_processor_rules` <br> `streamrules` <br> `streams` |
|                                         |                    | Provision/Core/Graylog                     | release-4.7.0_RC2                                                                                                                                                | `tag: graylog`                            |
|                                         |                    | Provision/DataPipeline/Druid               | release-4.7.0_RC2                                                                                                                                                | `service: Choose all` <br> `remote: raw` <br> If you are using druid rollup cluster also, rerun the job second time by choosing `remote: rollup` |
|                                         |                    | Deploy/Kubernetes/UploadSchemas            | release-4.7.0_RC2                                                                                                                                                | `kp_branch_or_tag: release-4.7.0`         |
|                                         |                    | Deploy/Kubernetes/APIManager               | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/Kubernetes/CertRegistry             | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/Kubernetes/Keycloak                 | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/Kubernetes/KnowledgeMW              | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/Kubernetes/Monitoring               | release-4.7.0_RC2                                                                                                                                                | `tag: all`                                |
|                                         |                    | Deploy/Kubernetes/OnboardAPIs              | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/Kubernetes/OnboardConsumers         | release-4.7.0_RC2                                                                                                                                                |                                           |
|                                         |                    | Deploy/managed-learn/ml-analytics-service  | release-4.7.0_RC2                                                                                                                                                | `ml_analytics_version: release-4.7.0`     |
| Build/Plugins/ContentPlugins            | release-4.7.0_RC1  | Deploy/Plugins/ContentPlugins              | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Cassandra              | release-4.7.0_RC1  | Deploy/Kubernetes/Cassandra                | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Analytics              | release-4.7.0_RC1  | Deploy/Kubernetes/Analytics                | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Assessment             | release-4.7.0_RC5  | Deploy/Kubernetes/Assessment               | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Content                | release-4.7.0_RC5  | Deploy/Kubernetes/Content                  | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/DiscussionsMW          | release-4.7.0_RC4  | Deploy/Kubernetes/DiscussionsMW            | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Learner                | release-4.7.0_RC9  | Deploy/Kubernetes/Learner                  | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Nodebb                 | release-4.7.0_RC1  | Deploy/Kubernetes/Nodebb                   | release-4.7.0_RC2                                                                                                                                                | `nodebb_branch: v1.18.6`                  |
| Build/Kubernetes/Player                 | release-4.7.0_RC37 | Deploy/Kubernetes/Player                   | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Search                 | release-4.7.0_RC5  | Deploy/Kubernetes/Search                   | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Kubernetes/Taxonomy               | release-4.7.0_RC5  | Deploy/Kubernetes/Taxonomy                 | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/managed-learn/ml-core-service     | release-4.7.0_RC4  | Deploy/managed-learn/ml-core-service       | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/managed-learn/ml-projects-service | release-4.7.0_RC7  | Deploy/managed-learn/ml-projects-service   | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/managed-learn/ml-reports-service  | release-4.7.0_RC4  | Deploy/managed-learn/ml-reports-service    | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/managed-learn/ml-survey-service   | release-4.7.0_RC3  | Deploy/managed-learn/ml-survey-service     | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/UCI/Inbound                       | release-4.7.0      | Deploy/UCI/Inbound                         | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/UCI/Orchestrator                  | release-4.7.0      | Deploy/UCI/Orchestrator                    | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/UCI/Outbound                      | release-4.7.0      | Deploy/UCI/Outbound                        | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/UCI/Transformer                   | release-4.7.0      | Deploy/UCI/Transformer                     | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/UCI/UCI                           | release-4.7.0      | Deploy/UCI/UCI                             | release-4.7.0_RC2                                                                                                                                                |                                           |
| Build/Core/OfflineInstaller             | release-4.7.0_RC37 | Deploy/Core/OfflineInstaller               | release-4.7.0_RC2                                                                                                                                                |                                           |

### Manual Configurations forSunbird

|Manual Step|Instruction|
|--------------------|--------------------|
| Form Updates | [SB-28625](https://project-sunbird.atlassian.net/browse/SB-28625) <br> [SB-28383](https://project-sunbird.atlassian.net/browse/SB-28383) <br> [SB-28599](https://project-sunbird.atlassian.net/browse/SB-28599) <br> [SB-26155](https://project-sunbird.atlassian.net/wiki/spaces/MC/pages/3059843073/Form+config+4.6+Browser+Flow+change+story+-+SB-26155) <br> [SB-28228](https://project-sunbird.atlassian.net/wiki/spaces/MC/pages/3090382849/Form+4.6+-+SB-28228) |

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure


### Variables for Vidayadaan

|Variable Name|Service Name|Value|Comments|
|-------------|------------|-----|--------|
|Add new ACL for `vidyadaan` consumer on Sunbird environment|_Player_|`anonymousUserCreate`|Add in `Core/common.yml`|

### Build and Deploy for Vidayadaan

| SERVICE TO BE BUILD               | BUILD TAG          | SERVICE TO DEPLOY                                 | DEPLOY TAG                                                | COMMENTS |
|-----------------------------------|--------------------|---------------------------------------------------|-----------------------------------------------------------|----------|
|                                   |                    | Deploy/KnowledgePlatform/CassandraDbUpdate        | release-4.7.0_RC3`                                        |          |
| Build/KnowledgePlatform/FlinkJobs | release-4.7.0_RC9  | Deploy/KnowledgePlatform/FlinkJobs                | release-4.7.0_RC3`                                        |          |
| Build/KnowledgePlatform/Learning  | release-4.7.0_RC3  | Deploy/KnowledgePlatform/Learning                 | release-4.7.0_RC3`                                        |          |
| Build/KnowledgePlatform/Yarn      | release-4.7.0_RC3  | Deploy/KnowledgePlatform/Yarn                     | release-4.7.0_RC3`                                        |          |
|                                   |                    | Deploy/Kubernetes/Upload_CollectionHierarchy_CSV  | release-4.7.0-vdn_RC1                                     | `csv_repo_branch: release-4.7.0` |
|                                   |                    | Deploy/Kubernetes/UploadSchemas                   | release-4.7.0-vdn_RC1                                     | `schemas_branch: release-4.7.0`  |
|                                   |                    | Deploy/Kubernetes/PostgresqlMigration             | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Assessment       | release-4.7.0_RC5  | Deploy/Kubernetes/Assessment                      | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Content          | release-4.7.0_RC5  | Deploy/Kubernetes/Content                         | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Player           | release-4.7.0_RC30 | Deploy/Kubernetes/Player                          | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Program          | release-4.7.0_RC6  | Deploy/Kubernetes/Program                         | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Search           | release-4.7.0_RC5  | Deploy/Kubernetes/Search                          | release-4.7.0-vdn_RC1                                     |          |
| Build/Kubernetes/Taxonomy         | release-4.7.0_RC5  | Deploy/Kubernetes/Taxonomy                        | release-4.7.0-vdn_RC1                                     |          |


### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                 |
|-------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| Form Updates | [SB-26390](https://project-sunbird.atlassian.net/wiki/spaces/SingleSource/pages/3063676929/How+to+configure+forms+for+framework+metadata+for+Project+creation+and+asset+update)  |
