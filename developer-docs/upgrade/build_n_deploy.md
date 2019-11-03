---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, Core, elasticsearch
---

## Overview


**IMPORTANT**: 

1. Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.

3. Build and deploy plugins. Refer [this page](developer-docs/server-installation/plugins){:target="_blank"}

4. After plugins build and deploy, provide the blob url of the plugins zip file in Player build. Refer Player build job on [this page](developer-docs/server-installation/artifactupload-job/core-services){:target="_blank"}

5. Build all the services mentioned in the table below. In case of Cassadnra migration (Core / Cassandra), the job needs to be build twice and deployed twice. Refer to the tags page to get the two tags. Also in case of errors in Cassadnra migration, refer to [this page](developer-docs/server-installation/artifactupload-job/core-services){:target="_blank"}

Here is the list of jobs that are required to be built and deployed for your reference.

Order: Top down per column

|Knowledge Platform Build |	Knowledge Platform Deploy |	DataPipeline Build | DataPipeline Deploy | Core Build | Core Deploy |
|-------------------------|---------------------------|--------------------|---------------------|------------|------------|
|                         | Provison/CompositeSearch  |	                   | CassandraDbUpdate   | Cassandra | Cassandra |
|                         | StopNeo4jCluster          |                    |                     |           | ApplicationElasticSearch |
|                         | Neo4j	                    |                    | KafkaSetup     	   | Keycloak  | Keycloak  |
|                         | StartNeo4jCluster	        |                    | KafkaIndexer    	   | Player    | Player    |
|                         | KafkaSetup                | Secor              | Secor               | Learner   | Learner   |
|                         | CassandraDbUpdate         |	Analytics          | AnalyticsAPI        | Content   | Content   |
|                         |                           |                    |                     | Lms       | Lms       |
|                         | Neo4jDefinitionUpdate     | DataPipeline       |	DataProducts       | Telemetry | Telemetry |
| KnowledgePlatform       |	Learning                  |                    | SamzaTelemetrySchemas | Proxy   | Proxy     |
|                         | Search	                  | Yarn               |	Yarn (Multiselect all options in the job parameter job_names_to_deploy)	             |           | OnboardAPI|
|  Yarn	                  | Yarn                      |                    |                     |           | OnboardConsumers |
|  SyncTool               | Neo4jElasticSearchSyncTool|                    |                     |           | OpsAdministration/Core/ESMapping (Provide value as all for job parameter indices_name)   |
|                         |                           |                    |                     |           | Logging


Optional:

You can run the Logging job if required which is located under Core → Deploy → Logging
The Logging jobs will provision Kibana and provide you access to container logs. But this will consume additional resources in your Swarm machines and we do not recommend to run this job if you have a two node swarm cluster.
