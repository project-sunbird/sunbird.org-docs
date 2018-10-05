---
title: Uploading Content on Sunbird Portal
page_title: Uploading and Publishing Content 
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

> Note: Additional file formats will be supported in future versions of Sunbird. 

Sunbird validates every content artifact that is uploaded using metadata. Hence, it is mandatory to tag each file with the following metadata before it is uploaded:

- Content Type
- Mime Type 

You can upload video content owned by others, if:

* you have the required permissions from the original creator
* it adheres to prescribed content guidelines
* it is in the accepted file format
* it is within the prescribed size limit


## Taskflow

To upload new or existing content (that is not created using Sunbird's inbuilt content editor) on to Sunbird, use the [Upload Content API](reference to upload content API link). Before you upload the content, ensure that it is appropriately tagged with metadata and ownership information. 


### Uploading Content Using API

This API is associated with uploading content on the Sunbird Platform.

* The `_/upload/{content_ID}` endpoint executes the **upload content** request based on validated content metadata associated with the uploaded file
* Choose a valid unique value in the `contentId` field of API URL 
* Specify values for all the mandatory form data parameters


#### Header Parameter ####

| Header Parameter       | Parameter Type | Description                                                                                                                                                                       | Sample Value         | Is Mandatory |
|------------------------|----------------|-------------------------------------------|----------------------|---------------|
| Content-Type           | String         | The content type entity is the media type of the resource. Possible media types are multipart or form-data                                                                        | multipart, form-data | Yes          |
| X-Authenticated-Userid | String         | Represents the registered User ID authorized to execute the API.                                                                                                                  | userName             | Yes          |
| Authorization          | String         | To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received. | api_key              | Yes          |
| ts                     | String         | Time Stamp at which upload request was sent.                                                                                                                                      | 2018-09-05T10:55:22Z | Yes          |

#### Path Parameters ####

| Path Parameter | Parameter Type | Description                   | Sample Value            | Is Mandatory |
|----------------|----------------|-------------------------------|-------------------------|--------------|
| Content ID     | String         | Content ID of the Request URL | do_11258058227713638416 | Yes          |


#### Form Data Parameters ####

| Form Data Parameter | Parameter Type | Description                                          | Sample Value | Is Mandatory |
|---------------------|----------------|------------------------------------------------------|--------------|--------------|
| file                | String         | The name of the content file that you want to upload | sample.pdf   | Yes          |


#### Response Body (Upload Content API)

    ```
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
    ```

For the YouTube content or file url, pass it as a `fileUrl` in [Upload API](apis/content/#operation/Upload%20Content) or set the artifactUrl of the content using [Update Content API](apis/content/#operation/Update%20Content)


### Publishing Content using API #### 

After uploading the content, publish the content using [Publish Content API](apis/content/#operation/Publish%20Content). 

#### Request Body

    ```
    {
        "request": {
            "content": {
                "lastPublishedBy": "sunbird",
                "publishChecklist": [
                    "No copyright or trademark infringements",
                    "Is Original",
                    "No Hate speech, Abuse, Violence, Profanity",
                    "No Vulgarity",
                    "No Discrimination or Defamation",
                    "Appropriate Title, Description",
                    "Appropriate tags such as Resource Type, Concepts",
                    "Relevant Keywords",
                    "Language is simple to understand"
                ]
            }
        }
    }
    ```

#### Response Body

    ```
    {
        "result": {
            "node_id": "do_2125903396473978881177",
            "versionKey": "string"
        },
        "id": "xyz.learning.content.publish",
        "ver": "3.0",
        "ts": "2018-09-14T10:44:43ZZ",
        "params": {
            "resmsgid": "d3415c1a-94c6-4dc7-9c28-3e0dac767ee3",
            "msgid": "null",
            "err": "null",
            "status": "Publish Operation for Content Id 'do_2789903396473978881177' Started Successfully!",
            "errmsg": "null"
        },
        "responseCode": {"OK"}
    }
    ```

> Note: Reviewer has the right to publish content. Use the ID of any approved reviewer as the publisher user ID.


#### Understanding response codes

* `200 SUCCESS`: The upload content operation is successful!
* `400 BAD REQUEST`: The upload content operation failed. It indicates you may have missed input for some mandatory parameter or provided an invalid input. In this case, the `params.err` field will contain more description of what went wrong.
* `500 INTERNAL SERVER ERROR`: We track these errors automatically and try to set it right at the earliest. Try refreshing the page. If the problem stil persists, contact us at info@sunbird.org.
