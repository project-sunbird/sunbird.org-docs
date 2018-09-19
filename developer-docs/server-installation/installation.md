---
title: Installation
page_title: Installation
description: Procedure to install Sunbird on server
keywords: install, server installation, install and validate, installation scripts, scripts, 
allowSearch: true
---

## Installation
This section details the procedures to install auxilliary services and to validate the installation

### Installing Auxilliary Services

Run the installation script 

    cd (path to top level folder of folder where the installer is located)
    ./sunbird_install.sh

The installtion script runs through the following steps

|Stage name|Description| 
|:-------|:--------|
|config |Generates configuration file and hosts file |
|dbs|Installs all databases and creates schema  |
|apis|Sets up API manager kong and Onboard API's and consumer's  |
|proxy|Deploys and configures Nginx|
|keycloak| Deploys and configures Keycloak |
|badger|Deploys the badger service|

> Note: The badger service does not work without an Azure storage account name 

### Getting Authentication Certificate

Get the public key from keycloak <b>http://< dns_name or IP>/auth -> Administration console -> realm settings -> keys -> public keys</b>  (click on public keys) and set it for `sunbird_sso_publickey` parameter in `config` file.

### Installing Core Services

To deploy the core services with the authentication certificate, execute:

    ./sunbird_install.sh -s core
     
> Note:
>  - Running the installer script with `-s <stage name>` runs only that stage of the installation.
> 
>  - To know more about the script `sunbird_install.sh` [refer](developer-docs/installation/server_installation/#sunbird-install-script) to the section [below](developer-docs/installation/server_installation/#sunbird-install-script">below)


## Configuring Parameters Post Installation 
After Sunbird is installed and before it can be used, you need to create an API token and a root organization. The API key is used in the REST API commands to authenticate that API calls are made by an authorized user

### Setup

1. **Create user access token** 

Use the following curl commands to generate the x-authenticated-user-token:

> Note: Replace the values in { } braces with values pertinent to your Sunbird environment
   
>  - {host_name} - The Domain or IP address of your application server_installation
>  - {password} - Password of the **user-manager** user. This password is the same as the one you have entered for the **sso_password** parameter in the **sunbird-devops/deploy/config** file 

    curl -X POST {host_name}    /auth/realms/sunbird/protocol/openid-connect/token \
    -H 'cache-control: no-cache' \
    -H 'content-type: application/x-www-form-urlencoded' \
    -d 'client_id=admin-cli&username={user-manager}&password={password}&grant_type=password'

The curl command’s response contains a field **access token** that is followed by a long string. The string is the x-authenticated-user token required to make API calls.


2. **Create root organization** 

Use the following curl commands to create a root organization: 

      curl -X POST  
      {dns_name}/api/org/v1/create \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -H 'accept: application/json' \
      -H 'authorization: Bearer {jwt token from ~/jwt_token_player.txt}' \
      -H 'x-authenticated-user-token: {user x-authenticated-user-token}' \
      -d '{
      "request":{
      "orgName": "{Your Organization Name}",
      "description": "{Your organization description}",
      "isRootOrg":true,
      "channel":"{Your Channel Name}"
            }
         }'

> Note: The channel name should be unique across Sunbird instances using the EkStep content repository
>  - If the **jwt_token_player.txt** file is missing, rerun `./sunbird_install.sh -s apis` to recreate it


3. Update the value of the **sunbird_default_channel** in the **sunbird-devops/deploy/config** file with your Channel Name 

    ./sunbird_install.sh -s core


## Validating the Installed Services

Run the script `./sunbird_install.sh -s posttest` to validate all the successfully installed services

On executing the script, a file `logs/postInstallationLogs.log` is created 


## Sunbird Install Script 

The Sunbird installation script `./sunbird_install.sh` is a wrapper shell script that invokes other scripts or Ansible playbooks. It fetches docker images from the Sunbird DockerHub repository. For details on the 


Signing up on Sunbird is a seamless process. Once you have successfully installed Sunbird on your server, you can create sign up credentials on the portal. For details on signing up on Sunbird, refer <a href="http://www.sunbird.org/features-documentation/signup/" target="_blank">Sign Up on Sunbird</a>

1. Open `https://[domain-name]/` and sign up  

2. Choose your own user name and password. The format for the user name to log in is **username@channelName**
