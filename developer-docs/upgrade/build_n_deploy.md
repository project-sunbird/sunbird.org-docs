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

3. Build and deploy the plugins. For details, refer to the  [Plugins](developer-docs/server-installation/plugins){:target="_blank"} page

4. After the plugins build and deploy, provide the blob url of the plugins zip file in the Player build. For details, refer to the Player build job on the [Core Services](developer-docs/server-installation/artifactupload-job/core-services){:target="_blank"} page.

5. Build all the services mentioned in the table below. Refer to this page for details on tags to be used - Current Release Tags and Jenkins Jobs Reference{:target="_blank"}

The following is the list of jobs required to be built and deployed :

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


> **Note:** 
Refer to the following notes to trigger the **Neo4jElasticSearchSyncTool** jenkins job located under Deploy/KnowledgePlatform directory.

**Steps to migrate DialcodeRequired:**

1. Run the following query on the neo4j VM to get all the identifiers from Neo4j that need to be migrated.

Query: 
```
MATCH(n:domain) WHERE n.IL_FUNC_OBJECT_TYPE="Content" AND n.contentType IN ["TextBook","Course"] return n.IL_UNIQUE_ID;
```
The command returns do IDs. Example - do_11277867981525811215

2. Run the Jenkins job with the following Jenkins parameters.

command: ``` migrate-dialcodeRequired```
parameters: ```--ids <comma_seperated_do_ids fetched from Step:1>```

For details, refer to the following  image:

<img src="../images/elastic_search_tool.png">


Jenkins will not accept more than 50 do id's at once. So in case you have a large number of do id's, then you can follow the below approach for quicker execution. 
1. Run the Jenkins job mentioned above with one or two do id's. This is to just copy the latest jar file into the neo4j machine.
2. SSH into the neo4j machine and execute the below commands
```
sudo su learning
cd /home/learning/sync_tool
java -Dconfig.file=/home/learning/sync_tool/application.conf -jar sync-tool-0.0.1-SNAPSHOT.jar migrate-dialcodeRequired --ids do_112880563104456704117,do_112880563104456704118,do_112880563104456704119
```
In the command line you can specify any number of do id's. Thus if you have large number of do id's, we suggest you run it via the command line for faster execution rathen than running the Jenkins job multiple times in batches of 50 do id's.
