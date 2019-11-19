---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, Core, elasticsearch
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 2.0.0 to release 2.3.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. 

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
|                         | Provison/CompositeSearch  |	                   | CassandraDbUpdate   | Cassandra | Cassandra |
|                         | StopNeo4jCluster          |                    |                     | CassandraTrigger | CassandraTrigger |
|                         | Neo4j	                  |                    | KafkaSetup          | Keycloak  | Keycloak  |                         
|                         |                           |                    |                     |           | ApplicationElasticSearch
|                         | StartNeo4jCluster	      |                    | KafkaIndexer        | Player    | OpsAdministration/Core/ESMapping (Provide value as all for job parameter indices_name)    |
|                         | KafkaSetup                | Secor              | Secor               | Learner   | Player   |
|                         | CassandraDbUpdate         |	Analytics          | AnalyticsAPI        | Content   | Learner   |
|                         | CassandraTrigger          |                    |                     | Lms       | Content       |
| CassandraTrigger        | Neo4jDefinitionUpdate     | DataPipeline       |	DataProducts       | Telemetry | Lms |
| KnowledgePlatform       |	Learning                  |                    | SamzaTelemetrySchemas | Proxy   | Telemetry     |
|                         | Search	                  | Yarn               |	Yarn (Multiselect all options in the job parameter job_names_to_deploy)	             |           | OnboardAPI|
|  Yarn	                  | Yarn                      |                    |                     |           | Proxy |
|  SyncTool               | Neo4jElasticSearchSyncTool|                    |                     |           | OnboardConsumers   |


**Note:** 
1. We have disabled Git LFS for private repositories. Hence, uninstall git lfs from your private repository.
To do so, clone your private repository and run ```git lfs uninstall``` and also remove the ```.gitattributes``` file

2. If the Cassandra migration fails, run the query manually to set the corresponding version for the failed migration to True 

**Example:**

`SELECT * from cassandra_migration_version;`

Check the rows for which the value in the success column is False. The following is an example -

`1.74 |   180685665 |   cassandra |              4 |         null | 2019-09-17 13:58:52.401000+0000 |            136 | V1.74_cassandra.cql |   False |  CQL |           73`

Run the update query for each row separately 

`UPDATE cassandra_migration_version set success=True where version='1.74';`

Verify that all the values in the success column are True and rerun the Jenkins job again with same zip file and tag

Once this succeeds, use the second zip file and tag to deploy again

The current migration version is 1.83. The output of the Jenkins job should be as follows -

`Migrating keyspace Sunbird to version 1.83 - Cassandra
Successfully applied 3 migrations to keyspace sunbird (execution time 00:20.547s).
Migration Completed at ==1571996508540`
