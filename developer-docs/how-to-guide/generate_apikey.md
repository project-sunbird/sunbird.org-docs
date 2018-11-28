---
title: Generating API key 
page_title: Generating API key  
description: Generating API key for consumer on own Sunbird server installation
keywords: API, Auth Key, Authorization, server installation
published: true
allowSearch: true
---
## Scenario
Let us consider an example of an organization, ABC Corp, which works in the domain of water conservation and works with multiple NGOs, village panchayats, and district administration authorities in multiple states of India. ABC Corp wants to use Sunbird to evangelize all the other entities they work with on irrigation technologies and water conservation technologies. To achieve this objective, ABC Corp must install Sunbird and enable all other entities involved to install Sunbird and use its features. For all the associated entities to install and use Sunbird, ABC Corp must generate and provide Sunbird API keys. 

This document explains how an adopter, like ABC Corp, can generate Sunbird API keys from its own instance for their adopter XYZ Corp.


## Prerequisites

For developer installation process the adopter use Ekstep servers

In server installation, different [servers](/developer-docs/server-installation/#infrastructure_components) are required to install Sunbird.  

>**Note**:
> - All the API operations should be triggered by docker swarm manager ( or any docker swarm client)
>
> - Service admin_utils are not exposed to the public due to security concerns


## Generating API Key
Follow the steps as listed below to generate API keys 

### Create Consumer

Path for creating consumers: http://localhost:**4000**/v1/consumer/create 

>**Note**: admin_utils is interacting with port 4000

#### Request Body

* username= XYZ-Corp // Unique & unmodifiable name of the consumer 

```
    curl -X POST \

      http://localhost:4000/v1/consumer/create \

      -H 'Content-Type: application/json' \

      -d '{

      "id": "ekstep.api.am.adminutil.consumer.create",

      "ver": "1.0",

      "ets": 1489054878488,

      "params": {

        "msgid": ""

     }, 

     "request": {

        "username": "XYZ-Corp"

     }

    }'
```
#### Response Body

```
    {

    "id":"ekstep.api.am.adminutil.consumer.create",

    "ver":"1.0",

    "ets":1542611334837,

    "params":{

        "status":"successful",

        "err":null,

        "errmsg":null,

        "msgid":"",

        "resmsgid":"c06ece80-d65f-4ac1-af80-8aeb05fa4881"

        },

    "result":{

        "key":"07dcc362679d477ea0711d74132203e1",

        "secret":"8ba62750a63648059839e782a0424b4f",

        "username":"XYZ-Corp"

        }

    }
```
**Error Codes**

* INTERNAL_ERROR: Unknown/Unhandled error (equivalent HTTP 500)

* CONSUMER_GET_ERROR: Error when getting existing consumer

* GROUP_ASSIGN_ERROR: Error when assigning a consumer to the default group

* CREATE_CREDENTIAL_ERROR: Error when creating a credential

* BAD_REQUEST: Invalid request. Following are the reasons for this error

    * JSON is not parsable

    * mandatory fields missing (username)

    * username has space

    * username is of type UUID (Due to Kong limitation, the username cannot be UUID)

## Generating JWT

The key and secret issued in the above request can be used to create a JSON Web Token (JWT) for authorizing requests.

#### Request 

The requests need to contain HS256 signed JSON Web Tokens (as specified in RFC 7519). Since we want to sign it using HS256, the JWT should be crafted according to RFC 7519:

**Header Parameters**:

```
    {
        "typ": "JWT",
        "alg": "HS256"
    }
```
#### Request Body 

```    
    {
        "iss": "8f00bc9585904d95e51cc4a1" \\ "key" of the credential  shared above.
    }

The remaining fields of the JWT can be filled based on the details of the request being sent. For example, given below is the request body which accesses the content API:

    javascript
    {
       "iss": "8f00bc9585904d95e51cc4a1", // the issuer of the claim or the "key"
       "iat": "1442426231600", // epoch timestamp when JWT was created
       "id": "org.sunbird.api.contentAPI", // target API
       "qsh": "8063ff4ca1e41df0f6207d491cf6dad7c66ea797b4614b7", // hashed query string
       "version": "1.0",  // version of the API
       "params": { // contextual parameters from the API request
          "did": "ff305d54-85b4-341b-da2f-eb6b9e5460fa", 
          "msgid": "c3049b36249a3c9f8891cb1999777743c"
       }
    }
  ```  
The generated JWT from the request: 

```
 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhMzZjMzA0OWIzNjI0OWEzYzlmODg5MWNiMTI3MjQzYyIsImlhdCI6IjE0NDI0MjYyMzE2MDAiLCJpZCI6Im9yZy5la3N0ZXAuYXBpLmRhdGFTZXQiLCJxc2giOiI4MDYzZmY0Y2ExZTQxZGYwZjYyMDdkNDkxY2Y2ZGFkN2M2NmVhNzk3YjQ2MTRiNyIsInZlcnNpb24iOiIxLjAiLCJwYXJhbXMiOnsiZGlkIjoiZmYzMDVkNTQtODViNC0zNDFiLWRhMmYtZWI2YjllNTQ2MGZhIiwibXNnaWQiOiJjMzA0OWIzNjI0OWEzYzlmODg5MWNiMTk5OTc3Nzc0M2MifX0.rww4BN-EfnAXKTRltQChYA3KM31GzyEF-YpYvIBzw1I
```
Usually, the JWT will be created programmatically by your application. JWT libraries exist for all popular programming languages. However, you may also use the web-based tool - [jwtbuilder](http://jwtbuilder.jamiekurtz.com/) to generate the JWT. Note that when using this tool, the **key** should be set as the **iss** field in the claims section of the payload and the **secret** obtained should be set as the **Key** field in the Signed JWT section. The Key will be used to generate a signed JWT.

#### Response Body

If auth fails, the response code will be 401 or 403 and will also have the error metadata in the response body. A normal response will be a 200. For clients which need to be protocol agnostic, the response body has error metadata to extract the error code and message, if any.

```
    {
        "id": "", // unique API ID
        "ver": "", // API version
        "ets": "", // epoch timestamp 
        "params": {
            "resmsgid": "", // unique response message id (UUID)
            "msgid": "", // message id of the request
            "status": "", // status of request e.g: successful, failed etc
            "err": "", // error code if any
            "errmsg": "" // default English error message
        },
        // API specific JSON output goes here
    }
```
### Adding Groups to Consumers

Each API have whitelisted acl groups. Consumers who have access to these groups access particular APIs.

For example, to read a content, consumer must have access to contentUser group. 

API’s and groups attached to APIs are documented [here](https://docs.google.com/spreadsheets/d/1O2QADGzizOClGRjmx_1JVGAHoXwDNY7GDsEtnO3nnpI/edit#gid=772094723).

* groups={list-of-group-names}

#### Request Body

    javascript
    curl -X POST \

      http://localhost:4000/v1/consumer/XYZ-Corp/grant \

      -H 'Content-Type: application/json' \

      -d '{

      "id": "ekstep.api.am.adminutil.consumer.grant",

      "ver": "1.0",

      "ets": 1489054878488,

      "params": {

        "msgid": ""

     }, 

     "request": {

        "groups": ["contentUser", "contentAdmin"]

     }

    }'


#### Response Body

```    
    {

    "id":"ekstep.api.am.adminutil.consumer.grant",

    "ver":"1.0",

    "ets":1542611633960,

    "params":{

        "status":"successful",

        "err":null,

        "errmsg":null,

        "msgid":"",

        "resmsgid":"5ac68867-502d-4e8b-bbc1-2c77fdc5a458"

    },

    "result":{

        "username":"XYZ-Corp",

        "groups":[

            "contentUser",

            "contentAdmin"

        ]

    }

    }
```

### Getting Consumer Details

#### Request Body
```
    curl -X POST \

      http://localhost:4000/v1/consumer/XYZ-Corp/read \

      -H 'Cache-Control: no-cache' \

      -H 'Content-Type: application/json' \

      -d '{

      "id": "ekstep.api.am.adminutil.consumer.read",

      "ver": "1.0",

      "ets": 1489054878488,

      "params": {

        "msgid": ""

     }

    }'
```

#### Response Body
```
    javascript
    {

        "id": "ekstep.api.am.adminutil.consumer.read",

        "ver": "1.0",

        "ets": 1542609723572,

        "params": {

            "status": "successful",

            "err": null,

            "errmsg": null,

            "msgid": "",

            "resmsgid": "a1adcb76-cc02-46fb-8fcc-3737acf569de"

        },

        "result": {

            "username": "XYZ-Corp",

            "groups": [

                "contentUser",

                "contentAdmin"

            ]

        }

    }
```