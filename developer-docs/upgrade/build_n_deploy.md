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
|sunbird_portal_offline_supported_languages|Player Service|This variable should be removed from private <code>Core/common.yml</code> if defined|
|adminutil_refresh_token_secret_key       |Adminutils   |- Go to http://KEYCLOAK_IP:8080/auth/admin/master/console/#/realms/sunbird/keys<br> - Get this secret value from DB, by loging into the keycloak 7 postgres DB and run the query: `SELECT value FROM component_config CC INNER JOIN component C ON(CC.component_id = C.id) WHERE C.realm_id = 'sunbird' and provider_id = 'hmac-generated' AND CC.name = 'secret';`<br> - [More details with pictures are here](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/2281734145/Keycloak+Upgrade+from+3.2.0+to+7.0.1)<br> - This was done as part of release-3.9.0 hotfix and is not required if you are already on Keycloak 7|
|kp_schema_base_path       |Flink Job   |- This variable should be added in private repo under `Core/common.yml` and `KnowledgePlatform/common.yml`<br> - <code>{%raw%}kp_schema_base_path: "{{proto}}://{{sunbird_public_storage_account_name}}.blob.core.windows.net/{{plugin_container_name}}/schemas/local"{%endraw%}</code>|

### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|||Provision/Core/Keycloak|release-4.0.0_RC9|This was done as part of release-3.9.0 hotfix and is not required if you are already on Keycloak 7|
|||Provision/DataPipeline/AnalyticsSpark|release-4.0.0_RC6||
|||OpsAdministration/Core/ESMapping|release-4.0.0_RC9|Choose `userv1,orgv2` for jenkins job parameter `indices_name`|
|Build/Core/Cassandra|release-4.0.0_RC2|Deploy/Kubernetes/Cassandra|release-4.0.0_RC9||
|||Deploy/Kubernetes/UploadSchemas|release-4.0.0_RC9|Provide value as `release-4.0.0_RC6` for the jenkins job paramater `kp_branch_or_tag`|
|||Deploy/Kubernetes/APIManager|release-4.0.0_RC9|- You should see annotations in APIManager pods as `fluentbit.io/parser: kong`|
|||Deploy/Kubernetes/OnboardAPIs|release-4.0.0_RC9||
|||Deploy/Kubernetes/OnboardConsumers|release-4.0.0_RC9||
|||Deploy/KnowledgePlatform/KafkaSetup|release-4.0.0_RC10||
|||Deploy/KnowledgePlatform/Neo4jDefinitionUpdate|release-4.0.0_RC10||
|Build/Core/AdminUtils|release-3.9.0_RC1|Deploy/Kubernetes/AdminUtils|release-4.0.0_RC9|This was done as part of release-3.9.0 hotfix and is not required if you are already on Keycloak 7|
|Build/Core/Analytics|release-4.0.0_RC1|Deploy/Kubernetes/Analytics|release-4.0.0_RC9||
|Build/Core/Assessment|release-4.0.0_RC6|Deploy/Kubernetes/Assessment|release-4.0.0_RC9||
|Build/Core/Bot|release-4.0.0_RC1|Deploy/Kubernetes/Bot|release-4.0.0_RC1||
|Build/Core/Content|release-4.0.0_RC6|Deploy/Kubernetes/Content|release-4.0.0_RC9||
|Build/Core/DiscussionsMW|release-4.0.0_RC2|Deploy/Kubernetes/DiscussionsMW|release-4.0.0_RC9||
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
|Build/KnowledgePlatform/FlinkJobs|release-4.0.0_RC5|Deploy/KnowledgePlatform/FlinkJobs|release-4.0.0_RC10|- Kill `composite-search-indexer` and `post-publish-processor` samza job before deployment<br>- Choose `enrolment-reconciliation` `post-publish-processor` `search-indexer` and `questionset-publish` for jenkins job parameter `job_names_to_deploy`|
|Build/DataPipeline/AnalyticsCore|release-4.0.0_RC1|Deploy/DataPipeline/AnalyticsCore|release-4.0.0_RC6||
|Build/DataPipeline/CoreDataProducts|release-4.0.0_RC1|Deploy/DataPipeline/CoreDataProducts|release-4.0.0_RC6||
|Build/DataPipeline/ETLJobs|release-4.0.0_RC4|Deploy/DataPipeline/ETLJobs|release-4.0.0_RC6||
|||Deploy/DataPipeline/ETLDruidContentIndexer|release-4.0.0_RC6|This job needs to be run after all the migrations mentioned in the manual configuration section|
|||Deploy/DataPipeline/ETLUserCacheIndexer|release-4.0.0_RC6|- Take the record count of index 12 from metadata redis before deploying<br>- Tail the logs using `tail -f /mount/data/analytics/content-snapshot/logs/<today's-date>-task-execution.log`<br>- Deploy the job<br> - Watchout for these keywords in the logs `Time taken for complete script` and `Time taken for indiviual steps`<br>- This job needs to be run after all the migrations mentioned in the manual configuration section|
|Build/DataPipeline/FlinkPipelineJobs|release-4.0.0_RC4|Deploy/DataPipeline/FlinkPipelineJobs|release-4.0.0_RC6|- Change Jenkinsfile path to `kubernetes/pipelines/deploy/flink-jobs/Jenkinsfile`<br>- Choose `user-cache-updater-v2` for jenkins parameter `job_names_to_deploy`<br>- This job needs to be run after all the migrations mentioned in the manual configuration section|
|Build/DataPipeline/EdDataProducts|release-4.0.0_RC6|Deploy/DataPipeline/EdDataProducts|release-4.0.0_RC6|- The deploy jobs needs to be run two times<br>- Deploy using default jenkins job parameter values first time<br>- Type `cronjobs` for jenkins job paramater `module` in the second deployment to enable `course-batch-status-updater` cronjob to run every 30 minutes once<br>- This job needs to be run after all the migrations mentioned in the manual configuration section|
|||Deploy/Kubernetes/Monitoring|release-4.0.0_RC9|Choose `all` for jenkins job paramater `tag`|
|||Deploy/Kubernetes/LoggingFileBeatsVM|release-4.0.0_RC9|Select all hosts for the jenkins job paramater `hosts` and choose `default` for the jenkins job paramater `tags`|
|||Deploy/KnowledgePlatform/LoggingFileBeatsVM|release-4.0.0_RC9|Select all hosts for the jenkins job paramater `hosts` and choose `default` for the jenkins job paramater `tags`|
|||Deploy/DataPipeline/LoggingFileBeatsVM|release-4.0.0_RC9|Select all hosts for the jenkins job paramater `hosts` and choose `default` for the jenkins job paramater `tags`|
|||Deploy/Kubernetes/Logging|release-4.0.0_RC9|- Choose `fluent-bit` for jenkins job paramater `chartname`<br>- Go to Kibana -> Management -> Index Patterns -> Click on `logstash-2` -> Refresh<br>- Verify nginx and kong logs are being parsed using the below search queries<br>- `kubernetes_labels_app: "nginx-public-ingress" (you should see fields starting with n_)`<br>- `kubernetes_labels_app: "apimanager" (you should see fields starting with k_)`<br>- All `.` notation are replaced with `_` notation for search queries<br>- Old: `kubernetes.labels.app`, New: `kubernetes_labels_app`|

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Delete jenkins job parameter from Keycloak deploy job|Delete sunbird_auth_branch_or_tag|
|Update the forms|Jira Links - [SB-24836](https://project-sunbird.atlassian.net/browse/SB-24836) [SB-24926](https://project-sunbird.atlassian.net/browse/SB-24926) [SB-24951](https://project-sunbird.atlassian.net/browse/SB-24951)|
|Created Google auth console for Android app|Jira Link - [SB-21678](https://project-sunbird.atlassian.net/browse/SB-21678)|
|DF TABLE MIGRATIONS|[Migration](https://project-sunbird.atlassian.net/browse/SB-24753)|
|Run scripts mentioned in link in learning-service | [Script 1](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC3/scripts/framework-master-category/framework-master-category) [Script 2](https://github.com/project-sunbird/knowledge-platform/blob/release-4.0.0_RC4/scripts/framework-master-category/framework-master-category)|
|Add job_id in AnalyticsReplayJob|job_id: cassandra-migration|
