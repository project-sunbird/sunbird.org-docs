---
title: Create Users
page_title: Create Users
description: creating new users in an organization in a sunbird instance
keywords: create users, new users in sunbird, users, create
published: true
allowSearch: true
---

## Scenario

A company, XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 5 locations. Employee training and enablement is one of the core values of the organization. To ensure that employees are regularly trained and upskilled, XYZ Corp has decided to use Sunbird for its learning and training solution on 3 topics, namely Life Science, eCommerce and Archeology (Indian, Greek, Mayan). 
Gita is the XYZ Corp's Sunbird adminstrator and has created the necessary structure (root organization called Archeology and sub-organizations - Indian Archeology, Mayan Archeology and Greek Archeology). She needs to create user(s) within this root organization and assign specific roles such as write research articles, review, publish.

### Prerequisites

1. An intialized Sunbird instance with channel

2. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)
  
3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

4. Access to [User API](apis/userapi/#operation/Create%20User)

5. The root organization is already created and its **channel** is readily available

6. The list of users who need to be populated into the organization alongwith their email addresses. In the absence of an email address, a phone number is a must

### Taskflow

For each user to be created, Gita needs to prepare the API request headers and body, as shown in the example below and invoke the API. Upon successful completion, she notes down the **userID** of each one respectively.

**Request Header**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|-----------|--------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | Authorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |

#### Request Body 

    curl -X POST \
    https://staging.open-sunbird.org/api/user/v1/create \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -d '{
            "request":
            {
            "email": "writer01@xyzcorp.com",
            "firstName": "writer01",
            "password": "writer12301",
            "channel": "xyzCorpLifeArcheologyChannel",
            "emailVerified": true
            }
        }'

#### Response Body

    {
        "id": "api.user.create",
        "ver": "v1",
        "ts": "2018-11-12 16:25:43:292+0000",
        "params": {
            "resmsgid": null,
            "msgid": "93cd9372-62aa-43dd-91a0-fe43db2c218b",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS",
            "userId": "bd25215d-663e-4c78-49ef-4c2331e814cd"
        }
    }

This concludes the topic of creating users in an organization, in a Sunbird instance. Typically, the next activity would be to assign roles to these users, within their organizations.

### Concepts Covered

**User**: These are entities created within an organization, who can login into their Sunbird portal and perform tasks that are specifically assigned to them. Users cannot have the same email ID. In the absence of an email ID, a unique phone number must be provided in the request header and **phoneVerified** must be set to the boolean value **true**.

During user creation, if the **channel** is not provided, Sunbird attempt to create that user in the existing default organization. If that happens, then the user needs to be explicitly added to the required organization via the [Add a User to Organization]() API.

### Related Topics

[Creating Organization](developer-docs/how-to-guide/how_to_create_organization)

[Map users to the organization](developer-docs/how-to-guide/how_to_create_org_add_user)
