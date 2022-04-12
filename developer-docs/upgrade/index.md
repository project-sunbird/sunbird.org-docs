---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.8.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.7.0 to release 4.8.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Variables for Sunbird

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
| uci_encryption_key_base64 | DP dataproducts | This need to be added in DP/secrets<br>Use the same value which is added in core/secrets.yml<br>Add this only if it is not added previously |
| sunbird_instance | EdDataProducts | This need to be added in DP/common.yml file.<br>Copy value from core/common.yml file |
| auto_creator_g_service_acct_cred |  | Updated in VDN KP common.yml <br>Note that the google service acct credentials json <br>Key has to be updated in the environment variable <br>(existing key has '\\\\n' which is to be replaced with '\\n') |
| sunbird_azure_uci_container_name | Inbound & Outbound | create in {{sunbird_private_storage_account_name}}<br>Updated according to environment: uci-preprod |
| ml_analytics_azure_sas_token |  | create SAS 1 year SAS token with Read, Write, Delete <br>permissions for <br>sunbird_public_storage_account_name/telemetry-data-store |
| ml_analytics_azure_account_name |  | sunbird_public_storage_account_name |
| uci_env | Sunbird Data Pipeline, Transformer | update according to environment<br>in staging env ---> "staging" |



### Build and Deploy for Sunbird

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|  |  | Deploy/Kubernetes/UploadSchemas | branch_or_tag: release-4.8.0_RC3<br>kp_branch_or_tag: release-4.8.0_RC4 |  |
|  |  | Deploy/Kubernetes/DialUploadSchema | branch_or_tag: release-4.8.0_RC3<br>dial_branch_or_tag: release-4.8.0_RC3 |  |
| Build/Core/OfflineInstaller | release-4.8.0_RC31 | Deploy/Core/OfflineInstaller | release-4.8.0_RC3 |  |
| Build/Kubernetes/Assessment | release-4.8.0_RC4 | Deploy/Kubernetes/Assessment | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/Analytics | release-4.8.0_RC3 |  |
| Build/Kubernetes/Content | release-4.8.0_RC4 | Deploy/Kubernetes/Content | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/Learner | release-4.8.0_RC3 |  |
| Build/Kubernetes/Dial | release-4.8.0_RC3 | Deploy/Kubernetes/Dial | release-4.8.0_RC3 | DialUploadSchema needs to be deployed before dial |
| Build/Kubernetes/Lms | release-4.8.0_RC2 | Deploy/Kubernetes/Lms | release-4.8.0_RC3 |  |
| Build/Kubernetes/KnowledgeMW | release-4.8.0_RC2 | Deploy/Kubernetes/KnowledgeMW | release-4.8.0_RC3 |  |
| Build/Kubernetes/Search | release-4.8.0_RC4 | Deploy/Kubernetes/Search | release-4.8.0_RC3 |  |
| Build/Kubernetes/Taxonomy | release-4.8.0_RC4 | Deploy/Kubernetes/Taxonomy | release-4.8.0_RC3 |  |
| Build/Kubernetes/Player | release-4.8.0_RC31 | Deploy/Kubernetes/Player | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/Keycloak | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/APIManager | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/Logging | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/Monitoring | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/OnboardAPIs | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/OnboardConsumers | release-4.8.0_RC3 |  |
|  |  | Deploy/Kubernetes/nginx-public-ingress | release-4.8.0_RC3 |  |
|  |  | Deploy/managed-learn/ml-analytics-service | release-4.8.0_RC3 |  |
| Build/managed-learn/ml-core-service | release-4.8.0_RC4 | Deploy/managed-learn/ml-core-service | release-4.8.0_RC3 |  |
| Build/managed-learn/ml-projects-service | release-4.8.0_RC7 | Deploy/managed-learn/ml-projects-service | release-4.8.0_RC3 |  |
| Build/managed-learn/ml-reports-service | release-4.8.0_RC1 | Deploy/managed-learn/ml-reports-service | release-4.8.0_RC3 |  |
| Build/managed-learn/ml-survey-service | release-4.8.0_RC2 | Deploy/managed-learn/ml-survey-service | release-4.8.0_RC3 |  |
| Build/UCI/utils | release-4.8.0_RC1 |  |  | To be built in sequence-1 |
| Build/UCI/message-rosa | release-4.8.0_RC1 |  |  | To be built in sequence-2 |
| Build/UCI/dao | release-4.8.0_RC1 |  |  | To be built in sequence-3 |
| Build/UCI/Adapter | release-4.8.0_RC1 |  |  | To be built in sequence-4 |
| Build/UCI/Inbound | release-4.8.0_RC1 | Deploy/UCI/Inbound | release-4.8.0_RC3 |  |
| Build/UCI/Orchestrator | release-4.8.0_RC1 | Deploy/UCI/Orchestrator | release-4.8.0_RC3 |  |
| Build/UCI/Outbound | release-4.8.0_RC1 | Deploy/UCI/Outbound | release-4.8.0_RC3 |  |
| Build/UCI/Transformer | release-4.8.0_RC1 | Deploy/UCI/Transformer | release-4.8.0_RC3 |  |
| Build/KnowledgePlatform/Yarn | release-4.8.0_RC7 | Deploy/KnowledgePlatform/Yarn | release-4.8.0_RC7 | Before deploying clear the jars and<br>extract folder |
| Build/KnowledgePlatform/Learning | release-4.8.0_RC7 | Deploy/KnowledgePlatform/Learning | release-4.8.0_RC7 |  |
| Build/KnowledgePlatform/FlinkJobs | release-4.8.0_RC17 | Deploy/KnowledgePlatform/FlinkJobs | release-4.8.0_RC7 |  |
| Build/DataPipeline/CoreDataProducts | release-4.8.0_RC1 | Deploy/DataPipeline/CoreDataProducts | release-4.8.0_RC4 |  |
| Build/DataPipeline/EdDataProducts | release-4.8.0_RC7 | Deploy/DataPipeline/EdDataProducts | release-4.8.0_RC5 |  |
| Build/DataPipeline/ETLJobs | release-4.8.0_RC7 | Deploy/DataPipeline/ETLJobs | release-4.8.0_RC5 |  |
| Build/DataPipeline/ETLDruidContentIndexer | release-4.8.0_RC7 | Deploy/DataPipeline/ETLDruidContentIndexer | release-4.8.0_RC5 |  |
| Build/DataPipeline/FlinkPipelineJobs | release-4.8.0_RC4 | Deploy/DataPipeline/FlinkPipelineJobs | release-4.8.0_RC5 |  |


### Manual Configurations for Sunbird

|Manual Step|Instruction|
|--------------------|--------------------|
| SB-28756<br>Add content-auto-creator flink job in jenkins KP flink job list.<br>Deploy the content-auto-creator job<br>Stop the autocreator samza job |  |
| SB-28381<br>Add qrcode-image-generator flink job in jenkins KP flink job list.<br>Deploy the qrcode-image-generator job<br>Stop the qrcode-image-generator samza job |  |
| Create uci-preprod private containers on Azure for storing <br>inbound and outbound images/videos/audio notes/files - to be accessed by concerned tenants |  |
| Create DialUploadSchema Jenkins Job in Kubernet folder | check below PR for config.xml:<br>https://github.com/project-sunbird/sunbird-devops/pull/3218/files<br><br>Create container as a blob in {{sunbird_public_storage_account_name}}<br>container name should be :  sunbird-dial-{{env}} |

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure


### Build and Deploy for Vidayadaan

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|  |  | Deploy/Kubernetes/UploadSchemas | branch_or_tag: release-4.8.0-vdn_RC1<br>schemas_branch: release-4.8.0_RC18 |  |
| Build/Kubernetes/Assessment | release-4.8.0_RC4 | Deploy/Kubernetes/Assessment | release-4.8.0-vdn_RC1 |  |
| Build/Kubernetes/Content | release-4.8.0_RC4 | Deploy/Kubernetes/Content | release-4.8.0-vdn_RC1 |  |
|  |  | Deploy/Kubernetes/OnboardConsumers | release-4.8.0-vdn_RC1 |  |
|  |  | Deploy/Kubernetes/Onboardapi | release-4.8.0-vdn_RC1 |  |
| Build/Kubernetes/Player | release-4.8.0_RC18 | Deploy/Kubernetes/Player | release-4.8.0-vdn_RC1 |  |
| Build/Kubernetes/Program | release-4.8.0_RC2 | Deploy/Kubernetes/Program | release-4.8.0-vdn_RC1 |  |
| Build/Kubernetes/Search | release-4.8.0_RC4 | Deploy/Kubernetes/Search | release-4.8.0-vdn_RC1 |  |
| Build/Kubernetes/Taxonomy | release-4.8.0_RC4 | Deploy/Kubernetes/Taxonomy | release-4.8.0-vdn_RC1 |  |
| Build/KnowledgePlatform/Yarn | release-4.8.0_RC7 | Deploy/KnowledgePlatform/Yarn | release-4.8.0_RC7 | Before deploying clear the jars and<br>extract folder |
| Build/KnowledgePlatform/Learning | release-4.8.0_RC7 | Deploy/KnowledgePlatform/Learning | release-4.8.0_RC7 |  |
| Build/KnowledgePlatform/FlinkJobs | release-4.8.0_RC17 | Deploy/KnowledgePlatform/FlinkJobs | release-4.8.0_RC7 |  |
| Build/DataPipeline/EdDataProducts | release-4.8.0_RC7 | Deploy/DataPipeline/EdDataProducts | release-4.8.0_RC5 |  |
| Build/DataPipeline/ETLJobs | release-4.8.0_RC7 | Deploy/DataPipeline/ETLJobs | release-4.8.0_RC5 |  |
| Build/DataPipeline/ETLDruidContentIndexer | release-4.8.0_RC7 | Deploy/DataPipeline/ETLDruidContentIndexer | release-4.8.0_RC5 |  |

### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| SB-28756<br>Add content-auto-creator flink job in jenkins KP flink job list.<br>Deploy the content-auto-creator job<br>Stop the autocreator samza job |  |
| Update Default Content Visibility of Practice Set Object Type | Sourcing Circle - VDN https://project-sunbird.atlassian.net/browse/SB-28890 |
