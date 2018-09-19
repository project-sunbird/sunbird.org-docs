---
title: Uploading Content on Sunbird Portal
page_title: Uploading and Publishing Content 
description: Uploading and Publishing Existing Content
keywords: uploading content, existing content, training meterial
published: true
allowSearch: true
---

## Scenario

A company, XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 7 locations. Employee training and enablement is one of the core values of the organization. Content and course creators are creating content using various source to ensure that employees are trained and upskilled. Before they opt for Sunbird platform, they already had many other existing contents with them. They can still upload the existing content to Sunbird platform to make it accessible to their current employers.

## Prerequisite

* Content creation access

* You must have the content with unique object Id

## Intended Audience

<b>Content Creator</b>: Users who can create, manage, and upload content

<b> Content Reviewer</b>: Users who can review and publish the content

>Note: Reviewers cannot do any change in content. They can only review the content and send the review comments to the content creators for further changes or else; they can publish the content staightaway if there is no need to send any review comments.

## Overview

Sunbird enables its adopter (users) to create, store, upload and consume  a wide variety of content. Users with content creation right can create and upload content on Sunbird.

Currently, Sunbird platform supports the following content formats:

* Text (.pdf)

* Video (.mp4, .webm, YouTube URLs)

* HTML

* ECML (created using the inbuilt content editor)

* EPUB

* H5P

It also supports the following formats for its resource library:

* Audio (.mp3)

* Images (.jpeg, .png)

* URLs for YouTube videos and other files

* Videos (.mp4) Later, there will be support for other file formats.

Maximum file size supported on the platform:

<table>
  <tr>
    <td>Content/ File Type</td>
    <td>Maximum File Size</td>
  </tr>
  <tr>
    <td>Book,Course,Collection,Lesson Plan</td>
    <td>250 MB</td>
  </tr>
  <tr>
    <td>HTML (as zip files)</td>
    <td>50 MB</td>
  </tr>
  <tr>
    <td>EPUB</td>
    <td>50 MB</td>
  </tr>
  <tr>
    <td>H5P</td>
    <td>50 MB</td>
  </tr>
  <tr>
    <td>Video (.mp4, webm)</td>
    <td>50 MB</td>
  </tr>
  <tr>
    <td>.pdf</td>
    <td>50 MB</td>
  </tr>
</table>


You should create content object with below mandatory metadata fields before uploading the content:

- ContentType

- Mime Type

The uploaded content get validated through these metadata.

You can even upload video content created by other users, provided you have the required permissions. The videos should adhere to prescribed guidelines about file formats and size.

### Taskflow

To complete this scenario, you need to create the content with appropriate metadata & ownership information, upload the existing content artifact, and publish the meterial for public usage.

You can upload existing content on the Sunbird platform using Upload Content API.

#### Uploading Content Using API

This API is associated with uploading content on the Sunbird Platform .

* The <b>_/upload/{content_ID}</b> endpoint executes "Upload Content" request based on the content metadata validation with the uploaded file.

* You need to provide a valid content ID value in {Content Id} field of API URL. 

* It is a must to provide values for the required parameters

**Path  Parameter:**

<table>
  <tr>
    <td>Path  Parameter</td>
    <td>Parameter Type</td>
    <td>Description</td>
    <td>Sample Value</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>Content ID
</td>
    <td>String</td>
    <td>Content ID of the Request URL</td>
    <td>do_11258058227713638416</td>
    <td>Yes</td>
  </tr>
</table>


**Form data Parameter:**

<table>
  <tr>
    <td>Form data Parameter</td>
    <td>Parameter Type</td>
    <td>Description</td>
    <td>Sample Value</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>file</td>
    <td>String</td>
    <td>Content file path that you want to upload</td>
    <td>sample.pdf</td>
    <td>Yes</td>
  </tr>
</table>


**Header Parameter**

<table>
  <tr>
    <td>Header Parameter</td>
    <td>Parameter Type</td>
    <td>Description</td>
    <td>Sample Value</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>Content-Type</td>
    <td>String</td>
    <td>The Content Type entity is the media type of the resource.Possible media types can be: Multipart/form-data</td>
    <td>multipart/form-data</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>X-Authenticated-Userid</td>
    <td>String</td>
    <td>Represents the registered User ID to execute the API.</td>
    <td>userName</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td> Authorization</td>
    <td>String</td>
    <td>To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received. </td>
    <td>api_key</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>ts</td>
    <td>String</td>
    <td>Time Stamp at which upload request was sent.</td>
    <td>2018-09-05T10:55:22Z</td>
    <td>Yes</td>
  </tr>
</table>


Following is an example of  <b>response body</b> for <b>uploading content API</b>:

{

    "id": "ekstep.learning.content.upload",

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

        "content_url": "https://ekstep-public-prod.s3-ap-south-1.amazonaws.com/content/do_112534095400542340156583/artifact/highq_153614492126723.pdf",

        "node_id": "do_112534095400542340156583",

        "versionKey": "153614492126723"

    }

}

For the youtube content or file url, pass it as fileUrl in <b>Upload API</b> or set the artifact Url of the content using  [Update Content API**](http://www.sunbird.org/apis/content/#operation/Update%20Content)

After you uploading the content, publish the content using **[Publish Content API**](http://www.sunbird.org/apis/content/#operation/Publish%20Content). 

Request Body for Publish Content API

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

Response Body for Publish Content API

{

  "result": {

    "node_id": "string",

    "versionKey": "string"

  },

  "id": ""ekstep.learning.content.publish",

  "ver": "3.0",

  "ts": "2018-09-14T10:44:43ZZ",

  "params": {

    "resmsgid": "d3415c1a-94c6-4dc7-9c28-3e0dac767ee3",

    "msgid": "null",

    "err": "null",

    "status": "string",

    "errmsg": "null"

  },

  "responseCode": "OK",<br> "result":{
    "publishStatus": "Publish Operation for Content Id 'do_2125903396473978881177' Started Successfully!",<br>
    "node_id": "do_2125903396473978881177"<br>
  }<br>

}


>Note: Reviewer has the right to publish content. Use id of one of the selected reviewers as publisher user id.



