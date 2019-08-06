---
title: Build and Deploy
page_title:  Build and Deploy
description:  Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0, Core, elasticsearch
---

## Overview


**IMPORTANT**: Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider
Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.
Build all the services mentioned in the table below.
Ensure you provide the `github_release_tag` for Build jobs as per the tags mentioned in the sheet - [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs).
Ensure all ArtificatUpload Jobs as successful.
Deploy services which are mentioned in the table below. **IMPORTANT**: The order of deployment for jobs in deploy directory should be same as mentioned in the below table.
If some build and deploy jobs are not relevant to your setup, you can skip them.
Ensure you provide branch_or_tag as per the data mentoined in this sheet - [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs) under Jobs which use this repository column.
Once all services are deployed, please perform the manaual configurations mentioned in this sheet - [Manual configurations](developer-docs/upgrade/manual_configuration)


Optional:

You can run the Logging job if required which is located under Core → Deploy → Logging
The Logging jobs will provision Kibana and provide you access to containr logs. But this will consume additional resources in your Swarm machines and we do not recommend to run this job if you have a single swarm machine.


Here is the list of jobs that are required to be built and deployed for your reference

Order: Top down per column

|Knowledge Platform Build |	Knowledge Platform Deploy |	DataPipeline Build | DataPipeline Deploy | Core Build | Core Deploy |
|-------------------------|---------------------------|--------------------|---------------------|------------|------------|
|                         | StopNeo4jCluster          |	                   | CassandraDbUpdate   | Cassandra | Cassandra |
|                         | Neo4j	                  |                    | KafkaSetup     	 | Keycloak  | Keycloak  |
|                         | StartNeo4jCluster	      |                    | KafkaIndexer    	 | Player    | Player    |
|                         | KafkaSetup                | Secor     	       | Secor               | Learner   | Learner   |
|                         | CassandraDbUpdate         |	Analytics          | AnalyticsAPI        | Content	 | Content   |
|                         |Neo4jDefinitionUpdate <br>(Run manual queries mentioned below after this job)| DataPipeline |	DataProducts |	Telemetry |	Telemetry |
| KnowledgePlatform       |	Learning                 |                    | SamzaTelemetrySchemas | Proxy  |	Proxy  |
|                         | Search	                 | Yarn               |	Yarn	     |                 |           |
|                         | OnboardAPI               | Yarn	              | Yarn           |               |          |
|                         | OnboardConsumers         |  SyncTool          | Neo4jElasticSearchSyncTool | | | Logging |


### Manual queries to be run for Neo4j

        Login to neo4j machine and switch to learning user
        Go to NEO4J_HOME/bin directory
        Run ./cypher-shell
        Execute the below queries

        `match (n:domain) where n.IL_FUNC_OBJECT_TYPE in [“Content”, “ContentImage”] AND exists(n.medium) set n.medium = [n.medium];`

        `match (n:domain) where n.IL_FUNC_OBJECT_TYPE in [“Content”, “ContentImage”] AND exists(n.subject) set n.subject = [n.subject];`

        `match (n:domain{}) WHERE exists(n.sYS_INTERNAL_LAST_UPDATED_ON) remove n.sYS_INTERNAL_LAST_UPDATED_ON;`