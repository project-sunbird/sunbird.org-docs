---
title: Bulk user create
page_title: Create Users
description: creating bulk users in an organization in a sunbird instance
keywords: create users, new users in sunbird, users, create
published: true
allowSearch: true
---

## Scenario

A company, XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 5 locations. Employee training and enablement is one of the core values of the organization. To ensure that employees are regularly trained and upskilled, XYZ Corp has decided to use Sunbird for its learning and training solution on 3 topics, namely Life Science, eCommerce and Archeology (Indian, Greek, Mayan). 
Gita is the XYZ Corp's Sunbird adminstrator and has created the necessary structure (root organization called Archeology and sub-organizations - Indian Archeology, Mayan Archeology and Greek Archeology). She need to onboard all employess in one go.In that case she can you user bulk uplod api to upload user data in csv format.

### Prerequisites

1. An intialized Sunbird instance with channel

2. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)
  
3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)
4. Generating user token [How to generate x-authenticated-user-token] (developer-docs/how-to-guide/how_to_create_user_auth_token/)

5. Access to [User API](apis/bulkupload/#operation/bulk%20upload%20user%20req1)
6. text file having all user data in .csv format.

### Taskflow : User bulk upload, User can be uploaded under under rootOrg at a time. User rootOrg will be define based on uploader x-authenticated-user-token.
 

**CSV headers**

|     column    |          Type  | Description | Sample |
|---------------|----------------|-----------|--------|
| NAME          | String         | name of the user  | Mr john |
|MOBILE PHONE   | String         | user phone number | 9012333300|
|Email          | String         | user email. either phone or email is mandatory| test@gmail.com |
|SCHOOL ID      | String         | organisation id   | 12344444
|USER_TYPE      | String         | teacher or other  | supported value is either teacher or other
|ROLES          | list           | list of supported role | "role1,role2"
|USER ID        | String         | required if you want to update user details| 
|External ID    | String         | either school id or external id is mandatory to associate user with org 



**Request Header**

|     Header    |          Type         | Description | Sample |
|---------------|------------------------|-----------|--------|
| Content-type | String | Mime type of the request | application/json |
| Authorization | String | Authorization key received | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 |

#### Request Body 

    curl -X POST \
  {baseUrl}/api/user/v1/upload \
  -H 'Authorization: Bearer api-key' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'x-authenticated-user-token: 'user-token'\
  -F user=@u \
  

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
            "processId": "12334445555"
        }
    }

This api will return you process id, Save process id some where for further communication/verification

### Request Body : Later you can use below api to get upload status

   curl -X GET \
  {baseUrl}/api/data/v1/upload/status/{ProcessId} \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer api-key' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -H 'x-authenticated-user-token: user-token' 
  
### Related Topics

[Creating Organization](developer-docs/how-to-guide/how_to_create_organization)

[Map users to the organization](developer-docs/how-to-guide/how_to_create_org_add_user)
