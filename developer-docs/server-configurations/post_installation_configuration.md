---
title: Post Installation Configurations
page_title: Post Installation Configurations
description: Explains the configurations to be done post installation
keywords: configuration, post installation
allowSearch: true
---


## Post Installation Configuration

1. **Create user access token** - To create a user access token execute the following cURL: 

   
      `curl -X POST {dns_name}    /auth/realms/sunbird/protocol/openid-connect/token \
      -H 'cache-control: no-cache' \
      -H 'content-type: application/x-www-form-urlencoded' \
      -d 'client_id=admin-cli&username=user-manager&password={password}&grant_type=password'

      `
The values in the { } braces should be replaced with your environment values
   
   - {dns_name} - Domain or the IP address of your application server_installation

   - {password} - Password of the `user-manager` user. The password is same as the one you provided for `sso_password` parameter in the [Config]() file

2. **Create root organization** - To create a root organization use the following cURL commands: 

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


3. **Update System setting**- The Sunbird instances that are using the EkStep content repository must have a unique channel name in [system setting](./system_settings.md)

   
4. Update **Channel Name** in `sunbird_default_channel` variable in the [config]() file. Run the following commands 

      `./sunbird_install.sh -s core`

      `./sunbird_install.sh -s posttest`    //Validates all the services.
   
5. After successful execution of the script, a file **postInstallationLogs.log** in the **logs** directory is created 

6. Open **https://[domain-name]** and sign-up  

7. You can choose your own user name and password. The format for the username is: username@channelName 