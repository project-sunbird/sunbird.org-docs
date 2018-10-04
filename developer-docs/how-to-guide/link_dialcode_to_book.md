---
title: Creation and Curation of Books
page_title: Creation and Curation of Books
description: Details on how to create a book and add content to books
keywords: 'books, create books, generate content, compile books, add story to book, add worksheets'
published: true
allowSearch: true
---
## Scenario

A company, XYZ Corp, is a global conglomerate with over ten thousand employees, spread across 7 locations. Employee training and enablement is one of the core values of the organization. XYZ Corp has decided to use Sunbird for its learning and training solution To train and upskill their employee on a regular basis.The organization works in the domain of training and development and  they would like to digitize their training manuals and handbooks. Using QR code and DIAL code, they can create a digitized or energized book or manual.

An energized book carry a QR codes (Or else, QR Code along with DIAL code) on it. The user will be able to scan the code using the Sunbird app (Android 1.7.0 onwards) downloaded on their smartphone or other electronic devices like a laptop (using chrome browser) and tablet.

Scanning QR code provides a user the web links of related reading content to the QR code. It helps content consumer  to access the more content easily and understand the topics better. 

## Intended Audience

Book creator

## Overview

A book creators can tag various pages and topics with D.I.A.L code in a flexible manner. Using the DIAL codes (in QR code format), a book’s content can be converted into digital content. It provides end users easy access to content by transforming physical content material into digital content.

## Prerequisite

* Sunbird instance is installed and configured.

* Postman is installed.

* The user must have book creation rights. By default, any book creator gets access to link and unlink  DIAL code.    

* The user must have access to QR code and DIAL code to enter at each node in TOC of a book. 

* The publisher should be onboard into the system. They want to provide supplemental contents like a lesson plan, a worksheet to deliver the topic effectively in the class. And they must have enough good quality content to engage the student. 

* Ensure the quality of content and teaching aids before it reaches to consumer

* Content model change to incorporate the QR code.

## Taskflow

You can link dial code to content via API and Sunbird user interface as well.

<b>Linking DIAL code to Textbook via API</b>

1. Ensure to complete the pre-steps before you link DIAL code to a book:

a. [Create Publisher](http://www.sunbird.org/apis/dialapi/#operation/PublisherCreatePost)

This API is associated with creating a publisher.

* The /publisher/create endpoint executes the "Create Publisher" request based on parameters provided as metadata in the request body

* Required fields cannot be left null or empty

**Request Body for create publisger API:**
<pre><code>{

    "request": {

        "publisher": {

            "identifier": "SKPUBLISHER",

            "name": "SK Publisher"

        }

    }

}
</code></pre>


<b>Response Body of Create Publisher API </b>:

<pre><code>{

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

       "identifier": "SKPUBLISHER"

   }

}
</code></pre>


b. [Generate QR code](http://docs.sunbird.org/latest/apis/dialapi/#operation/GeneratePost):

This API is associated with generating DIAL code.

* The _ /generate_ endpoint executes the "Generate DIAL code" request based on parameters provided as metadata in the request body to be replaced by appropriate Id

* Required fields cannot be left null or empty

Request Body of **Generate DIAL Code** API:
<pre><code>{

    "request": {

        "dialcodes": {

            "count": 2000,

            "publisher": "SKPUBLISHER"

        }

    }

}

</code></pre>


Response Body of **Generate DIAL Code** API:
<pre><code>{

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

       "count": 20,

       "batchcode": "SKPUBLISHER.20181004T106427",

       "publisher": "SKPUBLISHER"

   }

}
</code></pre>

To update the QR code, use the [Update DIAL Code ](http://docs.sunbird.org/latest/apis/dialapi/#operation/PublisherReadSunbirdGet)API.

2. [Link content to QR code](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost): Content creator can create content and attach the QR code to the DIAL attribute of the content. This can be done via API.

## Link DIAL code to content using D.I.A.L API.

This API is associated with linking DIAL code to the content.

* The **_/content/link_** endpoint executes the "Link DIAL code" request based on parameters provided as metadata in the request body.

* Required fields cannot be left null or empty.

* As it is an updated request, whatever the list of dial codes API get in the request body against any particular contentId or list of content Ids, API update as content metadata. If API does not get any value in dial code list, it will delink the content with all the existing dialcode as well by removing dial codes from content metadata.

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
    <td>The Content-Type entity is the media type of the resource. </td>
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


**Request Body** sample for linking D.I.A.L code API:
<pre><code>{

  "request": {

    "content": {

      "identifier": ["do_3010101010"]

        ""

      ],

      "dialcode": ["A6GHY"]

        ""

      ]

    }

  }
</code></pre>

**Response Body** for linking D.I.A.L code API:
<pre><code>{
  "result": {
    "node_id": "string"
  },
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
  "responseCode": "OK”

  "result": {}

 }

</code></pre>

The [Link D.I.A.L Code](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost) (Digital Infrastructure for Augmented Learning) API resources are used for energizing the textbooks.

For more information, refer to [Content linking ](http://www.sunbird.org/apis/dialapi/#operation/ContentLinkPost)to QR code.

# Response Code

**200 OK! **Successful operation."Link DIAL code" operation is successfully executed.

**400 BAD REQUEST**. The "Link DIAL code" operation failed! The possible reason for failure is that you may have missed providing input for some mandatory parameter.

**500 INTERNAL SERVER ERROR**! Looks like something went wrong! These errors are tracked automatically, but if the problem persists feel free to contact us. In the meantime, try refreshing.

## Consuming DIAL Code linked content

You can consume the content linked with DIAL code using mobile and portal both.

**To consume the content using Sunbird mobile app**:

Scan the QR code using the Sunbird app installed on your mobile.

**To consume the content using Sunbird mobile app:**

Go to [https://play.diksha.gov.in/dialpage/index.html](https://play.diksha.gov.in/dialpage/index.html)

Enter the dial code (the alphanumeric number) in the **Explore Content Using DIAL Code** field and click on the Search icon.

## Concept Covered

**QR code:** <br>It is a two-dimensional machine-readable barcode that is readable by smartphones and some other electronic devices. It consists of an array of black and white squares, which essentially encode web link as graphics. Users can scan QR code using a smartphone and some other electronic devices.<br>
Discovery of digital content from physical textbooks is made possible by printing a QR code/DIAL code on books and by linking digital teaching and learning content to the QR codes placed in textbooks at a chapter and topic level.

**D.I.A.L Code**:<br>
A Dial code is the 6 digits alphanumeric code embedded with QR code.

**Energized book**:<br> A book that is embedded with QR codes and is called "Energized book". The energized book serves as the anchors to the reader enabling them to have easy access to digital learning and training material.

## Related Topic

  [Update DIAL code](http://www.sunbird.org/apis/dialapi/#operation/UpdateQ13PMPPatch)

  [Update publisher](http://www.sunbird.org/apis/dialapi/#operation/PublisherUpdateSunbirdPatch)

  [List DIAL Code](http://www.sunbird.org/apis/dialapi/#operation/ListPost)