---
type: landing
directory: developer-docs/how-to-guide
title: Associate User with Organization
page_title: Associate User with Organization
description: adding an user to an organization
keywords: associate user with organization, associate
published: false
allowSearch: false
---
## Scenario

A company, XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 5 locations. Employee training and enablement is one of the core values of the organization. To ensure that employees are regularly trained and upskilled, XYZ Corp has decided to use Sunbird for its learning and training solution on 3 topics, namely Life Science, eCommerce and Archeology (Indian, Greek, Mayan). <br>
Maya joins XYZ Corp as an intern pursuing research Indian & Greek archeology. For the first 3 months, she needs access to scholarly articles on Indian archeology and the next 3 months access to articles on Greek archeology. She does not have the rights to publish any articles, only consume existing ones. XYZ Corp's Sunbird administrator, Gita, is tasked in ensuring Maya gets access to the relevant content during this six month period.


### Prerequisites

1. An initialized Sunbird instance

2. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](../developer-docs/how-to-guide/generate_apikey/)

3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

4. Generated user token [How to generate x-authenticated-user-token] (developer-docs/how-to-guide/how_to_create_user_auth_token/)

5. The root organization and sub-organizations created and their **organsationId** are available

6. The user account created in the root-organization and the **userId** is readily available

### Taskflow

First, Gita assigns the role of content consumer, to Maya, in the sub-organization Indian Archeology. 

**Headers Parameter**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|--------|-----------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | Authorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |
| x-authenticated-user-token | String | A token that identifies that the caller is authorized to invoke this REST API | eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE |

#### Request Body 

**Note:** The following request sample should be used when the user is not already associated with the provided organisation. If the user is already associated, then this API will return an error. 

    curl -X POST \
    https://staging.open-sunbird.org/api/org/v1/member/add \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -H 'x-authenticated-user-token: eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE' \
    -d '{
        "request":
        {
            "organisationId": "01261942258536448016",
            "userId": "a04b9456-a7f8-4907-aeb1-b5d142d7a449",
            "roles" : [] //optional   
        }
    }

#### Response Body

    {
        "id": "api.org.member.add",
        "ver": "v1",
        "ts": "2018-11-13 15:18:17:253+0000",
        "params": {
            "resmsgid": null,
            "msgid": "d6e68bc6-599f-48d1-b397-9ef8d3dfc2cc",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS"
        }
    }


#### Request Body 
**Note:** The following sample request should be used when the user is already associated with an organisation and the user's associated roles need to be added or removed. The roles that are passed will be applied to the user. All exisitng roles of the user will be overridden.

    curl -X POST \
    https://staging.open-sunbird.org/api/org/v1/role/assign \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -H 'x-authenticated-user-token: eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE' \
    -d '{
        "request":
        {
            "organisationId": "01261942258536448016",
            "userId": "a04b9456-a7f8-4907-aeb1-b5d142d7a449",
            "roles" : ["role1","role2"]    
        }
    }

#### Response Body

    {
        "id": "api.org.role.assign",
        "ver": "v1",
        "ts": "2018-11-13 15:18:17:253+0000",
        "params": {
            "resmsgid": null,
            "msgid": "d6e68bc6-599f-48d1-b397-9ef8d3dfc2cc",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS"
        }
    }



After 3 months, Gita revokes Maya's access to the the sub-organization - Indian Archeology.

**Header Parameters**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|--------|-----------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | The uthorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |
| x-authenticated-user-token | String | A token that identifies that the caller is authorized to invoke this REST API | eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE |

#### Request Body

    curl -X POST \
    https://staging.open-sunbird.org/api/org/v1/member/remove \
    -H 'Authorization: Bearer \ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -H 'x-authenticated-user-token: eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE' \
    -d '{
        "request":
        {
            "organisationId": "01261942258536448016",
            "userId": "a04b9456-a7f8-4907-aeb1-b5d142d7a449"
        }
    }'

#### Response Body

    {
        "id": "api.org.member.remove",
        "ver": "v1",
        "ts": "2018-11-13 16:09:58:761+0000",
        "params": {
            "resmsgid": null,
            "msgid": "754aa3c1-0c85-42b9-83d7-3025ee3f16dd",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS"
        }
    }


Gita associates Maya with sub-organization called Greek Archeology.

**Header Parameters**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|--------|-----------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | Authorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |
| x-authenticated-user-token | String | A token that identifies that the caller is authorized to invoke this REST API | eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE |

#### Request Body

    curl -X POST \
    https://staging.open-sunbird.org/api/org/v1/member/add \
    -H 'Authorization: Bearer \ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -H 'x-authenticated-user-token: eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE' \
    -d '{
        "request":
        {
            "organisationId": "01261943599298150417",
            "userId": "a04b9456-a7f8-4907-aeb1-b5d142d7a449"
        }
    }'

#### Response Body

    {
        "id": "api.org.member.add",
        "ver": "v1",
        "ts": "2018-11-13 16:11:21:632+0000",
        "params": {
            "resmsgid": null,
            "msgid": "b9a019cb-71cb-486e-a697-dd7ea4fdd8b4",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS"
        }
    }

After 3 more months, Gita revokes Maya's access to the sub-organization called Greek Architecture.

**Header Parameters**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|--------|-----------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | The authorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |
| x-authenticated-user-token | String | A token that identifies that the caller is authorized to invoke this REST API | eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE |

#### Request Body

    curl -X POST \
    https://staging.open-sunbird.org/api/org/v1/member/remove \
    -H 'Authorization: Bearer \ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -H 'x-authenticated-user-token: eyqtUZ.Y0RU965YATAb3ws4GcJzEWblQPzUVsefMx6QqO73WwEPFDPhG28uK2z6kTcjst4oqVLNY63tUPZphE5pWRjPYQEIOJK-JxRhJ0RsR6DmJCSb3kmS14n4l5FWQBEQ0AE' \
    -d '{
        "request":
        {
            "organisationId": "01261943599298150417",
            "userId": "a04b9456-a7f8-4907-aeb1-b5d142d7a449"
        }
    }'

#### Response Body

    {
        "id": "api.org.member.remove",
        "ver": "v1",
        "ts": "2018-11-13 16:12:31:797+0000",
        "params": {
            "resmsgid": null,
            "msgid": "c7b9740a-ab6f-4b97-954f-925c4ce0bbaa",
            "err": null,
            "status": "success",
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "response": "SUCCESS"
        }
    }

This concludes the topic of associating a user with an organization, in Sunbird.

### Concepts Covered

**Associate user and organization**: When a user is created in an organization, by default, the user does not get associated with any sub-organization. A user can be associated with one or more sub-organizations, within the same organization. A user cannot be associated with more than one organization.

### Related Topics

[Creating an organization](developer-docs/how-to-guide/how_to_create_organization)

[Creating Users](developer-docs/how-to-guide/how_to_create_user)
