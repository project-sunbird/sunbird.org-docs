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
|metadata2_redis_host|KP Flink|Same value as it is in DP common.yaml<br/>In KP hosts.yaml, add redis-metadata2, copy this from DP hosts.yaml|
|crypto_encryption_key_external|Portal|generate encryption key using [link](https://www.allkeysgenerator.com/Random/Security-Encryption-Key-Generator.aspx)|
|adminutil__portal_keyprefix: "portalv2_key"|adminutil|add in core/common.yml|
|adminutil__portal_keystart: 1|adminutil|add in core/common.yml|
|adminutil__portal_keycount: 10|adminutil|add in core/common.yml|    
|kong_portal_v2_consumer: "portalv2"|kong|add in core/common.yml|

add kong consumers, add this under kong_consumers dictionary in core/common.yml
```
    - username: portal_app
      groups: "{{ potal_app_groups }}"
      state: present
    - username: portalv2
      groups: "{{ kong_all_consumer_groups + refreshTokenAcl }}"
      state: present
```
add this dictionary in core/common.yml
```
     refreshTokenAcl:
       - refreshTokenCreate
```
Create keys for adminutils.<br/>
Steps to create keys, run these 2 commands from core/keys folder, before running these commands create vault file, ex: ~/.sunbird-vault (only if secrets and keys are encrypted using vault in your environmant)
```
     for i in {1..10}; do openssl genrsa -out portalv2_c$i 2048 && openssl pkcs8 -topk8 -inform PEM -in portalv2_c$i -out portalv2_key$i -nocrypt && rm -rf portalv2_c$i ; done

     while read -r line; do ansible-vault encrypt $line --vault-password-file ~/.sunbird-vault; done <<< $(ls portalv2*)
```


### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|Build/KnowledgePlatform/FlinkJobs|release-4.2.0_RC11|Deploy/KnowledgePlatform/FlinkJobs|release-4.2.0_RC6|add <b>metrics-data-transformer</b> in jobs config deploy all job|
|Build/KnowledgePlatform/Learning|release-4.2.0_RC5|Deploy/KnowledgePlatform/Learning|release-4.2.0_RC6||
|Build/KnowledgePlatform/Yarn|release-4.2.0_RC5|Deploy/KnowledgePlatform/Yarn|release-4.2.0_RC6||
|Build/Core/AdminUtils|release-4.2.0_RC2|Deploy/Kubernetes/AdminUtils|release-4.2.0_RC3||
|Build/Core/Assessment|release-4.2.0_RC9|Deploy/Kubernetes/Assessment|release-4.2.0_RC3||
|Build/Core/Content|release-4.2.0_RC9|Deploy/Kubernetes/Content|release-4.2.0_RC3||
|Build/Core/DiscussionsMW|release-4.2.0_RC2|Deploy/Kubernetes/DiscussionsMW|release-4.2.0_RC3||
|Build/Core/Learner|release-4.2.0_RC13|Deploy/Kubernetes/Learner|release-4.2.0_RC3||
|Build/Core/Player|release-4.2.0_RC36|Deploy/Kubernetes/Player|release-4.2.0_RC3||
|Build/Core/Search|release-4.2.0_RC9|Deploy/Kubernetes/Search|release-4.2.0_RC3||
|Build/Core/Taxonomy|release-4.2.0_RC9|Deploy/Kubernetes/Taxonomy|release-4.2.0_RC3||
|||Deploy/Kubernetes/UploadSchemas|release-4.2.0_RC5||
|||Deploy/Kubernetes/Keycloak|release-4.2.0_RC3|Redeploy same artifact|
|||Deploy/Kubernetes/Nginx-private-ingress|release-4.2.0_RC3|update the variables as per - [link](https://github.com/project-sunbird/sunbird-devops/blob/release-4.2.0/private_repo/ansible/inventory/dev/Core/common.yml#L231-L247)|
|||OnboardConsumer|release-4.2.0_RC3||
|||KongJWTAdminUtil|release-4.2.0_RC3||
|||Deploy/Kubernetes/Monitoring|release-4.2.0_RC2|Create an oauth cred from google cloud account.<br/> Give redirect url as https://{domain_name}/oauth3/callback<br/>update the variables as per - [link](https://github.com/project-sunbird/sunbird-devops/blob/release-4.2.0/private_repo/ansible/inventory/dev/Core/common.yml#L231-L247)|
|Build/Core/OfflineInstaller|release-4.2.0|Deploy/Core/OfflineInstaller|release-4.2.0_RC2|
|Build/DataPipeline/AnalyticsCore|release-4.2.0_RC1|Deploy/DataPipeline/AnalyticsCore|release-4.2.0_RC2||
|Build/DataPipeline/CoreDataProducts|release-4.2.0_RC1|Deploy/DataPipeline/CoreDataProducts|release-4.2.0_RC2||
|Build/DataPipeline/FlinkPipelineJobs|release-4.2.0_RC1|Deploy/DataPipeline/FlinkPipelineJobs|release-4.2.0_RC2|deploy all the jobs|
|Build/Mobile/Sunbird-IONIC-Mobile-App|release-4.2.0_RC14|Deploy/Mobile/Sunbird-IONIC-Mobile-App|release-4.2.0||

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Update DIgital Textbook primaryCategory definition |Jira Links - [SB-25554](https://project-sunbird.atlassian.net/browse/SB-25554)|
|Update Content Playlis & Question paper primaryCategory definition |Jira Links - [25555](https://project-sunbird.atlassian.net/browse/SB-25555)|
|publishchecklist form config Update in all collection primaryCategory definition | Jira Links - [SB-25556](https://project-sunbird.atlassian.net/browse/SB-25556)|
|Upgrade dp redis(dp-redis, metadata-redis). This includes the version upgrade as well.|[steps](https://docs.google.com/spreadsheets/d/1KnjAH_hMzFokmuUYN62HnevihJdXpnrfUgm_VgAH7AU/edit#gid=344919181)|
|form configuration| [link](https://project-sunbird.atlassian.net/wiki/spaces/MC/pages/2909339655/Form+Configuration+release-4.2.0)
