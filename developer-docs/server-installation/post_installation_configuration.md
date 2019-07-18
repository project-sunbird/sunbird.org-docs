---
title: Configurations Post Installation
page_title: Configurations Post Installation
description: Explains the configurations to be done post installation
keywords: configuration, post installation
allowSearch: true
---


# Post Installation Configuration

1. **Create user access token** - To create a user access token you should execute the following cURL: 

   <pre>
   curl -X POST {dns_name}    /auth/realms/sunbird/protocol/openid-connect/token \
   -H 'cache-control: no-cache' \
   -H 'content-type: application/x-www-form-urlencoded' \
   -d 'client_id=admin-cli&username=user-manager&password={password}&grant_type=password'
   </pre>

   <br>The values in the { } braces should be replaced with your environment values
   
   - {dns_name} - Domain or the IP address of your application server_installation
   - {password} - Password of the `user-manager` user. The one you have provided for `sso_password` parameter in the `config` file above

2. **Create root organization** - To create a root organization you should the following cURL: 

   <pre>
   curl -X POST  \
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
    }'
    </pre>

      **Note:** Channel should be a unique name across Sunbird instances who are using the EkStep content repository
    
3. Update `sunbird_default_channel` in the `config` file with **Your Channel Name}** (that was created in previous step) and re-run the command `./sunbird_install.sh -s core`

4. Run `./sunbird_install.sh -s posttest`, to validate all the services for a successful installation. On executing the script, a file **postInstallationLogs.log** in the **logs** directory will be created 

5. Open **https://[domain-name]** and sign up  

6. You may choose your own user name and password. The format for the username while login is: username@channelName 
