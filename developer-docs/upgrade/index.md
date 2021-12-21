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
| cassandra-migration | sunbird-utils : release-4.5.0_RC2 | sunbird-utils : release-4.5.0_RC2 |  |  |
| ML Core Service | release-4.5.0_RC8 | ML Core Service | release-4.5.0_RC8 |  |
| ML Survey Service | release-4.5.0_RC1 | ML Survey Service | release-4.5.0_RC1 |  |
| ML Projects Service | release-4.5.0_RC7 | ML Projects Service | release-4.5.0_RC7 |  |
| ML Reports Service | release-4.5.0_RC4 | ML Reports Service | release-4.5.0_RC4 |  |
| ML Analytics Service | release-4.5.0_RC1 | ML Analytics Service | release-4.5.0_RC1<br>ml_analytics_version: release-4.5.0 |  |
| Adminutils | release-4.5.0_RC2 | Adminutils | release-4.5.0 |  |
|  |  | OnboardAPIs | release-4.5.0 |  |
|  |  | OnboardConsumer | release-4.5.0 |  |
| cassandra-migration | sunbird-utils : release-4.5.0_RC3 | sunbird-utils : release-4.5.0_RC3 |  |  |
| ETLJobs | build tag: release-4.5.0_RC2 | ETLJobs | deploy tag: release-4.5.0_RC2 |  |
| Ed data-products | release-4.5.0_RC4 | Ed data-products | release-4.5.0 |  |
| Build/UCI/Utils | release-4.4.0 |  |  | In sequence |
| Build/UCI/message-rosa | release-4.4.0_RC1 |  |  |  |
| Build/UCI/dao | release-4.4.0_RC1 |  |  |  |
| Build/UCI/Adapter | release-4.4.0_RC1 |  |  |  |
| Build/UCI/Inbound | release-4.4.0_RC1 | Deploy/UCI/Inbound | release-4.4.0_RC4 |  |
| Build/UCI/odk | release-4.4.0_RC1 | Deploy/UCI/odk | release-4.4.0_RC4 |  |
| Build/UCI/Outbound | release-4.4.0_RC1 | Deploy/UCI/Outbound | release-4.4.0_RC4 |  |
| Build/UCI/Orchestrator | release-4.4.0_RC1 | Deploy/UCI/Orchestrator | release-4.4.0_RC4 |  |
| Build/UCI/Transformer | release-4.4.0_RC1 | Deploy/UCI/Transformer | release-4.4.0_RC4 |  |
| Build/UCI/UCI | release-4.4.0_RC1 | Deploy/UCI/UCI | release-4.4.0_RC4 |  |
|  |  | keycloak | release-4.5.0 |  |
|  |  | BootstrapMinimal | release-4.5.0 | Run helm uninstall reloader first from every namespace |
|  |  | KnowledgeMW | release-4.5.0 |  |
|  |  | Analytics | release-4.5.0 |  |
|  |  | CertRegistry | release-4.5.0 |  |
|  |  | Adminutils | release-4.5.0 | Log4j Fix |
|  |  | Analytics | release-4.5.0 |  |
|  |  | Assessment | release-4.5.0 |  |
|  |  | Cert | release-4.5.0 |  |
|  |  | CertRegistry | release-4.5.0 |  |
|  |  | Content | release-4.5.0 |  |
|  |  | Dial | release-4.5.0 |  |
|  |  | gql | release-4.5.0 |  |
|  |  | Groups | release-4.5.0 |  |
|  |  | Inbound | release-4.5.0 |  |
|  |  | Learner | release-4.5.0 |  |
|  |  | LMS | release-4.5.0 |  |
|  |  | odk | release-4.5.0 |  |
|  |  | orchestrator | release-4.5.0 |  |
|  |  | outbound | release-4.5.0 |  |
|  |  | Search | release-4.5.0 |  |
|  |  | Taxonomy | release-4.5.0 |  |
|  |  | transformer | release-4.5.0 |  |
|  |  | uci | release-4.5.0 |  |
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
|  |  | Deploy/Core/KafkaSetup | release-4.5.0-vdn | check below kafka topic created or not<br>{{env}}.av.question.bulkupload |
|  |  | Upload Schema | release-4.5.0 |  |
|  |  | Assessment | release-4.5.0-vdn | Log4j Fix |
|  |  | Cert | release-4.5.0-vdn | Log4j Fix | 
|  |  | CertRegistry | release-4.5.0-vdn | Log4j Fix | 
|  |  | Contnet | release-4.5.0-vdn | Log4j Fix | 
|  |  | MVC | release-4.5.0-vdn | Log4j Fix | 
|  |  | Opensaber | release-4.5.0-vdn | Log4j Fix | 
|  |  | Search | release-4.5.0-vdn | Log4j Fix | 
|  |  | Taxonomy | release-4.5.0-vdn | Log4j Fix | 
|  |  | telemetry-dp-logstash | release-4.5.0-vdn | Log4j Fix | 
|  |  | Log4jFix | Take job from here - https://github.com/project-sunbird/sunbird-devops/pull/3069/files<br>Or copy from dev OpsAdmin folder<br>Pass job option as below <br>hosts: env<br>release-4.5.0 | Log4j Fix | 

### Manual Configurations for Vidyadaan

| Manual Step                                                                                                       | Instruction                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Systemd Changes | "We've to make manual changes, to avoid reprovisioning of services. Folllow the steps to make those changes. Follow these instructions for the services mentioned below<br><br>- [ ] Systemctl: <br>      Follow the instructions for the services one node at a time<br>      - open service File (file path is mentioned as part of service details below) and add following line under `[Service]`<br>        ```bash<br>        Environment=""""_JAVA_OPTIONS='-Dlog4j2.formatMsgNoLookups=true'""""<br>        ```<br>      - After adding that line <br>        ```bash<br>        sudo systemctl daemon-reload<br>        sudo systemctl restart <proper service name><br>        sudo systemctl status <proper service name> # Should be greeen<br>        ```<br>  - [ ] Elasticsearch (* noted because es service name changes as per the host name. Check the actual service name in the `/usr/lib/systemd/system` folder)<br>        Service Name: *elasticsearch.service <br>        File: /usr/lib/systemd/system/*elasticsearch.service<br>  - [ ] cassandra <br>        Service Name: cassandra.service<br>        File: /run/systemd/generator.late/cassandra.service<br>  - [ ] Keycloak <br>        Service Name: keycloak.service<br>        File: /run/systemd/generator.late/keycloak.service<br>  - [ ] graylog <br>        Service Name: graylog-server.service<br>        File: /usr/lib/systemd/system/graylog-server.service<br>  - [ ] redis <br>        Service Name: redis.service<br>        File: /etc/systemd/system/redis.service<br>  - [ ] mongo <br>        Service Name: mongod.service<br>        File: /lib/systemd/system/mongod.service<br>  - [ ] jenkins <br>        Service Name: jenkins.service<br>        file: /run/systemd/generator.late/jenkins.service" |  |
| "# Learning VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of Learning VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_config_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_search_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_learning_service_mw ../logstash-6.8.21/<br>cp .sincedb_learning_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_language_graph_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_telemetry_event_mw ../logstash-6.8.21/<br>cp .sincedb_dial_graph_event_mw ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment=""JAVA_HOME=/opt/jdk-11""<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy learning service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash" |  |  |
| "# Neo4j VM changes - To be done on Sunbird and VDN<br># Run same steps in each node of neo4j VM<br><br>wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz<br>tar -xf openjdk-11+28_linux-x64_bin.tar.gz<br>sudo mv jdk-11 /opt<br>rm -rf openjdk-11+28_linux-x64_bin.tar.gz<br>/opt/jdk-11/bin/java -version<br># The above command should show java version as 11<br><br><br><br>sudo systemctl stop logstash.service<br>sudo su - learning<br>wget https://artifacts.elastic.co/downloads/logstash/logstash-6.8.21.tar.gz<br>tar -xf logstash-6.8.21.tar.gz<br>rm -rf logstash-6.8.21.tar.gz<br>cd /home/learning/logstash-6.3.1/<br>cp .sincedb_learning_graph_event_neo4j ../logstash-6.8.21/<br>cd ..<br>mv logstash-6.3.1/ logstash-6.3.1_bak<br>ls -larth logstash-6.8.21<br># The above command should show all the .sincedb files copied<br>exit<br><br><br># Added / Update these under [Service] section. Comment out the exisiting Environment and ExecStart and use the below ones<br>sudo vi /etc/systemd/system/logstash.service<br>Environment=""JAVA_HOME=/opt/jdk-11""<br>ExecStart=/home/learning/logstash-6.8.21/bin/logstash -f /home/learning/logstash-6.8.21/logstash-lp.conf -w 1 --verbose<br>sudo systemctl daemon-reload<br><br># Redeploy neo4j service with new tag<br># Verify logstash version is 6.8.21<br>ps -ef \| grep logstash<br>" |  |  |
| Upgrade Elastic Search | Steps:<br><br>First:<br>Take backup of comp-es <br><br>Second:<br>Stop elastic search process on all the comp-es nodes<br>Take disk snapshot<br><br>Third:<br>Update elastic search version <br>- $sudo su <br>- $export ES_PATH_CONF=/etc/elasticsearch<br>- $apt update<br>- $apt-cache madison elastic search # make sure the latest version is 6.8.21<br>- $apt install elasticsearch ( it'll ask whether to override the configs, keep the old one. press `O` )<br>Update repository azure plugin for ES 6.8.21<br>- cd /usr/share/elasticsearch/bin<br>- ./elasticsearch-plugin remove repository-azure<br>- ./elasticsearch-plugin install repository-azure<br><br>Fourth:<br>Start elastic search process on each node after new version is installed on all the nodes |  |
