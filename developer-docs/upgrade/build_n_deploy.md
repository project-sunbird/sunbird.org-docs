---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, Core, elasticsearch
---

**New load balancer setup for Swarm manager**

(Optional - Refer the variable sunbird_swarm_manager_lb_ip in inventory for comments)


To setup LB for Swarm managers, execute the following instructions for each of the mentioned fields:
- Frontend IP configuration - Internal IP (default)
- Backend pools - attach swarm manager VM or availability set of swarm manager group
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

**IMPORTANT**: 

1.Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.

3. Build all the services mentioned in the table below.
Here is the list of jobs that are required to be built and deployed for your reference.

Order: Top down per column

|Knowledge Platform Build |	Knowledge Platform Deploy |	DataPipeline Build | DataPipeline Deploy | Core Build | Core Deploy |
|-------------------------|---------------------------|--------------------|---------------------|------------|------------|
|                         | StopNeo4jCluster          |	                   | CassandraDbUpdate   | Cassandra | Cassandra |
|                         | Neo4j	              |                    | KafkaSetup     	 | Keycloak  | Keycloak  |
|                         | StartNeo4jCluster	      |                    | KafkaIndexer    	 | Player    | Player    |
|                         | KafkaSetup                | Secor              | Secor               | Learner   | Learner   |
|                         | CassandraDbUpdate         |	Analytics          | AnalyticsAPI        | Content | Content   |
|                         |                           |                    |                     | Lms     | Lms         |
|                         |Neo4jDefinitionUpdate <br>(Run manual queries mentioned below after this job)| DataPipeline |	DataProducts |	Telemetry |	Telemetry |
| KnowledgePlatform       |	Learning              |                    | SamzaTelemetrySchemas | Proxy   |	Proxy    |
|                         | Search	              | Yarn               |	Yarn	     |               |OnboardAPI |
|  Yarn	                  | Yarn           |               |          |                         | OnboardConsumers    |
|  SyncTool               | Neo4jElasticSearchSyncTool |                   |                    | Logging |


Optional:

You can run the Logging job if required which is located under Core → Deploy → Logging
The Logging jobs will provision Kibana and provide you access to container logs. But this will consume additional resources in your Swarm machines and we do not recommend to run this job if you have a single swarm machine.
