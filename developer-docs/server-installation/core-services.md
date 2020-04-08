---
title: Core Services
page_title: Core Services
description: Explains how to create schemas for Core service objects
keywords: core services, services
allowSearch: true
---

## Overview
This page explains the jobs to be run to bring up the Core services. 

## Prerequisites

1.Create a container in the Azure blob and make it public to publish content. The container name must be the same as the variable **sunbird_content_azure_storage_container** specified in the **common.yml** file present in the core inventory.

2.Switch to the `Build` folder and run all jobs. Set the value for **github_release_tag** according to the details mentioned in this page - [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

## Running the Jobs
    
> Note: Adhere to the following sequence when running the jobs.

### DevOps Administration

| Operation Name | Function |
|--------------------|-----------| 
| Bootstrap | Creates Deployer User | 
| SwarmBootstrap | Creates Swarm with manager and agent nodes |

### Builds

| Build Name | Function (Builds) |
|--------------------|-----------| 
| Adminutils | Adminutils docker image |
| API MANAGER | API manager docker image | 
| API MANAGER Echo | API manager echo docker image | 
| Badger | Badger docker image |
| Cassandra | Jar for migration|
| CassandraTrigger | Cassandra trigger jar file |
| Lms | LMS service docker image |
| Content | Content service docker image |  
| KnowledgeMW | Knowledge-mw service docker image |  
| Learner | Learner service docker image | 
| Player | Player service docker image. In the build job, you have 3 parameters which point to plugins. Provide the values of your blob URL where the zip files are uploaded. For details refer [Plugins build page](developer-docs/server-installation/plugins){:target="_blank"} |
| Cert | Cert service docker image |
| EncService | Envservice docker image |
| Proxy | Proxy docker image |  
| Telemetry | Telemetry docker image |

### Artifacts  
Ensure that all Artifacts are uploaded

### Provision

| Operation Name | Function | Description |
|--------------------|-----------|---------|
| (Deploy) ApplicationES |  Provisions Elasticsearch 6.2.3 version used by core services | From the Deploy Folder, **Deploy ApplicationES** provisions for the Elasticsearch and creates indices necessary for Sunbird Core|
| ESMapping (Under OpsAdministarion. Provide the value as *all* for job parameter indices_name) | Creates Elasticsearch indexes | Create the specific index with its mapping or all indices which will be used by our sunbird app |
| Postgres | Provisions for Postgres | Provisions the Postgres instance |
| PostgresDbUpdate | Creates the databases, assigns roles and creates users | Creates a schema with DB's, Tables |
| LogEsUpgrade6xx | Installs elasticsearch 6.X | Provision logger elasticsearch to store our application log data for visualisation using kibana |

### Deploy

| Operation Name | Function | Description |
|------|------|---------------------------------| 
| Adminutil | Deploys the Adminutil container | Creates tokens for the sunbird devices | 
| API Manager | Deploys the API manager Kong and API manager Echo | Manages consumers and APIs of sunbird |
| OnboardAPIS | Onboards all API's to Sunbird | onboards sunbird API's |
| OnboardConsumers | Onboards sunbird consumers |onboards sunbird consumers |
Update **core_vault_sunbird_api_auth_token**, **core_vault_kong__test_jwt** and **core_vault_sunbird_ekstep_api_key** with the **jwt token** from the Jenkins output of **api-management-test-user** if you are using the Knowledge Platform and Data Pipeline along with core| Generates user specific key |  Onboards new consumer to Sunbird and generates the consumer specific API key | 
| (Provision) Cassandra | Provisions Cassandra and create keyspaces required for Sunbird Core | Provisions Cassandra and creates keyspaces and performs migration |
| Cassandra | Performs keyspace schema migration | Performs migration if required. Deploy this thrice by choosing different zip files using the build_number parameter. Ensure that you get a success message for the Cassandra migration on the Jenkins console output. Do not rely only on the red or green status indicator on Jenkins job | 
| CassandraTrigger | Jars for Cassandra | Deploys trigger jars for Cassandra |
| (Provision) Keycloak | Install dependencies for keycloak | Provisions Keycloak by installing prerequisites like Java and environment variables |  
| PlayerCDN | Uploads player CDN assets |  If you do not want to use CDN, run this job with Jenkins job parameter **cdn_enable** set to false (default). CDN  increases the performance of the web page and content for the end-user. Create CDN with the storage account and update the variable **sunbird_portal_cdn_url**. Set the Jenkins job parameter **cdn_enable** to true. This upload player static contents to CDN storage account  |
| Player |  UI for sunbird  | Deploys portal UI |
| Proxy | Deploys Proxy | Handles routing within the swarm, redirection and routing management |
| Keycloak | Deploys Keycloak service to VM | Centralized user management for sunbird | 
| KeycloakRealm |  User management -Creates sunbird realm | Creates a Sunbird Realm. After the Sunbird realm is created, configure Keycloak by using the steps mentioned in the **Keycloak Configuration** section |
| Learner | Deploys the Learner Service |  Handles user management and helps to search content | 
| Content | Deploys content service | Helps to create content |
| KnowledgeMW | Deploys knowledgemw service | Deploys the knowledgemw service | 
| Lms | Deploys LMS Service | Provides the APIs for LMS functionality of Sunbird| 
| certTemplate | Deploys template required for signing certificate | Creates a sample template for generating certificates |
| EncService | Deploys enc service | Encrypts and decrypt the keys to generate certificate |
| Cert | Deploys cert services | Issues certificates |
| Telemetry | Aggregates and send telemetry data to kafka | Telemetry management service|

### Keycloak Configuration 

> Note: From release-2.0.0 keycloak admin portal is disabled from public internet. 
You must tunnel the port in to the local machine via ssh tunnelling.  
`ssh -L 8080:localhost:8080 ops@~keycloak-ip-address~`  
You can access keycloak via `localhost:8080`

| Step | Action  |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | Login to Keycloak using the user name **admin** and password as given in the private **secrets.yml** file. Or, login to keycloak using &#60;localhost:8080&#62;/auth |
| 2 | Navigate to Sunbird Realm > Realm Settings > Keys. Click `Public Key`. Copy the key value that you see and update the variable core_vault_sso_public_key |
| 3 | Creating keycloak federation [Deployment Steps for Keycloak User Federation](developer-docs/server-installation/keycloak_user_federation) |


**Note:**
If the Cassandra migration fails, run the query manually to set the corresponding version for the failed migration to True

**Example:**

`SELECT * from sunbird.cassandra_migration_version;`

Check the rows for which the value in the success column is False. The following is an example -

`1.80 |   180685665 |   cassandra |              4 |         null | 2019-12-01 13:58:52.401000+0000 |            136 | V1.80_cassandra.cql |   False |  CQL |           80`

Run the update query for each row separately 

`update sunbird.cassandra_migration_version set success=True where version ='1.80';`

Verify that all the values in the success column are True and rerun the Jenkins job again with same zip file and tag

Once this succeeds, use the second zip file and tag to deploy again

The current migration version is 1.88. The output of the Jenkins job should be as follows -

`Migrating keyspace Sunbird to version 1.88 - Cassandra
Successfully applied 3 migrations to keyspace sunbird (execution time 00:20.547s).
Migration Completed at ==1571996508540`