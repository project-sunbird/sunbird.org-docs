---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.9.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.8.0 to release 4.9.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Build and Deploy for Sunbird

| SERVICE TO BE BUILD | BUILD TAG | SERVICE TO DEPLOY  | DEPLOY TAG  | COMMENTS  |
|-----------------------------------------|--------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
| Build/Core/OfflineInstaller | release-4.9.0_RC25  | Deploy/Core/OfflineInstaller| release-4.9.0_RC2  |  |
| Build/Kubernetes/Cassandra  | release-4.9.0_RC1   | Deploy/Kubernetes/Cassandra  | release-4.9.0_RC2 |   |
| Build//DataPipeline/AnalyticsCore | release-4.9.0_RC1 | Deploy/DataPipeline/AnalyticsCore | release-4.9.0_RC3 |  |
| Build/DataPipeline/CoreDataProducts | release-4.9.0_RC1 | Deploy//DataPipeline/CoreDataProducts | release-4.9.0_RC3 | |
| Build/DataPipeline/EdDataProducts | release-4.9.0_RC3 | Deploy/DataPipeline/EdDataProducts | release-4.9.0_RC3 | |
| Build/DataPipeline/FlinkPipelineJobs | release-4.9.0_RC2 | Deploy/DataPipeline/FlinkPipelineJobs | release-4.9.0_RC3 | |
| Build/KnowledgePlatform/FlinkJobs | release-4.9.0_RC11 | Deploy/KnowledgePlatform/FlinkJobs | release-4.9.0_RC1 | |
|               |    | Deploy/Kubernetes/UploadSchemas | release-4.9.0_RC2 | kp_branch_or_tag : release-4.9.0_RC8
|               |    | Deploy/Kubernetes/DialUploadSchema | release-4.9.0_RC2 | dial-repo tag : release-4.9.0_Rc1 |
|               |    | Deploy/Kubernetes/Analytics | release-4.9.0_Rc2 | |
| Build/Kubernetes/Assessment | release-4.9.0_RC8 | Deploy/Kubernetes/Assessment | release-4.9.0_RC2 | |
| Build/Kubernetes/CertRegistry | release-4.9.0_Rc1 | Deploy/Kubernetes/CertRegistry | release-4.9.0_RC2 | |
| Build/Kubernetes/Content | release-4.9.0_RC8 | Deploy/Kubernetes/Content | release-4.9.0_RC2 | |
| Build/Kuberenetes/Dial | release-4.9.0_RC1 | Deploy/Kubernetes/Dial | release-4.9.0_RC2 | |
|                        |                    | Deploy/Kubernetes/KnowledgeMW | release-4.9.0_RC2 | |
|                        |                   | Deploy/Kubernetes/Keycloak | release-4.9.0_RC2 | |
| Build/Kubernetes/Learner | release-4.9.0_RC1 | Deploy/Kubernetes/Learner | release-4.9.0_RC2 | |
| Build/Kubernetes/Lms | release-4.9.0_RC4 | Deploy/Kubernetes/Lms | release-4.9.0_Rc2 | |
|                      |                   | Deploy/Kubernetes/Notification | release-4.9.0_RC2 | |
| Build/Kubernetes/Player | release-4.9.0_RC25 | Deploy/Kubernetes/Player | release-4.9.0_RC2 | |
|                         |                    | Deploy/Kubernetes/Report | release-4.9.0_RC2 | |
| Build/Kubernetes/Search | release-4.9.0_RC8 | Deploy/Kubernetes/Search | release-4.9.0_RC2 | |
| Build/Kubernetes/Taxonomy | release-4.9.0_RC8 | Deploy/Kubernetes/Taxonomy | release-4.9.0_RC2 | |
|             |   | Deploy/Kubernetes/nginx-private-ingress | release-4.9.0_RC2 | |
|             |   | Deploy/Kubernetes/nginx-public-ingress | release-4.9.0_RC2 | |
|             |   | Deploy/Kubernetes/OnboardAPIs | release-4.9.0_Rc2 | |
|          |  | Deploy/managed-learn/ml-analytics-service  | release-4.9.0_RC2 | |
| Build//managed-learn/ml-core-service | release-4.9.0_RC4 | Deplo/managed-learn/ml-core-service | release-4.9.0_RC2 | |
| Build/managed-learn/ml-projects-service | release-4.9.0_RC5 | Deploy/managed-learn/ml-projects-service | release-4.9.0_RC2 | |
| Build/managed-learn/ml-reports-service | release-4.9.0_RC11 | Deploy/managed-learn/ml-reports-service | release-4.9.0_RC2 | |
| Build/managed-learn/ml-survey-service    release-4.9.0_Rc2 |   Deploy/managed-learn/ml-survey-service | release-4.9.0_RC2 | |
| Build/Plugins/ContentPlugins | release-4.9.0_RC1 | Deploy/Plugins/ContentPlugins | release-4.9.0_RC2 | |
|             |                   | Deploy/Sunbird-RC/Registry | release-4.9.0_RC2 | |


### Manual Configurations for Sunbird

|Manual Step|Instruction|
|--------------------|--------------------|
| Add soft link to Core/keys directory in private repo for Sunbird-RC directory | ln -s ../Core/keys/ keys |
| Enable reuse of questions from question set editor | [SB-28566](https://project-sunbird.atlassian.net/browse/SB-28566) || Creation of a new tab called Question Sets to be created on Web Portal for searchability by users | [SB-29588](https://project-sunbird.atlassian.net/browse/SB-29588) |
| Addition of a new Content Type - Exam Question | [SB-29584](https://project-sunbird.atlassian.net/browse/SB-29584) |
| Udpate the menu config | [SB-29779](https://project-sunbird.atlassian.net/browse/SB-29779) <br> [SB-29791](https://project-sunbird.atlassian.net/browse/SB-29791) |

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure


### Build and Deploy for Vidayadaan

| SERVICE TO BE BUILD               | BUILD TAG          | SERVICE TO DEPLOY                                 | DEPLOY TAG                                                | COMMENTS |
|-----------------------------------|--------------------|---------------------------------------------------|-----------------------------------------------------------|----------|
| Build/KnowledgePlatform/FlinkJobs | release-4.9.0_RC11 | Deploy/KnowledgePlatform/FlinkJobs | release-4.9.0_RC1 | `job_names_to_deploy: Choose all` |
| Build/Kubernetes/Assessment | release-4.9.0_RC8 | Deploy/Kubernetes/Assessment | release-4.9.0-vdn_RC1 |    |
| Build/Kubernetes/Content    | release-4.9.0_RC8  | Deploy/Kubernetes/Content    | release-4.9.0-vdn_RC1 |  |
| Build/Kubernetes/Player     | release-4.9.0_RC18 | Deploy/Kubernetes/Player     | release-4.9.0-vdn_RC1 |   |
| Build/Kubernetes/Program    | release-4.9.0_RC1  | Deploy/Kubernetes/Program    | release-4.9.0-vdn_RC1 |    |
| Build/Kubernetes/Search     | release-4.9.0_RC8  | Deploy/Kubernetes/Search     | release-4.9.0-vdn_RC1  |   |
| Build/Kubernetes/Taxonomy   | release-4.9.0_RC8  | Deploy/Kubernetes/Taxonomy   | release-4.9.0-vdn_RC1  |   |         
|  |    | Deploy/Kubernetes/UploadSchemas | release-4.9.0-vdn_RC1 | schema branch : release-4.9.0 |


### Manual Configuration for vdn
|Manual Step|Instruction|
|--------------------|--------------------|
| Enable reuse of questions from question set editor | [SB-28566](https://project-sunbird.atlassian.net/browse/SB-28566)  |
