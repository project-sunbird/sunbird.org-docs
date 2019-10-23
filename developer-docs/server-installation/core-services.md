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

| Build Name | Function |
|--------------------|-----------| 
| Adminutils | Builds the Adminutils docker image |
| API MANAGER | Builds the API manager docker image | 
| API MANAGER Echo | Builds the API manager echo docker image | 
| Badger | Builds the badger docker image |
| Cassandra | Creates a jar for migration |
| Lms | Builds  the lms service docker image |
| Content | Builds the content service docker image | 
| Learner | Builds the learner service docker image | 
| Player | Builds the player service docker image |
| Proxy | Builds the proxy docker image |  
| Telemetry | Builds the telemetry docker image |

### Artifacts  
Ensure that all Artifacts are uploaded

### Provision

| Operation Name | Function |
|--------------------|-----------| 
| (Deploy) ApplicationES | From the Deploy Folder, **Deploy ApplicationES** provisions for the Elasticsearch and creates indices necessay for Sunbird Core|
| ESMapping (Under OpsAdministarion. Provide value as all for job parameter indices_name) | Creates Elasticsearch indexes |
| Postgres | Provisions for Postgres |
| PostgresDbUpdate | Creates the databases, assigns roles and creates users |
| LogEsUpgrade6xx | Install elasticsearch 6.X |

### Deploy

| Operation Name | Function |
|--------------------|-----------| 
| Adminutil | Deploys the Adminutil container | 
| API Manager | Deploys the API manager Kong and API manager Echo | 
| OnboardAPIS | Onboards all API's to Sunbird | 
| OnboardConsumers 
Update **core_vault_sunbird_api_auth_token** with the **jwt token** from the Jenkins output of **api-management-test-user** if you are using the Knowledge Platform and Data Pipeline along with core| Onboards new consumer to Sunbird and generates the consumer sprcific API key. Update this value with the corresponding API key of Ekstep 'core_vault_ekstep_api_key'. |   
| (Provision) Cassandra | Provisions Cassandra and create keyspaces required for Sunbird Core | 
| Cassandra | Does Migration if required | 
| (Provision) Keycloak | Provisions Keycloak by installing prerequisites like java and environment variables of learner | 
| Keycloak | Deploys Keycloak service to VM |  
| Proxy | Deploys Proxy. Handles routing within the swarm |  
| KeycloakRealm | Creates Sunbird Realm. After the Sunbird realm is created, configure Keycloak by using the steps mentioned in the **Keycloak Configuration** section. |
| PlayerCDN | It is a optional job, CDN will increase the performance of web page and content to end user. Create cdn with storage account and update **sunbird_portal_cdn_url** variable and in jenkins job parameter **cdn_enable** set it to true. It will upload player static contents to CDN storage account | 
| Player | Deploys the player service, used to display the App frontend. **Note**: The player deployment job will fail for the first time. Jenkins prompts you for **In process Approval Script**. Click on the approval link in the deploy job page and provide explicit approval for new **java.io** file, **java.lang** string and **java.io** file. Run the Player deployment again.|
| Learner | Deploys the Learner Service. Handles user management and helps to search content. |
| Lms | Deploys the Lms Service. It provides the APIs for lms functionality of Sunbird.|
| Content | Deploys the content service. Helps to create content. |  
| Telemetry | Deploys the Telemetry service. Helps in sending telemetry to Kafka|


### Keycloak Configuration 

> Note: From release-2.0.0 keycloak admin portal is disabled from public internet. 
You must tunnel the port in to the local machine via ssh tunnelling.  
`ssh -L 8080:localhost:8080 ops@~keycloak-ip-address~`  
You can access keycloak via `localhost:8080`

| Step | Action  |
|------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | Login to Keycloak using the user name **admin** and password as given in the private **secrets.yml** file. Or, login to keycloak using &#60;localhost:8080&#62;/auth |           
| 2 | Navigate to Sunbird Realm > Realm Settings > Keys. Click `Public Key`. Copy the key value that you see and update the variable core_vault_sso_public_key |
| 3 | Create the admin role in the Sunbird realm. Navigate to Roles > Add Role > Add details in the form. Specify the role name as `admin`. Click **Save**. Navigate to **Enable Composite Roles**. Under **Composite Roles**, select **offline_access**, **uma_administration** and click **Add selected**. Navigate to **Permissions** and enable permissions.|
| 4 | Assign permissions to the **admin-cli** client in the Sunbird realm. Navigate to **clients** > **admin-cli** > **Settings** > **Implicit Flow Enabled (ON)** > **Root URL**: [https://dev.sunbird.cf](https://dev.sunbird.cf) (your Domain) > Valid Redirect URIs: [https://dev.sunbird.cf/*](https://dev.sunbird.cf/*).  Add another link by clicking **+**. Navigate to **Valid Redirect URIs**: [https://dev.sunbird.cf/](https://dev.sunbird.cf/) > Base URL: / > Admin URL: [https://dev.sunbird.cf/*](https://dev.sunbird.cf/*)** and click **Save**. |
| 5 | In the Sunbird realm, navigate to **Clients** > **admin-cli** > **Roles** > **Add Role**. Enter the role name as **admin** and click **Save**. Navigate to **Composite Roles** and switch the toggle button to ON. Navigate to **Composite Roles > Realm Roles** and  add **admin**, **offline_access** and, **uma_authorization**. Navigate to **Permissions > Permissions Enabled** and switch the toggle to ON.|
| 6 | Creating keycloak federation [Deployment Steps for Keycloak User Federation](developer-docs/server-installation/keycloak_user_federation) |

