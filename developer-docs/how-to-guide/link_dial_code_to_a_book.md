---
title: Link DIAL Code to a Book
page_title: Link DIAL Code
description: Link DIAL Code to a Book
keywords: DIAL Code, QR Code, erb, Energized textbook, book
published: true
allowSearch: true
---

## Scenario

An educational institution XYZ, with over three thousand students, is spread across three locations. XYZ institute has decided to use Sunbird for its digital learning solution to provide more scalable and effective education to its students. 

An energized book carries a QR code (Or a QR Code with a DIAL code) on it. The students can scan the QR code using the Sunbird mobile app (Android 1.7.0 onwards) on their smartphone or other electronic devices like a laptop (using chrome browser) or a tablet.

Scanning QR code provides a user the web links of related reading content. It helps the students to access the more content easily and understand the topics better. 

## Intended Audience

A user with book creation access

## Overview

As required, a book creator can tag various pages and topics with D.I.A.L code in a flexible manner. Using the DIAL codes (in QR code format), a book’s content can be converted into digital content. It provides the students easy access to content by transforming physical content material into digital content.

## Prerequisites

* An initialised instance of Sunbird

* Get an API Key to access Sunbird APIs. To create an API key, please refer to How to generate a Sunbird API keySunbird instance is installed and configured.

* Software that can make REST API calls, like curl or POSTMAN

* The root organization, sub-organizations and users created and users mapped to the organization and given appropriate rights and permisssions     

* The user must have access to QR code and DIAL code. By default, any book creator gets access to link and unlink  DIAL code 

* Content model change to incorporate the QR code.

## Taskflow

 **[Content linking to QR code](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost)**: 
As a book creator or author, you can create content and attached the QR code to the content. This can be done via API and Sunbird User interface as well. This document describes how to link DIAL code to a book using APIs.

### Steps to follow to link a DIAL code to a book

Ensure to complete the following before you link DIAL code to a book:

a. [Create Publisher](http://www.sunbird.org/apis/dialapi/#operation/PublisherCreatePost)

b. [Generate QR code](http://docs.sunbird.org/latest/apis/dialapi/#operation/GeneratePost)

a. **Create Publisher**

 This API is associated with creating a publisher.

* The `dialcode/v1/publisher/create` endpoint executes the "Create Publisher" request based on parameters provided as metadata in the request body

* Required fields cannot be left null or empty

**Request Body for create publisher API**:
```
{
    "request": {
        "publisher": {
            "identifier": "skpublisher",
            "name": "SK Publisher"
        }
    }
}
```
**Response Body of Create Publisher API**:
```
{
   "id": "api.publisher.create",
   "ver": "1.0",
   "ts": "2018-10-04T07:12:47.729Z",
   "params": {
       "resmsgid": "e5b63e10-c7a4-11e8-bbd8-e58670bcc2b7",
       "msgid": "e51fca70-c7a4-11e8-ac7b-7b8f28c2d9c1",
       "status": "successful",
       "err": null,
       "errmsg": null
   },
   "responseCode": "OK",
   "result": {
       "identifier": "skpublisher"
   }
}
```


b. Generate QR Code

This API is associated with generating DIAL code.

* The `/dialcode/v1/generate` endpoint executes the "Generate DIAL code" request based on parameters provided as metadata in the request body to be replaced by appropriate Id

* Required fields cannot be left null or empty

** Request Body of Generate DIAL Code API ** :
``` javascript
{
    "request": {
        "dialcodes": {
            "count": 2,
            "publisher": "skpublisher"
        }
    }
}
```
** Response Body of Generate DIAL Code API ** :
```
{
   "id": "api.dialcode.generate",
   "ver": "2.0",
   "ts": "2017-10-04T10:54:28.916",
   "params": {
       "resmsgid": "dcd64f40-c7c3-11e8-9bfa-fd2e5637008b",
       "msgid": "dc3af9a0-c6c3-11e8-9fb2-b710543e8512",
       "status": "successful",
       "err": null,
       "errmsg": null
   },
   "responseCode": "OK",
   "result": {
       "dialcodes": [
           "QP79LL",
           "WMHNYJ",
       ],
       "count": 2,
       "batchcode": "skpublisher.20181004T106427",
       "publisher": "skpublisher"
   }
}
```


### Link DIAL code to content using D.I.A.L API

This API is associated with linking DIAL code to the content.

* The `/dialcode/v1/content/link` endpoint executes the "Link DIAL code" request based on parameters provided as metadata in the request body.

* Required fields cannot be left null or empty.

* As it is an updated request, whatever the list of dial codes API gets in the request body against any particular contentId or list of content Ids; the API updates the same as content metadata. If API does not get any value in dial code list, it delinks the content from all the existing dial-code by removing dial codes from content metadata.

While providing values for the parameters in the request body of the API, it is essential to mention values as mentioned in the following table. 

<table>
  <tr>
    <td>Header Parameter</td>
    <td>Sample Value</td>
    <td>Description</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>Channel-ID</td>
    <td>in.ekstep</td>
    <td>It is a unique Id to identify the root organization to which the user belongs</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>Content-Type</td>
    <td>Application/json
Multipart/form-data
Application/x-www-form-urlencoded</td>
    <td>The Content-Type entity is the media type of the resource </td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>Authorization</td>
    <td>NA</td>
    <td>All User APIs require authorization for use. Raise a request to the administrator for the authorization key. Mention the received key here.</td>
    <td>Yes</td>
  </tr>
</table>


Request Body Parameter

<table>
  <tr>
    <td>Request Body Parameter</td>
    <td>Sample Value</td>
    <td>Description</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>content.identifier</td>
    <td>["do_3010101010"]</td>
    <td>List of content identifiers that are linked with dial codes.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>content.dialcode</td>
    <td>[“A6GHY”]</td>
    <td>List of dial codes to which identifiers will be linked.</td>
    <td>Yes</td>
  </tr>
</table>

Link DIalcode API End point: `POST: /dialcode/v1/content/link`

**Request Body** sample for linking D.I.A.L code API:
```
{
  "request": {
    "content": [
      {
        "identifier": ["do_3010101011"],
        "dialcode": ["3R3DSS"]
      }
    ]
  }
}
```

**Response Body** for linking D.I.A.L code API:
```
{
  "id": "sunbird.content.dialcode.link",
  "ver": "3.0",
  "ts": "2018-09-18T09:15:01ZZ"		",
  "params": {
    "resmsgid": "287298eb-ac54-4c9a-bf98-c0b1b1d4732e",
    "msgid": "null",
    "err": "null",
    "status": "successful",
    "errmsg": "null"
  },
  "responseCode": "OK”,
  "result": {
    "node_id": "do_3010101011",
    "versionKey": "1542625257776"
  }
}
```
The [Link D.I.A.L Code](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost) (Digital Infrastructure for Augmented Learning) API resources are used for energizing the textbooks.

For more information, refer to [Content linking ](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost)to QR code.

<b> Response Code</b>

<b>200 OK!</b> Successful operation."Link DIAL code" operation is successfully executed.

**400 BAD REQUEST**. The "Link DIAL code" operation failed! The possible reason for failure is that you may have missed providing input for some mandatory parameter or providing wrong inputs for any of the required parameters.

**500 INTERNAL SERVER ERROR**! Looks like something went wrong! These errors are tracked automatically, but if the problem persists feel free to contact us. In the meantime, try refreshing.

### Consuming DIAL Code linked content

You can consume the content linked with DIAL code using mobile or website

**To consume the content using Sunbird mobile app**:

Scan the QR code using the Sunbird app installed on your mobile

**To consume the content using Sunbird portal:**

Go to [https://play.diksha.gov.in/dialpage/index.html](https://play.diksha.gov.in/dialpage/index.html)

Enter the dial code (the alphanumeric number) in the **Explore Content Using DIAL Code** field and click on the Search icon

## Concept Covered

**QR code:** It is a two-dimensional machine-readable barcode that is readable by smartphones and some other electronic devices. It consists of an array of black and white squares, which essentially encode web link as graphics. Users can scan QR code using a smartphone and some other electronic devices.

Discovery of digital content from physical textbooks is made possible by printing a QR code/DIAL code on books and by linking digital teaching and learning content to the QR codes placed in textbooks at a chapter and topic level.

**D.I.A.L Code**:

A Dial code is the 6 digits alphanumeric code embedded with QR code.

**Energized book**: A book that is embedded with QR codes and is called "Energized book". The energized book serves as the anchors to the reader enabling them to have easy access to digital learning and training material.

### Related Topic

  [Update DIAL code](http://www.sunbird.org/apis/dialapi/#operation/UpdateQ13PMPPatch)

  [Update publisher](http://www.sunbird.org/apis/dialapi/#operation/PublisherUpdateSunbirdPatch)

  [List DIAL Code](http://www.sunbird.org/apis/dialapi/#operation/ListPost)

 

     

