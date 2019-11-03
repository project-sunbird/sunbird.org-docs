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


## Load Balancer Setup for Swarm Manager 

>This is optional setup for the Sunbird upgrade

To setup the load balancer for swarm managers, execute the following instructions for each of the mentioned fields:
- Frontend IP configuration - Internal IP (default)
- Backend pools - Attach swarm manager VM or availability set of swarm manager group
- Health Probes/check - Configure path and port
       ->   api-manager-kong - 8001 - /status
       ->   content-service  - 5000 - /health
       ->   learner-service  - 9000 - /health
- Protocol: HTTP
- Port:
       ->   api-manager-kong - 8000
       ->   content-service  - 5000
       ->   learner-service  - 9000
- Interval: 5
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config, Frontend-port, backend-port, Backend-pool and health-probe
       ->   api-manager-kong - Frontend-port:8000 - Backend-port: 8000
       ->   content-service  - Frontend-port:5000 - Backend-port: 5000
       ->   learner-service  - Frontend-port:9000 - Backend-port: 9000

## Running the Builds 

**IMPORTANT**: 

1. Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs 
OR 
you can use the VM Disk snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy the services.

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

