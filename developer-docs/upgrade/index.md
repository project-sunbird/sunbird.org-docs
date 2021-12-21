---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.5.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird and Vidaydaan release 4.4.0 to release 4.5.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.


### Variables for Sunbird

| Variable Name | Service Name | Default Public Value | Private Value Override | Comments |
|:---:|:---:|:---:|:---:|:---:|
| adminutil_embed_role | Adminutils | false | true | Embeds the user's role in the token<br>Ensure to put the value in single quotes |
| New kong consumer | Admintils | NA | Add a new ansible dictionary with ACL as below<br>userAccess:<br>  - userAccess<br><br>Add a new kong consumer to the kong_consumers dictionary as shown below<br>  - username: adminutil_learner_api_key<br>    groups: "{{ userAccess }}"<br>    state: present | To connect to learner service via kong, we are creating a new consumer |
| adminutil_learner_api_auth_key | Admintils | NA | Run the OnboardConsumers job and take the JWT token for the consumer adminutil_learner_api_key | To connect to learner service via kong, we are creating a new consumer |
| Add acls for desktop app | Desktop | NA |   - readNotificationFeed<br>  - updateNotificationFeed<br>  - deleteNotificationFeed | To access notification service APIs from desktop app |
| Add new variables in Core/common.yml | OPA |  | kong_desktop_device_consumer_names_for_opa: '["desktop_devicev2", "desktop_device"]' | To disable checks for desktop app |



### Build and Deploy for Sunbird

| Service to be Build | Build Tag | Service to Deploy | Deploy Tag | Comments |
|:---:|:---:|:---:|:---:|:---:|
| Build/managed-learn/ml-core-service | release-4.5.0_RC8 | Deploy/managed-learn/ml-core-service | release-4.5.0_RC1 |
| Build/managed-learn/ml-projects-service | release-4.5.0_RC7 | Deploy/managed-learn/ml-projects-service | release-4.5.0_RC1 |
| Build/Kubernetes/Player | release-4.5.0_RC45 | Deploy/Kubernetes/Player | release-4.5.0_RC1 |
| Build/KnowledgePlatform/FlinkJobs | release-4.5.0_RC42 | Deploy/KnowledgePlatform/FlinkJobs | release-4.5.0_RC1 |
| Build/managed-learn/ml-reports-service | release-4.5.0_RC4 | Deploy/managed-learn/ml-reports-service | release-4.5.0_RC1 |
| Build/Kubernetes/Notification | release-4.5.0_RC4 | Deploy/Kubernetes/Notification | release-4.5.0_RC1 |
| Build/Kubernetes/Cassandra | release-4.5.0_RC4 | Deploy/Kubernetes/Cassandra | release-4.5.0_RC1 |
| Build/DataPipeline/FlinkPipelineJobs | release-4.5.0_RC4 | Deploy/DataPipeline/FlinkPipelineJobs | release-4.5.0_RC1 |
| Build/DataPipeline/EdDataProducts | release-4.5.0_RC4 | Deploy/DataPipeline/EdDataProducts | release-4.5.0_RC1 |
| Build/Kubernetes/Taxonomy | release-4.5.0_RC2 | Deploy/Kubernetes/Taxonomy | release-4.5.0_RC1 |
| Build/Kubernetes/Search | release-4.5.0_RC2 | Deploy/Kubernetes/Search | release-4.5.0_RC1 |
| Build/Kubernetes/Content | release-4.5.0_RC2 | Deploy/Kubernetes/Content | release-4.5.0_RC1 |
| Build/Kubernetes/Assessment | release-4.5.0_RC2 | Deploy/Kubernetes/Assessment | release-4.5.0_RC1 |
| Build/Kubernetes/AdminUtils | release-4.5.0_RC2 | Deploy/Kubernetes/AdminUtils | release-4.5.0_RC1 |
| Build/DataPipeline/ETLUserCacheIndexer | release-4.5.0_RC2 | Deploy/DataPipeline/ETLUserCacheIndexer | release-4.5.0_RC1 |
| Build/DataPipeline/ETLJobs | release-4.5.0_RC2 | Deploy/DataPipeline/ETLJobs | release-4.5.0_RC1 |
| Build/DataPipeline/ETLDruidContentIndexer | release-4.5.0_RC2 | Deploy/DataPipeline/ETLDruidContentIndexer | release-4.5.0_RC1 |
| Build/KnowledgePlatform/Yarn | release-4.5.0_RC11 | Deploy/KnowledgePlatform/Yarn | release-4.5.0_RC1 |
| Build/KnowledgePlatform/Learning | release-4.5.0_RC11 | Deploy/KnowledgePlatform/Learning | release-4.5.0_RC1 |
| Build/Kubernetes/Learner | release-4.5.0_RC10 | Deploy/Kubernetes/Learner | release-4.5.0_RC1 |
| Build/managed-learn/ml-survey-service | release-4.5.0_RC1 | Deploy/managed-learn/ml-survey-service | release-4.5.0_RC1 |
| Build/Kubernetes/Lms | release-4.5.0_RC1 | Deploy/Kubernetes/Lms | release-4.5.0_RC1 |
| Build/Kubernetes/Groups | release-4.5.0_RC1 | Deploy/Kubernetes/Groups | release-4.5.0_RC1 |
| Build/Core/OfflineInstaller | release-4.5.0 | Deploy/Core/OfflineInstaller | release-4.5.0_RC1 |
|  |  | Deploy/UCI/UCI | release-4.5.0_RC1 |
|  |  | Deploy/UCI/Transformer | release-4.5.0_RC1 |
|  |  | Deploy/UCI/Outbound | release-4.5.0_RC1 |
|  |  | Deploy/UCI/Orchestrator | release-4.5.0_RC1 |
|  |  | Deploy/UCI/odk | release-4.5.0_RC1 |
|  |  | Deploy/UCI/Inbound | release-4.5.0_RC1 |
|  |  | Deploy/UCI/gql | release-4.5.0_RC1 |
|  |  | Deploy/UCI/fusionauth | release-4.5.0_RC1 |
|  |  | Deploy/managed-learn/ml-analytics-service | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Report | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/OnboardConsumers | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/OnboardAPIs | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/nginx-private-ingress | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Logging | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/KnowledgeMW | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Keycloak | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/HawkeyeSuperset | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Enc | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Dial | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/CertRegistry | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Cert | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/BootstrapMinimal | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/APIManager | release-4.5.0_RC1 |
|  |  | Deploy/Kubernetes/Analytics | release-4.5.0_RC1 |
|  |  | Deploy/KnowledgePlatform/Neo4jElasticSearchSyncTool | release-4.5.0_RC1 |
|  |  | Deploy/DataPipeline/CoreDataProducts | release-4.5.0_RC1 |
|  |  | Deploy/DataPipeline/AnalyticsCore | release-4.5.0_RC1 |
|  |  | Log4jFix | Take job from here - https://github.com/project-sunbird/sunbird-devops/pull/3069/files<br>Or copy from dev OpsAdmin folder<br>Pass job option as below <br>hosts: env<br>release-4.5.0 |  |


### Manual Configurations for Sunbird

| Manual Step | Instruction |Comments |
|:---:|:---:|:---:|
| enable_tenant_config<br><br>(update existing variable in core/common.yml, do not add new variable) | Environment Variable config for Group Service : <br>release-4.5.0_RC1 |  enable_tenant_config =tn<br><br>Note : Any change in the configuration needs redeployment of the group service to reflect. |
| Add two job_ids in AnalyticsReplayJob jenkins job | Job_ids:<br>progress-exhaust-v2<br>response-exhaust-v2<br>score-metric-migration-job | PR: https://github.com/project-sunbird/sunbird-devops/pull/3028 |
| Systemd Changes | We've to make manual changes, to avoid reprovisioning of services. Folllow the steps to make those changes. Follow these instructions for the services mentioned below<br><br>- [ ] Systemctl: <br>      Follow the instructions for the services one node at a time<br>      - open service File (file path is mentioned as part of service details below) and add following line under `[Service]`<br>        ```bash<br>        Environment=""_JAVA_OPTIONS='-Dlog4j2.formatMsgNoLookups=true'""<br>        ```<br>      - After adding that line <br>        ```bash<br>        sudo systemctl daemon-reload<br>        sudo systemctl restart <proper service name><br>        sudo systemctl status <proper service name> # Should be greeen<br>        ```<br>  - [ ] Elasticsearch (* noted because es service name changes as per the host name. Check the actual service name in the `/usr/lib/systemd/system` folder)<br>        Service Name: *elasticsearch.service <br>        File: /usr/lib/systemd/system/*elasticsearch.service<br>  - [ ] cassandra <br>        Service Name: cassandra.service<br>        File: /run/systemd/generator.late/cassandra.service<br>  - [ ] Keycloak <br>        Service Name: keycloak.service<br>        File: /run/systemd/generator.late/keycloak.service<br>  - [ ] graylog <br>        Service Name: graylog-server.service<br>        File: /usr/lib/systemd/system/graylog-server.service<br>  - [ ] redis <br>        Service Name: redis.service<br>        File: /etc/systemd/system/redis.service<br>  - [ ] mongo <br>        Service Name: mongod.service<br>        File: /lib/systemd/system/mongod.service<br>  - [ ] jenkins <br>        Service Name: jenkins.service<br>        file: /run/systemd/generator.late/jenkins.service |  |
| upgrade learning vm | https://docs.google.com/spreadsheets/d/1KnjAH_hMzFokmuUYN62HnevihJdXpnrfUgm_VgAH7AU/edit#gid=1317239687 |  |
| upgrade keycloak vm | https://docs.google.com/spreadsheets/d/1KnjAH_hMzFokmuUYN62HnevihJdXpnrfUgm_VgAH7AU/edit#gid=726563363 |  |
| Update kubectl | # Install kubectl v1.22.0<br>curl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectlchmod +x kubectl<br>sudo mv kubectl /usr/local/bin |  |
| # Learning VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of Learning VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_config_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_search_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_learning_service_mw ../logstash-6.8.21/<br>cp .sincedb_learning_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_graph_event_mw ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment="JAVA_HOME=/opt/jdk-11"<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy learning service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash |  |  |
| # Neo4j VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of neo4j VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_graph_event_neo4j ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment="JAVA_HOME=/opt/jdk-11"<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy neo4j service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash |  |  |


##### Note: The below jobs are applicable only if you are running Vidyadaan infrastructure

### Variables for Vidyadaan

| Variable Name | Service Name | Default Public Value | Private Value Override | Comments |
|:---:|:---:|:---:|:---:|:---:|
| sunbird_google_oauth_client_email | Program |  |  | Please set the google drive client email |
| sunbird_google_oauth_private_key | Program |  |  | Please set the google drive private key |
| av_kafka_topic_create |  | FALSE | TRUE |  |


### Build and Deploy for Vidayadaan

| Service to be Build | Build Tag | Service to Deploy | Deploy Tag | Comments |
|:---:|:---:|:---:|:---:|:---:|
|  |  |  |  |  |
|  |  | Deploy/Core/KafkaSetup | release-4.5.0-vdn | check below kafka topic created or not<br>{{env}}.av.question.bulkupload |
|  |  | Upload Schema | release-4.5.0 |  |
|  |  |  |  |  |
|  |  | Deploy/DockStaging/Kubernetes/APIManager | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Assessment | release-4.5.0_RC2 | Deploy/DockStaging/Kubernetes/Assessment | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Content | release-4.5.0_RC2 | Deploy/DockStaging/Kubernetes/Content | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Opensaber | vidyadaan | Deploy/DockStaging/Kubernetes/Opensaber | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Player | release-4.5.0_RC9 | Deploy/DockStaging/Kubernetes/Player | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Program | release-4.5.0_RC1 | Deploy/DockStaging/Kubernetes/Program | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Search | release-4.5.0_RC2 | Deploy/DockStaging/Kubernetes/Search | release-4.5.0-vdn |  |
| DockBuild/Kubernetes/Taxonomy | release-4.5.0_RC2 | Deploy/DockStaging/Kubernetes/Taxonomy | release-4.5.0-vdn |  |
|  |  |  |  |  |
|  |  |  |  |  |
| DockBuild/KnowledgePlatform/Learning | release-4.5.0_RC9 | Deploy/DockStaging/KnowledgePlatform/Learning | release-4.5.0 |  |
| DockBuild/KnowledgePlatform/Yarn | release-4.5.0_RC9 | Deploy/DockStaging/KnowledgePlatform/Yarn | release-4.5.0 |  |
|  |  |  |  |  |
|  |  |  |  |  |
| DockBuild/KnowledgePlatform/FlinkJobs | release-4.5.0_RC9 | Deploy/DockStaging/KnowledgePlatform/FlinkJobs | release-4.5.0 |  |
| DockBuild/DataPipeline/EdDataProducts | release-4.5.0_RC4 | Deploy/DockStaging/DataPipeline/EdDataProducts | release-4.5.0 |  |
|  |  | Log4jFix | Take job from here - https://github.com/project-sunbird/sunbird-devops/pull/3069/files<br>Or copy from dev OpsAdmin folder<br>Pass job option as below <br>hosts: env<br>release-4.5.0 | Log4j Fix | 


### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Systemd Changes | "We've to make manual changes, to avoid reprovisioning of services. Folllow the steps to make those changes. Follow these instructions for the services mentioned below<br><br>- [ ] Systemctl: <br>      Follow the instructions for the services one node at a time<br>      - open service File (file path is mentioned as part of service details below) and add following line under `[Service]`<br>        ```bash<br>        Environment=""""_JAVA_OPTIONS='-Dlog4j2.formatMsgNoLookups=true'""""<br>        ```<br>      - After adding that line <br>        ```bash<br>        sudo systemctl daemon-reload<br>        sudo systemctl restart <proper service name><br>        sudo systemctl status <proper service name> # Should be greeen<br>        ```<br>  - [ ] Elasticsearch (* noted because es service name changes as per the host name. Check the actual service name in the `/usr/lib/systemd/system` folder)<br>        Service Name: *elasticsearch.service <br>        File: /usr/lib/systemd/system/*elasticsearch.service<br>  - [ ] cassandra <br>        Service Name: cassandra.service<br>        File: /run/systemd/generator.late/cassandra.service<br>  - [ ] Keycloak <br>        Service Name: keycloak.service<br>        File: /run/systemd/generator.late/keycloak.service<br>  - [ ] graylog <br>        Service Name: graylog-server.service<br>        File: /usr/lib/systemd/system/graylog-server.service<br>  - [ ] redis <br>        Service Name: redis.service<br>        File: /etc/systemd/system/redis.service<br>  - [ ] mongo <br>        Service Name: mongod.service<br>        File: /lib/systemd/system/mongod.service<br>  - [ ] jenkins <br>        Service Name: jenkins.service<br>        file: /run/systemd/generator.late/jenkins.service" |  |
| "# Learning VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of Learning VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_config_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_search_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_learning_service_mw ../logstash-6.8.21/<br>cp .sincedb_learning_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_graph_event_mw ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment=""JAVA_HOME=/opt/jdk-11""<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy learning service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash" |  |  |
| "# Neo4j VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of neo4j VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_graph_event_neo4j ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment=""JAVA_HOME=/opt/jdk-11""<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy neo4j service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash<br>" |  |  |
| Upgrade Elastic Search | Steps:<br><br>First:<br>Take backup of comp-es <br><br>Second:<br>Stop elastic search process on all the comp-es nodes<br>Take disk snapshot<br><br>Third:<br>Update elastic search version <br>- $sudo su <br>- $export ES_PATH_CONF=/etc/elasticsearch<br>- $apt update<br>- $apt-cache madison elastic search # make sure the latest version is 6.8.21<br>- $apt install elasticsearch ( it'll ask whether to override the configs, keep the old one. press `O` )<br>Update repository azure plugin for ES 6.8.21<br>- cd /usr/share/elasticsearch/bin<br>- ./elasticsearch-plugin remove repository-azure<br>- ./elasticsearch-plugin install repository-azure<br><br>Fourth:<br>Start elastic search process on each node after new version is installed on all the nodes |  |
