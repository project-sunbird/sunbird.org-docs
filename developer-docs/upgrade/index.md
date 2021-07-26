---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 4.1.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 4.0.0 to release 4.1.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. Any jenkins job configuration or pre-requisites mentioned under manual configuration section needs to be done first before running any of the mentioned jobs. The order of the jobs should also be run as shown below. They can be run in parallel to speed up the execution.

### Variables

|Variable Name|Service Name|Comments|
|-------------|------------|--------|
|core_prom_ip|DataPipeline Monitoring|Update in DP/common.yml<br/>Add core prometheus ip to access flink job consumer lag metrics|
|vdn_domain_name|Kp flink|Update in KP/common.yml<br/>update vdn env domain name|
|source_base_url: {% raw %}"{{proto}}://{{vdn_domain_name}}/api"{% endraw %}|KP flink|Update in KP/common.yml|
|cert_env_prefix|Kp flink|Update in KP/common.yml<br/> ex: cert_env_prefix:sunbird-staging|

### Build and Deploy

|Service to be Build|Build Tag|Service to Deploy|Deploy Tag|Comments|
|-------------------|---------|-----------------|----------|--------|
|||Provision/DataPipeline/Druid|release-4.1.0_RC2||
|||Provision/KnowledgePlatform/Neo4j|release-4.1.0_RC9||
|Build/KnowledgePlatform/FlinkJobs|release-4.1.0_RC8|Deploy/KnowledgePlatform/FlinkJobs|release-4.1.0_RC9|add <b>audit-event-generator</b> in the Jenkins jobs list|
|Build/KnowledgePlatform/Learning|release-4.1.0_RC9|Deploy/KnowledgePlatform/Learning|release-4.1.0_RC9||
|Build/KnowledgePlatform/Neo4j|release-4.1.0_RC1|Deploy/KnowledgePlatform/Neo4j|release-4.1.0_RC9|Update build jobs repo to <b>https://github.com/project-sunbird/knowledge-platform-db-extensions.git</b><br/>  and jenkinsfile to <b>build/neo4j-extensions/Jenkinsfile</b><br/>restart the Neo4J cluster after deployment.<br/>Validate the plugins folder file sizes. (learning jar should be around 3mb only. Previously it is 10mb+)<br/>delete the old Neo4J folder from all vms.(We upgraded to neo4j-enterprise-3.3.10-SNAPSHOT) <b>rm -rf /home/learning/neo4j-learning/</b> neo4j-enterprise-3.3.0|
|Build/KnowledgePlatform/Yarn|release-4.1.0_RC9|Deploy/KnowledgePlatform/Yarn|release-4.1.0_RC9||
|Build/Core/Cassandra|release-4.0.0_RC3|Deploy/Kubernetes/Cassandra|release-4.1.0_RC7||
|||Deploy/Kubernetes/OnboardAPIs|release-4.1.0_RC7||
|||Deploy/Kubernetes/OnboardConsumers|release-4.1.0_RC7||
|Build/Core/Analytics|release-4.1.0_RC1|Deploy/Kubernetes/Analytics|release-4.1.0_RC7||
|Build/Core/Assessment|release-4.1.0_RC8|Deploy/Kubernetes/Assessment|release-4.1.0_RC7||
|Build/Core/Content|release-4.1.0_RC8|Deploy/Kubernetes/Content|release-4.1.0_RC7||
|Build/Core/Learner|release-4.1.0_RC13|Deploy/Kubernetes/Learner|release-4.1.0_RC7||
|Build/Core/Lms|release-4.1.0_RC1|Deploy/Kubernetes/Lms|release-4.1.0_RC7||
|Build/Core/Player|release-4.1.0_RC52|Deploy/Kubernetes/Player|release-4.1.0_RC7||
|Build/Core/Search|release-4.1.0_RC8|Deploy/Kubernetes/Search|release-4.1.0_RC7||
|Build/Core/Taxonomy|release-4.1.0_RC8|Deploy/Kubernetes/Taxonomy|release-4.1.0_RC7||
|||Deploy/Kubernetes/Keycloak|release-4.1.0_RC7|Redeploy same artifact|
|Build/Core/OfflineInstaller|release-4.1.0|Deploy/Core/OfflineInstaller|release-4.1.0_RC7||
|Build/Plugins/ContentEditor|release-4.1.0_RC1|Deploy/Plugins/ContentEditor|release-4.1.0_RC7||
|Build/DataPipeline/AnalyticsCore|release-4.1.0_RC2|Deploy/DataPipeline/AnalyticsCore|release-4.1.0_RC2||
|Build/DataPipeline/CoreDataProducts|release-4.1.0_RC2|Deploy/DataPipeline/CoreDataProducts|release-4.1.0_RC2||
|Build/DataPipeline/EdDataProducts|release-4.1.0_RC9|Deploy/DataPipeline/EdDataProducts|release-4.1.0_RC2||
|Build/DataPipeline/FlinkPipelineJobs|release-4.1.0_RC2|Deploy/DataPipeline/FlinkPipelineJobs|release-4.1.0_RC2||
|Build/DataPipeline/AdhocScripts|release-4.1.0_RC8|Deploy/DataPipeline/AdhocScripts|release-4.1.0_RC2||
|||Deploy/Kubernetes/Monitoring|release-4.1.0_RC7|jenkins parameter <b>tag:dashboards</b>|

### Manual Configurations

|Manual Step|Instruction|
|--------------------|--------------------|
|create new job Upload_CollectionHierarchy_CSV and deploy|[Jenkins job config](https://github.com/project-sunbird/sunbird-devops/pull/2743/files)|

