---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.4.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.3.0 to release 4.4.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Variables for Sunbird

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
|sunbird_default_file_size|Player|Update in `Core/common.yml` <br/>The default value is `150`|
|Add new ACL to Vidyadaan consumer|OnboardConsumers|Add under VDN consumer group`refreshTokenCreate`|
|uci_api_admin_token|transformer, uci-api|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|hasura_graphql_admin_secret|transformer, uci-api|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|fusionauth_service_admin_key|transformer, uci-api|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|uci_encryption_key_base64|transformer, uci-api|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|uci_encryption_key_string|transformer, uci-api|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|uci_odk_user|okd|Update in `Core/Common.yml` <br> `administrator`|
|uci_odk_password|okd|Update in `Core/Common.yml` <br> The value can be generated using `https://passwordsgenerator.net/`|
|uci_kafka_topic_create|UCI|Update in `Core/Common.yml` <br> `true`|
|uci_go_to_start_char|transformer|Update in `Core/Common.yml` <br> `0`|
|uci_one_level_up_char|transformer|Update in `Core/Common.yml` <br> `99`|



### Build and Deploy for Sunbird

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
| Build/Plugins/ContentPlayer|release-4.4.0_RC1|Deploy/Plugins/ContentPlayer|release-4.4.0_RC4||
| Build/Plugins/ContentPlugins|release-4.4.0_RC5|Deploy/Plugins/ContentPlugins|release-4.4.0_RC4||
|||Deploy/Core/KafkaSetup|release-4.4.0_RC4||
|||Deploy/Kubernetes/Keycloak|release-4.4.0_RC4||
|||Provision/Core/ESMapping|release-4.4.0_RC4||
|Build/Mobile/Sunbird-IONIC-Mobile-App|release-4.4.0_RC22|||
| Build/Core/OfflineInstaller|release-4.4.0_RC32|Deploy/Core/OfflineInstaller|release-4.4.0_RC4||
|Build/Core/Cassandra|release-4.4.0_RC2|Deploy/Kubernetes/Cassandra|release-4.4.0_RC4||
|Build/Kubernetes/Assessment|release-4.4.0_RC3|Deploy/Kubernetes/Assessment|release-4.4.0_RC5||
|Deploy/Kubernetes/Content|release-4.4.0_RC3|Deploy/Kubernetes/Content|release-4.4.0_RC5||
|Build/Kubernetes/DiscussionsMW|release-4.4.0_RC4|Deploy/Kubernetes/DiscussionsMW|release-4.4.0_RC4||
|Build/Kubernetes/Groups|release-4.4.0_RC4|Deploy/Kubernetes/Groups|release-4.4.0_RC4||
|Build/Kubernetes/Learner|release-4.4.0_RC11|Deploy/Kubernetes/Learner|release-4.4.0_RC4||
|Build/Kubernetes/Nodebb|release-4.4.0_RC3<br>nodebb_version: v1.16.0|Deploy/Kubernetes/Nodebb|release-4.4.0_RC4||
|Build/Kubernetes/Notification|release-4.4.0_RC5|Deploy/Kubernetes/Notification|release-4.4.0_RC4||
|Build/Kubernetes/Player|release-4.4.0_RC32|Deploy/Kubernetes/Player|release-4.4.0_RC5||
|Build/Kubernetes/Search|release-4.4.0_RC2|Deploy/Kubernetes/Search|release-4.4.0_RC5||
|Build/Kubernetes/Taxonomy|release-4.4.0_RC2|Deploy/Kubernetes/Taxonomy|release-4.4.0_RC5||
|||Deploy/managed-learn/ml-analytics-service|release-4.4.0_RC4 <br> ml_analytics_version:release-4.4.0_RC1||
|Build/managed-learn/ml-core-service|release-4.4.0_RC8|Deploy/managed-learn/ml-core-service|release-4.4.0_RC4||
|Build/managed-learn/ml-projects-service|release-4.4.0_RC9|Deploy/managed-learn/ml-projects-service|release-4.4.0_RC4||
|Build/managed-learn/ml-reports-service|release-4.4.0_RC4|Deploy/managed-learn/ml-reports-service|release-4.4.0_RC4||
|Build/managed-learn/ml-survey-service|release-4.4.0_RC4|Deploy/managed-learn/ml-survey-service|release-4.4.0_RC4||
|Build/UCI/Utils|release-4.4.0_RC1|||From here some build jobs needs to be run in sequence<br>`sequence-1`|
|Build/UCI/message-rosa|release-4.4.0_RC1|||`sequence-2`|
|Build/UCI/dao|release-4.4.0_RC1|||`sequence-3`|
|Build/UCI/Adapter|release-4.4.0_RC1|||`sequence-4`|
|Build/UCI/Inbound|release-4.4.0_RC1|Deploy/UCI/Inbound|release-4.4.0_RC4||
| Build/UCI/odk|release-4.4.0_RC1|Deploy/UCI/odk|release-4.4.0_RC4 ||
|Build/UCI/Outbound|release-4.4.0_RC1|Deploy/UCI/Outbound|release-4.4.0_RC4||
|Build/UCI/Orchestrator|release-4.4.0_RC1|Deploy/UCI/Orchestrator|release-4.4.0_RC4||
|Build/UCI/Transformer|release-4.4.0_RC1|Deploy/UCI/Transformer|release-4.4.0_RC4||
| Build/UCI/UCI|release-4.4.0_RC1|Deploy/UCI/UCI|release-4.4.0_RC4||
|||Deploy/UCI/fusionauth|release-4.4.0_RC4||
|||Deploy/UCI/gql|release-4.4.0_RC4||
|||Deploy/Kubernetes/LoggingFileBeatsVM|release-4.4.0_RC4||
|||Deploy/Kubernetes/Logging|release-4.4.0_RC4||
|||Deploy/Kubernetes/OnboardAPIs|release-4.4.0_RC4||
|||Deploy/Kubernetes/OnboardConsumers|release-4.4.0_RC4||
|||OpsAdministration/Core/GraylogMongoImport|release-4.4.0_RC4||
|Build/KnowledgePlatform/FlinkJobs|release-4.4.0_RC3|Deploy/KnowledgePlatform/FlinkJobs|release-4.4.0_RC5|Deploy all flink jobs|
|Build/KnowledgePlatform/Learning|release-4.4.0_RC5|Deploy/KnowledgePlatform/Learning|release-4.4.0_RC5||
|Build/KnowledgePlatform/Yarn|release-4.4.0_RC5|Deploy/KnowledgePlatform/Yarn|release-4.4.0_RC5||
|BuildDataPipeline/AnalyticsCore|release-4.4.0_RC2|Deploy/DataPipeline/AnalyticsCore|release-4.4.0_RC2||
|Build/DataPipeline/CoreDataProducts|release-4.4.0_RC1|Deploy/DataPipeline/CoreDataProducts|release-4.4.0_RC2||
|Build/DataPipeline/EdDataProducts|release-4.4.0_RC3|Deploy/DataPipeline/EdDataProducts|release-4.4.0_RC2||


### Manual Configurations for Sunbird

|Manual Step|Instruction|
|--------------------|--------------------|
|User Feed Migration|Run manually with the help of documentaion in  spark machine<br><b>SB-26190 : [UserFeed Migration Script](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2959409153/SB-26190+User+Feed+Migration)|
|Adding UCI folder in private repo |Create UCI folder under specific env and create symlinks from `core` folder|
|Create jenkins jobs related to UCI |Create Build, ArtifactUpload and Deploy jobs for UCI services from below<br> [Github Link](https://github.com/project-sunbird/sunbird-devops/tree/release-4.4.0/deploy/jenkins/jobs)|
|Create postgres DB's for UCI services|Change username based on env<br>`create database "uci-botdb";` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-botdb" to sunbirdstaging;` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-botdb" to "sunbirdstaging@sunbirdstaging-postgres";` <br><br> `create database "uci-formsdb";` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-formsdb" to sunbirdstaging;` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-formsdb" to "sunbirdstaging@sunbirdstaging-postgres";` <br><br> `create database "uci-fusionauth";` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-fusionauth" to sunbirdstaging;` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-fusionauth" to "sunbirdstaging@sunbirdstaging-postgres";` <br><br> `create database "uci-odk-aggregate";` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-odk-aggregate" to sunbirdstaging;` <br> `GRANT ALL PRIVILEGES ON DATABASE "uci-odk-aggregate" to "sunbirdstaging@sunbirdstaging-postgres";`|
|Create cassandra keyspace for UCI|Use below command to create keyspace <br> `CREATE KEYSPACE {{env}}_uci_store`|
|Settingup FusionAuth after UCI service deployments|Setting up Fusionauth and adding API Key <br> `kubectl get services --namespace=<env> | grep fusionauth-frontend` <br> `Go to the Public IP above http://<IP>:9011/admin/setup-wizard` <br><br> `Setup Fusionauth with the following fields.` <br> `First Name - UCI-Staging` <br> `Last Name - Sunbird` <br> `Email - <respective email>` <br> `Pass: generate using https://passwordsgenerator.net/` <br> <br> `Go to the http://<IP>:9011/admin/api-key/add and add the API` <br> `Key - {{fusionauth_service_admin_key}} by creating a new API Key.`|
|update existing variable in core/common.yml, do not add new variable `enable_tenant_config`|`“*” : It will allow for all tenants` <br> `current value is "OFF"` <br> `we are disabling it in the current release so use OFF value in preprod and prod ` |
|Truncate `portal.sessions` cassandra table|`TRUNCATE portal.sessions`; <br> Remove the backup / snapshot folder on every node after truncate <br> `Example: rm -rf /var/lib/cassandra/data/portal/sessions-9811ae90915711eb85b423bdb45bf1b8/snapshots/truncated-1635236404732-sessions`|
|Cassandra data migration from userProfileType to userProfileTypes|Follow steps mentioned in below link<br>[SB-26822](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2993618947/SB-26822+Cassandra+data+migration+from+userProfileType+to+userProfileTypes)|
|ES reindexing for user is required to be updated|`Jenkins job : Provision/job/dev/job/Core/job/ESMapping/` <br> `provide indices_name : userv3` <br> `In es_files options choose : indices, mappings, pipelines` <br> Follow mentioned steps [SB-26823](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2993651713/SB-26823+Re-indexing+User+index+to+support+multiple+userProfileType)|
|Move ESMapping job from OpsAdministration folder to Provision Folder|[Github Link](https://github.com/project-sunbird/sunbird-devops/tree/release-4.4.0/deploy/jenkins/jobs/Provision/jobs/dev/jobs/Core/jobs/ESMapping)|
|Update ESMapping jenkins job config from this PR|[Github Link](https://github.com/project-sunbird/sunbird-devops/pull/2987)|
|System Setting update to support new sms DLT templateId as per this tkt SB-27415|Execute command mentioned in [Link](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2945449992/SB-26932+System+Settings+config+curl+for+NIC+SMS+Provide+integration)|
|SB-26424 : Data migration for existing users - Consent status to be updated for sso users with multiple externalids"|Execute steps mentioned in [SB-26424](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/3003449345/SB-26424+Data+migration+for+existing+users+-+Consent+status+to+be+updated+for+sso+users+with+multiple+externalids)|
|Add new option for Logging VM job|Check below PR <br>[https://github.com/project-sunbird/sunbird-devops/pull/2996/files](https://github.com/project-sunbird/sunbird-devops/pull/2996/files)|
|Upgrade postgres to version 11 in staging|Follow below steps for upgrade <br> [https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/3008462870/Generic+Postgres+Upgrade+Document](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/3008462870/Generic+Postgres+Upgrade+Document)|

##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure

### Variables for Vidyadaan

| Variable Name                     | Service Name       | Comments                                                                                                                                                                     |
|-----------------------------------|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| dock_default_file_size            | sourcing portal    | Default Value: 150                                                                                                                                                           |
| dock_default_video_size           | sourcing portal    | Default Value: 15000                                                                                                                                                         |
| Add new ACL to Vidyadaan consumer | refreshTokenCreate | This has to be done on sunbird environment                                                                                                                                   |
| sunbird_api_auth_token            |                    | Grant refersh token API access to bearer mapped for this variable <br> (https://{{sunbird_domain_name}}/auth/v1/refresh/token)                                               |
| use_sunbird_kong_token            |                    | Default Value is true, which disables the feature. <br> Please make it true to enable new auth token structure. [Ref](https://project-sunbird.atlassian.net/browse/SB-26667) |
| sunbird_domain_name               | sourcing portal    | eg: staging.sunbirded.org                                                                                                                                                    |


### Build and Deploy for Vidayadaan

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|Build/Plugins/Content-plugins|release-4.4.0_RC3|Deploy/Plugins/Content-plugins|release-4.4.0-vdn||
|||Deploy/Dock/Kubernetes/OnboardConsumers|release-4.4.0-vdn||
|||Deploy/Kubernetes/OnboardAPIs|release-4.4.0-vdn||
|||Deploy/Kubernetes/UploadSchemas|release-4.4.0-vdn<br>`kp_branch_or_tag: release-4.4.0_RC53`||
|||Deploy/Kubernetes/Upload_CollectionHierarchy_CSV|release-4.4.0_RC4||
|||Deploy/KnowledgePlatform/KafkaSetup|release-4.4.0_RC5||
|Build/Dock/Assessment|release-4.4.0_RC2|Deploy/Kubernetes/Assessment|release-4.4.0-vdn||
|Build/Dock/Content|release-4.4.0_RC2|Deploy/Kubernetes/Content|release-4.4.0-vdn||
|Build/Dock/Player|release-4.4.0_RC53|Deploy/Kubernetes/Player|release-4.4.0-vdn||
|Build/Dock/Program|release-4.4.0_RC5|Deploy/Kubernetes/Program|release-4.4.0-vdn||
|Build/Dock/Search|release-4.4.0_RC2|Deploy/Kubernetes/Search|release-4.4.0-vdn||
|Build/Dock/Taxonomy|release-4.4.0_RC2|Deploy/Kubernetes/Taxonomy|release-4.4.0-vdn||
|Build/Dock/KnowledgePlatform/FlinkJobs|release-4.4.0_RC3|Deploy/KnowledgePlatform/FlinkJobs|release-4.4.0_RC5|Deploy all flink jobs|
|Build/Dock/KnowledgePlatform/Learning|release-4.4.0_RC5|Deploy/KnowledgePlatform/Learning|release-4.4.0_RC5||
|Build/Dock/KnowledgePlatform/Yarn|release-4.4.0_RC5|Deploy/KnowledgePlatform/Yarn|release-4.4.0_RC5||
|||Deploy/Kubernetes/PostgresqlMigration|release-4.4.0_RC5||

### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Create Upload_CollectionHierarchy_CSV jenkins job                                                                 | [PR Link](https://github.com/project-sunbird/sunbird-devops/pull/2990)                                                                 |
| Upgrade postgres to version 11 in vdn staging                                                                     | Follow below steps [Link](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/3008462870/Generic+Postgres+Upgrade+Document) |
| Please update the Question Paper collection category definition <br> in Dock staging	Category Definition details | Ref: https://project-sunbird.atlassian.net/browse/SB-26908                                                                             |
| Category defination updates in VDN                                                                                | Ref: https://project-sunbird.atlassian.net/wiki/spaces/SingleSource/pages/3014164481/Content+NOT+created+under+a+target+collection     |

