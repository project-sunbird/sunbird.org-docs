---
title: Create user auth token
page_title: Create user auth token
description: creating user auth token to access sunbird api's
keywords: user token, user auth token,x-authenticated-user-token 
published: true
allowSearch: true
---
## Scenario

TO access sunbird api , caller need to provide 'x-authenticated-user-token' header value. Caller need to generate this token.

### Prerequisites

1. keycloak server need to up and running



**Header Parameters**

|     Header    |          Type          | Description                | Sample           |
|---------------|------------------------|----------------------------|------------------|
| Content-type  | String                 | Mime type of the request   | application/x-www-form-urlencoded  |



#### Request Body

  curl -X POST \
  {baseUrl}/auth/realms/{realm}/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'client_id={client}&username={username/email}&password={userpassword}&grant_type=password'



#### Response Body

> Example

    {
    "access_token": "this token value need to be picked and passed as x-authenticated-user-token value",
    "expires_in": 14400,
    "refresh_expires_in": 14400,
    "refresh_token": "",
    "token_type": "bearer",
    "not-before-policy": 1565356374,
    "session_state": "61e68846-e2b1-4f60-bad3-77406293fa02"
}

