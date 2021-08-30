---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.2.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 4.1.0 to release 4.2.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.

### Variables

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
|dock_private_ingressgateway_ip|Knowledge Platform FlinkJobs|Update in KP/common.yml<br/>Add dock env private ingress ip|
|learning_content_drive_apiKey||Update in Core/common.yml<br/>[Create the Key](https://support.google.com/googleapi/answer/6158862?hl=en) and Add in Sunbird and VDN|


### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|Build/KnowledgePlatform/FlinkJobs|release-4.2.0_RC8|Deploy/KnowledgePlatform/FlinkJobs|release-4.2.0_RC5|deploy all job|
|Build/KnowledgePlatform/Learning|release-4.2.0_RC5|Deploy/KnowledgePlatform/Learning|release-4.2.0_RC5||
|Build/KnowledgePlatform/Yarn|release-4.2.0_RC5|Deploy/KnowledgePlatform/Yarn|release-4.2.0_RC5||
|Build/Core/AdminUtils|release-4.2.0_RC2|Deploy/Kubernetes/AdminUtils|release-4.2.0_RC2||
|Build/Core/Assessment|release-4.2.0_RC9|Deploy/Kubernetes/Assessment|release-4.2.0_RC2||
|Build/Core/Content|release-4.2.0_RC9|Deploy/Kubernetes/Content|release-4.2.0_RC2||
|Build/Core/DiscussionsMW|release-4.2.0_RC2|Deploy/Kubernetes/DiscussionsMW|release-4.2.0_RC2||
|Build/Core/Learner|release-4.2.0_RC13|Deploy/Kubernetes/Learner|release-4.2.0_RC2||
|Build/Core/Player|release-4.2.0_RC34|Deploy/Kubernetes/Player|release-4.2.0_RC2||
|Build/Core/Search|release-4.2.0_RC9|Deploy/Kubernetes/Search|release-4.2.0_RC2||
|Build/Core/Taxonomy|release-4.2.0_RC9|Deploy/Kubernetes/Taxonomy|release-4.2.0_RC2||
|||Deploy/Kubernetes/Keycloak|release-4.2.0_RC2|Redeploy same artifact|
|||Deploy/Kubernetes/Nginx-private-ingress|release-4.2.0_RC2|[update the variables as per](https://github.com/project-sunbird/sunbird-devops/blob/release-4.2.0/private_repo/ansible/inventory/dev/Core/common.yml#L231-L247)|
|||Deploy/Kubernetes/Monitoring||Create an oauth cred from google cloud account.<br/> Give redirect url as https://{domain_name}/oauth3/callback<br/> [update the variables as per](https://github.com/project-sunbird/sunbird-devops/blob/release-4.2.0/private_repo/ansible/inventory/dev/Core/common.yml#L231-L247)|
|Build/Core/OfflineInstaller|release-4.2.0|Deploy/Core/OfflineInstaller|release-4.2.0_RC2|
|Build/DataPipeline/AnalyticsCore|release-4.2.0_RC1|Deploy/DataPipeline/AnalyticsCore|release-4.2.0_RC2||
|Build/DataPipeline/CoreDataProducts|release-4.2.0_RC1|Deploy/DataPipeline/CoreDataProducts|release-4.2.0_RC2||
|Build/DataPipeline/FlinkPipelineJobs|release-4.2.0_RC1|Deploy/DataPipeline/FlinkPipelineJobs|release-4.2.0_RC2|deploy all the jobs|

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Update JENKINS job - AnalyticsReplayJob, add job id - druid-dataset|[SB-24105](https://project-sunbird.atlassian.net/browse/SB-24105)|
|Update DIgital Textbook primaryCategory definition |Jira Links - [SB-25554](https://project-sunbird.atlassian.net/browse/SB-25554)|
|Update Content Playlis & Question paper primaryCategory definition |Jira Links - [25555](https://project-sunbird.atlassian.net/browse/SB-25555)|
|publishchecklist form config Update in all collection primaryCategory definition | Jira Links - [SB-25556](https://project-sunbird.atlassian.net/browse/SB-25556)|
|Upgrade dp redis(dp-redis, metadata-redis). This includes the version upgrade as well.|[steps](https://docs.google.com/spreadsheets/d/1KnjAH_hMzFokmuUYN62HnevihJdXpnrfUgm_VgAH7AU/edit#gid=344919181)|
