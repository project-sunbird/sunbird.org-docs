---
title: Generate Sunbird API keys 
page_title: Generate Sunbird API keys 
description: Generating the Sunbird API keys 
keywords: Sunbird API keys, API keys, generating Sunbird API keys 
published: true
allowSearch: true
---

## Generate API key 

This document explains the procedure to generate API keys for a user. It is mandatory to get the API keys for Sunbird server installation. 
To begin the process of generating the API keys, ssh login to the server where the Sunbird admin util docker container is running. 

### Create Consumer

```POST http://localhost:4000/v1/consumer/create```

2. Use a port on which adminutil container is running. By default port is 4000.

#### Request Body

username={username} // Unique & unmodifiable name of the consumer add in curl request & call below request

    {
        "id": "sunbird.api.consumer.create",
        "ver": "1.0",
        "ets": 1538296140,
        "params": {
            "msgid": ""
        }, 
        "request": {
            "username": "" //username={username} // Unique & unmodifiable consumer name 
        }
    }
 
#### Response Body
    {
        "id": "ekstep.api.consumer.create",
        "ver": "1.0",
        "ets": 1489054878488,
        "params": {
            status: "",
            err: "",
            errmsg: "",
            msgid: "",
            resmsgid: "",
        }
        "result": {
            key: "", //the key generated to uniquely identify the consumer
            secret: "" //secret for signing the token.
            username: "",
        }
    }

3. Generate the JWT token using the key and secret and key return in above request.

**Error codes**

- INTERNAL_ERROR: Unknown/Unhandled error (equivalent HTTP 500)

- CONSUMER_GET_ERROR: Error when getting existing consumer

- GROUP_ASSIGN_ERROR: Error when assigning consumer to default group

- CREATE_CREDENTIAL_ERROR: Error when creating credential

- BAD_REQUEST: Invalid request. Following are the reasons for this error

    - JSON is not parsable

    - mandatory fields missing (username)

    - username has space

    - username is of type UUID (Due to Kong limitation, username cannot be UUID)


### Add Groups to Consumer

1. Each API have whitelisted acl groups. The consumer who have access to these group can consume a particular API.

For example: To read a content consumer should have access to contentUser group. 

2. API’s and groups attached to API documented here.

Attaching consumer to group(s)
groups={list-of-group-names}

```POST http://localhost:4000/v1/consumer/{{username}}/grant```


#### Request Body

    {
    "id": "sunbird.api.consumer.grant",
    "ver": "1.0",
    "ets": 1489054878488,
    "params": {
        "msgid": ""
    }, 
    "request": {
        "groups": ["contentUser", "contentAdmin"] // ACL Groups
    }
    }

#### Response Body 
    {
    "id": "ekstep.api.consumer.grant",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        status: "",
        err: "",
        errmsg: "",
        msgid: "",
        resmsgid: "",
    },
    "result": {
        groups: ["contentUser", "contentAdmin"],
        username: "" //Name of the consumer used for granting the access
    }
    }

### Get Consumer Details

```POST http://localhost:4000/v1/consumer/{{username}}/read```

#### Request Body

    {
    "id": "ekstep.api.consumer.read",
    "ver": "1.0",
    "ets": 1489054878488,
    "params": {
        "msgid": ""
        }
    }

#### Response Body
    
    {
    "id": "ekstep.api.consumer.read",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        status: "",
        err: "",
        errmsg: "",
        msgid: "",
        resmsgid: "",
        },
    "result": {
        username: "",
        groups: ["contentUser", "contentAdmin"]
        }
    }


### Delete Consumer

```POST http://localhost:4000/v1/consumer/{consumer_name}/delete```

#### Request Body

    {
    "id": "ekstep.api.consumer.delete",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        msgid: "",
        }
    }


#### Response Body

    {
    "id": "ekstep.api.consumer.read",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        status: "",
        err: "",
        errmsg: "",
        msgid: "",
        resmsgid: "",
        }
    }


### Deprecate a Credential

This utility API is required for managing the credential. Using this api a credential for a consumer will be deprecated. After which the credential can't be used for any API call except credential rotation.

```POST http://localhost:4000/v1/consumer/credential/deprecate```

#### Request Body

    {
    "id": "ekstep.api.consumer.credential.deprecate",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        msgid: "",
        }, 
    "request": {
        "key": "" // key of the credential to be deprecated
        }
    }

#### Response Body
    {
    "id": "ekstep.api.consumer.credential.deprecate",
    "ver": "1.0",
    "ets": 1489054878488
    "params": {
        status: "",
        err: "",
        errmsg: "",
        msgid: "",
        resmsgid: "",
        }
    }
