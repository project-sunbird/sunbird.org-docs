---
title: Upload Content 
page_title: Upload Content 
description: Uploading and Publishing Existing Content
keywords: uploading content, existing content, training material
published: true
allowSearch: true
---

## Scenario

XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 7 locations. Employee training and enablement is one of the core values of the organization. Before the organization opted to use the Sunbird platform, employees accessed another legacy system that to train and upskill themselves. 
The legacy system has a large repository of content artifacts. These artifacts have to be uploaded into Sunbird so that employees can access them, even through Sunbird.
The organization also creates content artifacts and courses using multiple resources on an ongoing basis. Content and course creators also need to upload all such new content into Sunbird.  
 
## Prerequisites

* An intialized Sunbird instance with channel
* The [API Key for access](developer-docs/how-to-guide/generate_apikey/) and 
  basic authentication
* Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)
* Content creation access
* Content artifacts with a unique object ID

## Intended Audience

* **Content Creator**: Users who have permissions to create, manage, and upload content artifacts

* **Content Reviewer**: Users who have permissions to review and publish content artifacts

> Note: Reviewers cannot change any content. They can only send review comments to content creators for modifications or publish the content artifact directly, if no modifications are required.

## Overview

Sunbird allows you to assign users with roles that have appropriate permissions to create, store, upload or consume content. Users with content creation rights can create and upload content on Sunbird.

Currently, the Sunbird platform supports the following content formats:

* Text (.pdf)

* Audio (.mp3)

* Images (.jpeg, .png)

* Video (.mp4, .webm, YouTube URLs)

* HTML

* ECML (created using the inbuilt content editor)

* EPUB

* H5P

> Note: Currently, you can upload files with a maximum file size of 50MB per file. More file formats will be supported in future versions of Sunbird. 


Sunbird validates every content artifact that is uploaded using metadata. Hence, it is mandatory to tag each file with the following metadata before it is uploaded:

- Content Type

- Mime Type 


You can upload video content owned by others, if:

* you have the required permissions from the original creator

* it adheres to prescribed content guidelines

* it is in the accepted file format

* it is within the prescribed size limit

## Taskflow

To upload new or existing content (that is not created using Sunbird's inbuilt content editor) on to Sunbird, use the **Upload Content API**. Before you upload the content, ensure that it is appropriately tagged with metadata and ownership information. 


### Uploading Content Using API

This API is associated with uploading content on the Sunbird Platform.

* The **_/upload/{content_ID}** endpoint executes the **Upload Content** request based on validated content metadata associated with the uploaded file

* Specify a valid value in the **{Content Id}** field of API URL 

* Specify values for all the mandatory form data parameters

**Path Parameters:**

| Path  Parameter | Parameter Type|Description |Sample Value |Is Mandatory|
|----------------|---------------|------------|-------------|------------|
|Content ID      | String | Content ID of the Request URL | do_11258058227713638416 | Yes| 

**Form Data Parameters:**

| Path Parameter | Parameter Type|Description |Sample Value |Is Mandatory|
|----------------|---------------|------------|-------------|------------|
| file | String |The name of the content file that you want to upload | sample.pdf |Yes | 

**Header Parameter**

| Header Parameter | Parameter Type |Description |Sample Value |Is Mandatory|
|----------------|---------------|------------|-------------|------------|
| Content-Type | String | The content type entity is the media type of the resource. Possible media types are multipart or form-data | Multipart, form-data | Yes|
| X-Authenticated-Userid | String | Represents the registered User ID authorized to execute the API | userName | Yes |
| Authorization | String | To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received. | api_key | Yes | 
| ts | String | Time Stamp at which upload request was sent | 2018-09-05T10:55:22Z |Yes |

#### Request Body

`key`: file
`value`: file path (Ex: /Users/john/Documents/test.pdf)


Note: Below is the sample cURL of the complete request.

    curl -X POST \
      https://xyz.org/api/content/v1/upload/<CONTENT_ID> \
      -H 'Authorization: <AUTH_TOKEN>' \
      -H 'X-Authenticated-User-Token: <USER_TOKEN>' \
      -H 'cache-control: no-cache' \
      -H 'content-type: multipart/form-data;' \
      -F file=@/Users/john/Documents.pdf


#### Response Body (Upload Content API)

    {
   
       "id": "xyz.learning.content.upload",
       
       "ver": "3.0",
       
       "ts": "2018-09-05T10:55:22ZZ",
       
       "params": {
       
           "resmsgid": "d6dui5d1-60u8-4a79-23f9-78796195c2h7",
           
           "msgid": null,
           
           "err": null,
           
           "status": "successful",
           
           "errmsg": null
       },
       
       "responseCode": "OK",
       
       "result": {
           "content_url": "https://xyz-public-prod.s3-ap-south-1.amazonaws.com/content/do_112534095400542340156583/artifact/highq_153614492126723.pdf",

           "node_id": "do_112534095400542340156583",
           
           "versionKey": "153614492126723"

       }

    }

For the youtube content or file url, pass it as file Url in <b>Upload API</b> or set the artifact Url of the content using  [Update Content API**](http://www.sunbird.org/apis/content/#operation/Update%20Content)

After uploading the content, publish the content using **[Publish Content API**](http://www.sunbird.org/apis/content/#operation/Publish%20Content). 

#### Request Body (Publish Content API)

    {

     "request": {

     "content": {

       "lastPublishedBy": "sunbird",

       "publishChecklist": [
           "No Hate speech, Abuse, Violence,Profanity"
           "No Vulgarity",
           "No Discrimination or Defamation",
           "Is suitable for children",
           "Appropriate Title, Description",
           "Correct Board, Grade, Subject, Medium",
           "Appropriate tags such as Resource Type, Concepts",
           "Relevant Keywords",
           "Content plays correctly",
           "Can see the content clearly on Desktop and App",
           "Audio (if any) is clear and easy to understand",
           "No Spelling mistakes in the text",
           "Language is simple to understand"
          ]
        }
      }
    }

#### Response Body (Publish Content API)

    {
    "result": {
    "node_id": "string",
    "versionKey": "string"
      },
    "id": ""xyz.learning.content.publish",
    "ver": "3.0",
    "ts": "2018-09-14T10:44:43ZZ",
    "params": {
    "resmsgid": "d3415c1a-94c6-4dc7-9c28-3e0dac767ee3",
    "msgid": "null",
    "err": "null",
    "status": "string",
    "errmsg": "null"
    },
    "responseCode": "OK",<br> "result":
    {
      "publishStatus": "Publish Operation for Content Id 'do_2125903396473978881177' Started Successfully!",<br>
      "node_id": "do_2125903396473978881177"<br>
    }
  }

>Note: Reviewer has the right to publish content. Use the ID of any approved reviewer as the publisher user ID.

**Response Code**:

**200 SUCCESS**: The upload content operation is successful!

**400 'BAD REQUEST**: The upload content operation failed. It indicates you may have missed input for some mandatory parameter.

**500 'INTERNAL SERVER ERROR**: We track these errors automatically and try to set it right at the earliest. Try refreshing the page. If the problem stil persists, contact us at info@sunbird.org.
