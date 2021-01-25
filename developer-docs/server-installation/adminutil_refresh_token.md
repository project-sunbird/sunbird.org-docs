---
title: Adminutil refresh token creation
page_title: Adminutil refresh token creation
description: Steps to get the adminutil refresh token
keywords: Adminutil refresh token creation
allowSearch: true
--- 

## Overview

After creating the LMS client in Keycloak, use the LMS client and secret to generate a Keycloak token for a user.
 

## Creating the Adminutil refresh token

1.After LMS client is created in Keycloak, use the LMS client and secret to generate the user access token using the following command:

```
   curl --location --request POST 'https://<domain name>/auth/realms/sunbird/protocol/openid-connect/token' \
   --header 'Content-Type: application/x-www-form-urlencoded' \
   --data-urlencode 'client_id=lms' \
   --data-urlencode 'client_secret=<LMS CLIENT SECRET>' \
   --data-urlencode 'grant_type=client_credentials'

```

2.Copy the access token from the output of the command .

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
