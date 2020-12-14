---
title: Adminutil refresh token creation
page_title: Adminutil refresh token creation
description: Steps to get the adminutil refresh token
keywords: Adminutil refresh token creation
allowSearch: true
--- 

## Overview

After lms client is created in keycloak, use the lms client and secret to generate a keycloak token for a user
 

## Steps to create Adminutil refresh token

1.After lms client is created in keycloak, use the lms client and secret to generate user access token. 

```
   if public nginx is deplyed and mapped Domain name for the public ip, use the domain  name in curl command:
   
   curl --location --request POST 'https://<domain name>/auth/realms/sunbird/protocol/openid-connect/token' \
   --header 'Content-Type: application/x-www-form-urlencoded' \
   --data-urlencode 'client_id=lms' \
   --data-urlencode 'client_secret=<LMS CLIENT SECRET>' \
   --data-urlencode 'grant_type=client_credentials'

   else use the keycloak ip:

   curl --location --request POST 'http://<keycloak ip>:8080/auth/realms/sunbird/protocol/openid-connect/token' \
   --header 'Content-Type: application/x-www-form-urlencoded' \
   --header 'x-forwarded-scheme: https' \
   --header 'x-forwarded-proto: https' \
   --header 'HOST: <DOMAIN NAME>' \
   --data-urlencode 'client_id=lms' \
   --data-urlencode 'grant_type=client_credentials' \
   --data-urlencode 'client_secret=<LMS CLIENT SECRET>'

```

2.copy the access_token from the above command output.

```
   Go to jwt.io website.
   look for the "kid" value in header section by pasting the access or refresh token in jwt.io website
   
   Sample output below in jwt.io site.
      {
         "alg": "RS256",
         "typ": "JWT",
         "kid": "yhgfresdghkouyjmkjhgfdwetxnwetyioxsefp"
      }

   copy the kid value add it in Core/secrets.yml
   Sample variable value update in inventory:
   adminutil_refresh_token_public_key_kid: "yhgfresdghkouyjmkjhgfdwetxnwetyioxsefp"
   
```