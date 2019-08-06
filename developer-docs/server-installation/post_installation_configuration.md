---
title: Post Installation Configurations
page_title: Post Installation Configurations
description: Explains the configurations to be done post installation
keywords: configuration, post installation
allowSearch: true
---


## Overview

This page provides details on the configuration to be done, after you complete installation of Sunbird. The configurations mentioned in this page are the basic requirements to do any other configuration as mentioned in the **Sever Configuration** section. Execute the configurations in the sequence mentioned on the page.    


## Create User Access Token

To create a user access token use the following cURL command: 

   
      `curl -X POST {dns_name}/auth/realms/sunbird/protocol/openid-connect/token \
      -H 'cache-control: no-cache' \
      -H 'content-type: application/x-www-form-urlencoded' \
      -d 'client_id=admin-cli&username=user-manager&password={password}&grant_type=password'

      `
Replace the values within { } braces with your environment values.

| **Variable Name**| **Description**|
|------------------|----------------|
|{dns_name} |Domain or the IP address of your application server installation|
|{password} |Password of the `user-manager` user. The password is same as the value of the `sso_password` parameter in the Config file|

## Create root organization
To create a root organization use the following cURL commands: 

      `curl -X POST  \
      {dns_name}/api/org/v1/create \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -H 'accept: application/json' \
      -H 'authorization: Bearer {jwt token from ~/jwt_token_player.txt}' \
      -H 'x-authenticated-user-token: {access token created last step}' \
      -d '{
      "request":{
      "orgName": "{Your Organization Name}",
      "description": "{Your organization description}",
      "isRootOrg":true,
      "channel":"{Your Channel Name}"
      }
      }'`

Replace the values within { } braces with your environment values.

## Update System Setting

The Sunbird instances that use the EkStep content repository must have a unique channel name in the [System Setting](developer-docs/server-configurations/system_settings)file.
   
1.Update the **Channel Name** in the `sunbird_default_channel` variable in the [config]() file. 

2.Run the following commands 

      `./sunbird_install.sh -s core`

      `./sunbird_install.sh -s posttest`    //Validates all the services.
   
3.After the sript is successfully executed, it creates the **postInstallationLogs.log** file in the **logs** directory. 

4.Open **https://[domain-name]** and sign-up.

5.You can choose your own user name and password. The format for the username is: username@channelName 
