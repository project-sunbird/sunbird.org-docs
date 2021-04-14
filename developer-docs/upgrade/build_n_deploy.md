---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 3.8.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 3.7.0 to release 3.8.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs.

### Variables

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
|sunbird_portal_offline_supported_languages|Player Service|This variable should be removed from private <code>Core/common.yml</code> if defined|
|adminutil_refresh_token_secret_key       |Adminutils   |- Go to http://KEYCLOAK_IP:8080/auth/admin/master/console/#/realms/sunbird/keys<br> - Get this secret value from DB, by loging into the keycloak 7 postgres DB and run the query: `SELECT value FROM component_config CC INNER JOIN component C ON(CC.component_id = C.id) WHERE C.realm_id = 'sunbird' and provider_id = 'hmac-generated' AND CC.name = 'secret';`<br> - [More details with pictures are here](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/2281734145/Keycloak+Upgrade+from+3.2.0+to+7.0.1)<br> - This was done as part of release-3.7.0 hotfix|

### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|||Provision/Core/Keycloak|release-3.8.0_RC9|This was done as part of release-3.7.0 hotfix|
|||Provision/DataPipeline/AnalyticsSpark|release-3.8.0_RC6||
|||OpsAdministration/Core/ESMapping|release-3.8.0_RC9|Choose `userv1,orgv2` for jenkins job parameter `indices_name`|
|Build/Core/Cassandra|release-3.8.0_RC2|Deploy/Kubernetes/Cassandra|release-3.8.0_RC9||
|||Deploy/Kubernetes/UploadSchemas|release-3.8.0_RC9||
|||Deploy/Kubernetes/APIManager|release-3.8.0_RC9|- You should see annotations in APIManager pods as `fluentbit.io/parser: kong`|
|||Deploy/Kubernetes/OnboardAPIs|release-3.8.0_RC9||
|||Deploy/Kubernetes/OnboardConsumers|release-3.8.0_RC9||
|||Deploy/KnowledgePlatform/KafkaSetup|release-3.8.0_RC10||
|||Deploy/KnowledgePlatform/Neo4jDefinitionUpdate|release-3.8.0_RC10||
|Build/Core/AdminUtils|release-3.7.0_RC1|Deploy/Kubernetes/AdminUtils|release-3.8.0_RC9|This was done as part of release-3.7.0 hotfix|
|Build/Core/Analytics|release-3.8.0_RC1|Deploy/Kubernetes/Analytics|release-3.8.0_RC9||
|Build/Core/Assessment|release-3.8.0_RC6|Deploy/Kubernetes/Assessment|release-3.8.0_RC9||
|Build/Core/Bot|release-3.8.0_RC1|Deploy/Kubernetes/Bot|release-3.8.0_RC9||
|Build/Core/Content|release-3.8.0_RC6|Deploy/Kubernetes/Content|release-3.8.0_RC9||
|Build/Core/DiscussionsMW|release-3.8.0_RC2|Deploy/Kubernetes/DiscussionsMW|release-3.8.0_RC9||
|Build/Core/Groups|release-3.8.0_RC1|Deploy/Kubernetes/Groups|release-3.8.0_RC9||
|Build/Core/Keycloak|release-3.8.0_RC1|Deploy/Kubernetes/Keycloak|release-3.8.0_RC9|This was done as part of release-3.7.0 hotfix. In this release we have only changed telemetry pdata version, so only a redeploy is required if you are already upgraded to Keycloak 7|
|Build/Core/KnowledgeMW|release-3.8.0_RC3|Deploy/Kubernetes/KnowledgeMW|release-3.8.0_RC9||
|Build/Core/Learner|release-3.8.0_RC27|Deploy/Kubernetes/Learner|release-3.8.0_RC9||
|Build/Core/Lms|release-3.8.0_RC7|Deploy/Kubernetes/Lms|release-3.8.0_RC9||
|Build/Core/Nodebb|release-3.8.0_RC1|Deploy/Kubernetes/Nodebb|release-3.8.0_RC9||
|Build/Core/Player|release-3.8.0_RC50|Deploy/Kubernetes/Player|release-3.8.0_RC9||
|Build/Core/Router|release-3.8.0_RC1|Deploy/Kubernetes/Router|release-3.8.0_RC9||
|Build/Core/Search|release-3.6.0_RC6|Deploy/Kubernetes/Search|release-3.8.0_RC9||
|Build/Core/Taxonomy|release-3.6.0_RC6|Deploy/Kubernetes/Taxonomy|release-3.8.0_RC9||
|Build/KnowledgePlatform/KnowledgePlatform|release-3.8.0_RC10|Deploy/KnowledgePlatform/Learning|release-3.8.0_RC10||
|Build/KnowledgePlatform/Yarn|release-3.8.0_RC10|Deploy/KnowledgePlatform/Yarn|release-3.8.0_RC10||
|Build/KnowledgePlatform/FlinkJobs|release-3.8.0_RC5|Deploy/KnowledgePlatform/FlinkJobs|release-3.8.0_RC10|- Kill `composite-search-indexer` and `post-publish-processor` samza job before deployment<br>- Choose `enrolment-reconciliation` `post-publish-processor` `search-indexer` and `questionset-publish` for jenkins job parameter `job_names_to_deploy`|
|Build/DataPipeline/AnalyticsCore|release-3.8.0_RC1|Deploy/DataPipeline/AnalyticsCore|release-3.8.0_RC6||
|Build/DataPipeline/CoreDataProducts|release-3.8.0_RC1|Deploy/DataPipeline/CoreDataProducts|release-3.8.0_RC6||
|Build/DataPipeline/EdDataProducts|release-3.8.0_RC6|Deploy/DataPipeline/EdDataProducts|release-3.8.0_RC6|- The deploy jobs needs to be run two times<br>- Deploy using default jenkins job parameter values first time<br>- Type `cronjobs` for jenkins job paramater `module` in the second deployment to enable `course-batch-status-updater` cronjob to run every 30 minutes once|
|Build/DataPipeline/ETLJobs|release-3.8.0_RC4|Deploy/DataPipeline/ETLJobs|release-3.8.0_RC6||
|||Deploy/DataPipeline/ETLDruidContentIndexer|release-3.8.0_RC6||
|||Deploy/DataPipeline/ETLUserCacheIndexer|release-3.8.0_RC6|- Take the record count of index 12 from metadata redis before deploying<br>- Tail the logs using `tail -f /mount/data/analytics/content-snapshot/logs/<today's-date>-task-execution.log`<br>- Deploy the job<br> - Watchout for these keywords in the logs `Time taken for complete script` and `Time taken for indiviual steps`|
|Build/DataPipeline/FlinkPipelineJobs|release-3.8.0_RC4|Deploy/DataPipeline/FlinkPipelineJobs|release-3.8.0_RC6|- Change Jenkinsfile path to `kubernetes/pipelines/deploy/flink-jobs/Jenkinsfile`<br>- Choose `user-cache-updater-v2` for jenkins parameter `job_names_to_deploy`|
|||Deploy/Kubernetes/Monitoring|release-3.8.0_RC9|Choose `all` for jenkins job paramater `tag`|
|||Deploy/Kubernetes/LoggingFileBeatsVM|release-3.8.0_RC9|Select all hosts for the jenkins job paramater `hosts` and Choose `default` for the jenkins job paramater `tags`|
|||Deploy/KnowledgePlatform/LoggingFileBeatsVM|release-3.8.0_RC9|Select all hosts for the jenkins job paramater `hosts` and Choose `default` for the jenkins job paramater `tags`|
|||Deploy/DataPipeline/LoggingFileBeatsVM|release-3.8.0_RC9|Select all hosts for the jenkins job paramater `hosts` and Choose `default` for the jenkins job paramater `tags`|
|||Deploy/Kubernetes/Logging|release-3.8.0_RC9|- Choose `fluent-bit` for jenkins job paramater `chartname`<br>- Go to Kibana -> Management -> Index Patterns -> Click on `logstash-2` -> Refresh<br>- Verify nginx and kong logs are being parsed using the below search queries<br>- `kubernetes_labels_app: "nginx-public-ingress" (you should see fields starting with n_)`<br>- `kubernetes_labels_app: "apimanager" (you should see fields starting with k_)`<br>- Also all `.` are replaced with `_` for search queries<br>- Example: Old `kubernetes.labels.app`, New `kubernetes_labels_app`|

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|Update jenkins job|Refer [PR1](https://github.com/project-sunbird/sunbird-devops/pull/2322) [PR2](https://github.com/project-sunbird/sunbird-devops/pull/2407)|
|Delete old user index|`curl --location --request DELETE 'localhost:9200/user?pretty'`|
|ES Re-Indexing|Run this after ESMapping job and before deploying Learner Service [ES-Reindexing Steps](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2346156058/SC-2190+ES+scaling+-+reindexing+Org+index)|
|Org and User Migrations|Run this after deploying Learner Service [Org Migration Script](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2341339139/SC-2220+Data+Migration+on+Organisation+Table) [User Migration Script](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2316271628/SC-2224+Migration+of+existing+data+to+the+new+columns+in+user+table)|
|User and Org Sync|Run this after Org and User Migrations Scripts [Script Link](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2437480455/SC-2190+sync+tool+for+learner-service)|
|Update the forms|Jira Links - [SB-23481](https://project-sunbird.atlassian.net/browse/SB-23481) [SB-23627](https://project-sunbird.atlassian.net/browse/SB-23627) [SB-23671](https://project-sunbird.atlassian.net/browse/SB-23671) [SB-23859](https://project-sunbird.atlassian.net/browse/SB-23859) [SB-22505](https://project-sunbird.atlassian.net/browse/SB-22505)|
|Run neo4j cypher script|Run this at the end of deployment [Script Link](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-3.8.0/docs/cypher-scripts/release-3.8.0.cypher)|
|Delete all content and collection entry from KnowledgePlatform redis cache|- Run this after running the neo4j cypher script<br> - <code>redis-cli --scan --pattern do_* &#124; xargs redis-cli del</code><br> - <code>redis-cli --scan --pattern hierarchy_do_* &#124; xargs redis-cli del</code><br>|
|Run Cateogory Definition Update API|Run this at the end of deployment and restart Content and Assessment Service post successful API execution [Course Primary Category API](https://project-sunbird.atlassian.net/wiki/spaces/SingleSource/pages/2364964876/Course+primaryCategory+Config) [Practice Questionset Primary Category API](https://project-sunbird.atlassian.net/wiki/spaces/SingleSource/pages/2400616475/Practice+Question+Set+primaryCategory+Config)|
