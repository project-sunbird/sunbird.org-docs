---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.5.0, Core, elasticsearch
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 2.4.0 to release 2.5.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. 

As part of this upgrade, you may choose to set up the load balancer for swarm managers. If you do not require a load balancer for swarm managers, only update the value of the variable **sunbird_swarm_manager_lb_ip** to the swarm manager's IP in the private repository.


## Running the Builds 

**IMPORTANT**: 

1. Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.

3. Build and deploy plugins. Refer [this page](developer-docs/server-installation/plugins){:target="_blank"}

4. After plugins build and deploy, provide the blob url of the plugins zip file in Player build. Refer Player build job on [this page](developer-docs/server-installation/artifactupload-job/core-services){:target="_blank"}

5. Build all the services mentioned in the table below. In case of Cassandra migration (Core / Cassandra), the job needs to be built twice and deployed thrice. Refer to the tags page to get the two tags. Also in case of errors in Cassadnra migration, refer to [this page](developer-docs/server-installation/core-services){:target="_blank"}

Here is the list of jobs that are required to be built and deployed for your reference.

Order: Top down per column

|Knowledge Platform Build |	Knowledge Platform Deploy |	DataPipeline Build | DataPipeline Deploy | Core Build | Core Deploy |
|-------------------------|---------------------------|--------------------|---------------------|------------|------------|
| CassandraTrigger        | CassandraTrigger          |                    |                     |            | OnboardAPIs |
| KnowledgePlatform       | Learning                  |                    |                     |            | Provision/PostgresDbUpdate |
|                         | Provison/CompositeSearch  |	                   | CassandraDbUpdate   | Cassandra | Cassandra |
|  Yarn                   | Yarn          |                    |                     |  | certTemplate |
| SyncTool                | Neo4jElasticSearchSyncTool(Please see below notes to choose jenkins job parameter)	                  |                    | KafkaSetup          | Keycloak  | Keycloak  |                         
|                         |                           |                    |                     |           | ApplicationElasticSearch
|                         | Neo4jDefinitionUpdate 	      |                    | KafkaIndexer        | Player    | OpsAdministration/Core/ESMapping (Provide value as `all` for job parameter indices_name)    |
|                         |                 | Secor              | Secor               | Learner   | Player   |
|                         |          |	Analytics          | AnalyticsAPI        | Content   | Learner   |
|                         |              |                    | Provision/AnalyticsSpark  | Lms       | Content       |
|                         |       | DataPipeline       |	DataProducts       |  | Lms |
|                         | 	                  | Yarn               |	Yarn (Multiselect all options in the job parameter job_names_to_deploy)	             | EncService           | EncService |
|  	                  |                       |                    | AnalyticsGeoLocationDBSetup | Cert           | Cert |


**Note:** 
1. Please refer the below notes to trigger **Neo4jElasticSearchSyncTool** job.
**DialcodeRequired Migration Steps:**
```
Step 1: Get All Identifiers from Neo4j Which need to be migrated.

Query: MATCH(n:domain) WHERE n.IL_FUNC_OBJECT_TYPE="Content" AND n.contentType IN ["TextBook","Course"] return n.IL_UNIQUE_ID;

Step 2: Run Jenkins job with below command.

Command: migrate-dialcodeRequired --ids <comma_seperated_ids fetched from Step:1>

e.g: migrate-dialcodeRequired --ids do_123,do_234
```
   `
