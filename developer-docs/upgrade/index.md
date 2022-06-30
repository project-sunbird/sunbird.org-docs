---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.10.0

## Overview


This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.9.0 to release 4.10.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Build and Deploy for Sunbird

| SERVICE TO BE BUILD | BUILD TAG | SERVICE TO DEPLOY  | DEPLOY TAG  | COMMENTS  |
|-----------------------------------------|--------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
|  |  | Provision/Core/ESMapping | release-4.10.0_RC1 |
| Build/Kubernetes/Cassandra | release-4.10.0_RC1 | Deploy/Kubernetes/Cassandra | release-4.10.0_RC1 |
| Build/Kubernetes/Learner | release-4.10.0_RC4 | Deploy/Kubernetes/Learner | release-4.10.0_RC1 |
| Build/Kubernetes/DiscussionMW | release-4.10.0_RC3 | Deploy/Kubernetes/DiscussionMW | release-4.10.0_RC1 |
| Build/Kubernetes/Assessment | release-4.10.0_RC2 | Deploy/Kubernetes/Assessment | release-4.10.0_RC1 |
| Build/Kubernetes/Report | release-4.10.0_RC6 | Deploy/Kubernetes/Report | release-4.10.0_RC1 |
| Build/Kubernetes/Search | release-4.10.0_RC2 | Deploy/Kubernetes/Search | release-4.10.0_RC1 |
| Build/Kubernetes/Taxonomy | release-4.10.0_RC2 | Deploy/Kubernetes/Taxonomy | release-4.10.0_RC1 |
| Build/Kubernetes/Content | release-4.10.0_RC2 | Deploy/Kubernetes/Content | release-4.10.0_RC1 |
| Build/Kubernetes/Player | release-4.10.0_RC12 | Deploy/Kubernetes/Player | release-4.10.0_RC1 |
| Build/Core/OfflineInstaller | release-4.10.0_RC12 | Deploy/Core/Player | release-4.10.0_RC1 |
| Build/managed-learn/ml-core-service | release-4.10.0_RC1 | Deploy/managed-learn/ml-core-service | release-4.10.0_RC1 |
| Build/managed-learn/ml-projects-service | release-4.10.0_RC1 | Deploy/managed-learn/ml-projects-service | release-4.10.0_RC1 |
| Build/managed-learn/ml-reports-service | release-4.10.0_RC1 | Deploy/managed-learn/ml-reports-service | release-4.10.0_RC1 |
| Build/managed-learn/ml-survey-service | release-4.10.0_RC1 | Deploy/managed-learn/ml-csurveyore-service | release-4.10.0_RC1 |
|  |  | Deploy/managed-learn/ml-analytics-service | release-4.10.0_RC1 |
| Build/KnowledgePlatform/FlinkJobs | release-4.10.0_RC1 | Deploy/KnowledgePlatform/FlinkJobs | release-4.10.0_RC1 |
|  |  | Provision/DataPipeline/AnalyticsSpark | release-4.10.5_RC2 |
| Build/DataPipeline/AnalyticsCore | release-4.10.5_RC1 | Deploy/DataPipeline/AnalyticsCore | release-4.10.5_RC2 |
| Build/DataPipeline/CoreDataProducts | release-4.10.5_RC2 | Deploy/DataPipeline/CoreDataProducts | release-4.10.5_RC2 |
| Build/DataPipeline/EdDataProducts | release-4.10.5_RC3 | Deploy/DataPipeline/EdDataProducts | release-4.10.5_RC2 |
| Build/DataPipeline/ETLJobs | release-4.10.5_RC2 | Deploy/DataPipeline/ETLJobs | release-4.10.5_RC2 |

### Manual Configurations for Sunbird

|Manual Step|Instruction|
|--------------------|--------------------|
| ES mapping and reindexing<br>SB-29813 | Please follow the wiki to create new pindex and mapping of org and reindex the data<br> https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2346156058/SC-2190+ES+scaling+-+reindexing+Org+index |

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure


### Build and Deploy for Vidayadaan

| SERVICE TO BE BUILD               | BUILD TAG          | SERVICE TO DEPLOY                                 | DEPLOY TAG                                                | COMMENTS |
|-----------------------------------|--------------------|---------------------------------------------------|-----------------------------------------------------------|----------|
| Build/Kubernetes/Assessment | release-4.10.0_RC2 | Deploy/Kubernetes/Assessment | release-4.10.0-vdn |
| Build/Kubernetes/Content | release-4.10.0_RC2 | Deploy/Kubernetes/Content | release-4.10.0-vdn |
| Build/Kubernetes/Player | release-4.10.0_RC7 | Deploy/Kubernetes/Player | release-4.10.0-vdn |
| Build/Kubernetes/Search | release-4.10.0_RC2 | Deploy/Kubernetes/Search | release-4.10.0-vdn |
| Build/Kubernetes/Taxonomy | release-4.10.0_RC2 | Deploy/Kubernetes/Taxonomy | release-4.10.0-vdn |
| Build/KnowledgePlatform/FlinkJobs | release-4.10.0_RC1 | DeployKnowledgePlatform/FlinkJobs | release-4.10.0_RC1 |
| Build/DataPipeline/EdDataProducts | release-4.10.5_RC3 | Deploy/DataPipeline/EdDataProducts | release-4.10.5_RC2 |
| Build/DataPipeline/ETLJobs | release-4.10.5_RC2 | Deploy/DataPipeline/ETLJobs | release-4.10.5_RC2 |

### Manual Configuration for vdn

|Manual Step|Instruction|
|--------------------|--------------------|
| N/A | N/A |