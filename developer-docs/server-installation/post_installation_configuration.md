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


**Create License and update Channel default License set and Content License migration based on channel**

1.Run the following script on the content service to create License .
 
```
#!/bin/bash
echo "License name: $1"
echo "License descripition: $2"
echo "License url: $3"
curl -X POST \
  http://localhost:9000/license/v3/create \
  -H 'Content-Type: application/json' \
  -d '{
    "request":{
        "license":{
            "name": "'"$1"'",
            "description": "'"$2"'",
            "url": "'"$3"'"
        }
    }
}'
```


Run these commands
sh -x create_license CC\ BY-NC-SA\ 4.0 This\ license\ is\ Creative\ Commons\ Attribution-NonCommercial-ShareAlike https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
sh -x create_license CC\ BY-NC\ 4.0 This\ license\ is\ Creative\ Commons\ Attribution-NonCommercial  https://creativecommons.org/licenses/by-nc/4.0/legalcode
sh -x create_license CC\ BY-SA\ 4.0 This\ license\ is\ Creative\ Commons\ Attribution-ShareAlike https://creativecommons.org/licenses/by-sa/4.0/legalcode
sh -x create_license CC\ BY\ 4.0 This\ is\ the\ standard\ license\ of\ any\ Youtube\ content https://creativecommons.org/licenses/by/4.0/legalcode
sh -x create_license Standard\ YouTube\ License This\ license\ is\ Creative\ Commons\ Attribution-NonCommercial-ShareAlike https://www.youtube.com/
```

2.Run the above script from learning server to update the Channel-default license .  

```
Copy below code and save file name as channel_license.sh
#!/bin/bash
echo "Channel Id: 0132167222260449280"
echo "Default License: CC BY-NC 4.0"
IFS=,
curl -X PATCH \
"http://localhost:8080/channel/v3/update/"$1 \
-H 'Content-Type: application/json' \
-d '{
   "request": {
      "channel": {
        "defaultLicense":"'"$2"'"
      }
    }
}'

Run the Command
./channel_license.sh <channle_Id> <license_name>

license_name can be choosen from the list which was created in the 1st Step.
```

3.Update content with channel specific default license, Run the below query in neo4j

```
match (n:domain{}) WHERE n.IL_FUNC_OBJECT_TYPE IN ["Content", "ContentImage"] AND n.channel="<channel id>" AND n.license<>"Standard YouTube License" SET n.license="<channel defaultLicense>";
```
