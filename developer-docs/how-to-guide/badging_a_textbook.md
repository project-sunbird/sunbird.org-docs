---
title: Awarding Badges to Books
page_title: Awarding Badges to Books
description: Details on how to award badges to books
keywords: 'books, badge books, badge, content, compile books'
published: true
allowSearch: true
---
## Scenario

XYZ Corp is a global conglomerate with over ten thousand employees, spread across 7 locations. The organization creates content and compiles books from available content. The books serve different purposes and are for many topics. The organization would like to award a badge to the books. For example, a book is mandatory reading for all employees who are enrolled for a particular course. The course coordinator would like to mark this book with an 'Official' badge. Another book may not be mandatory reading, but is recommended reading. The course coordinator would like to mark this book with a 'Recommended' badge. The badge awarded is visible beside the respective book. 

## Overview

Badges represent an award, a certificate, an endorsement or an authorization. As part of a learning platform, badging is an important and useful concept for different types of users. For example, a book that is marked as 'Official' by the authorized body helps students understand that the contents of such a book are mandatory to pass the certification for the course; it is equally important to the course teacher to ensure that all the concepts required for the course are covered by them. Similarly, it is important from the perspective of the content creator to have a book created by him/her is endorsed as the official book for a course. There are two types of badges: 

1. Badges for Content 

2. Badges for People

Here we are discussing Badging content or book. Once an organization create/compile, and upload books on Sunbird portal, They can even mark/badge those books with a different tag such as Official,  Editor’s pick, Recommended and so on. In that case, when the users of the organization log into Sunbird, they can view the badged book distinguishably. The badge name is visible beside those textbooks that are already badges by badge issuers.

## Use case

Badging content (book) provides the benefits such as content usage, content effectiveness, and content segregation.

1. Organizations can create authorized content on Sunbird and mark them with appropriate badges such as Official. During search or navigation, badged content is displayed in the top results 

2. Organizations can create content for specific use cases such as content for special needs, specific age groups and so on. Badging such content aids their discoverability.

3. Endorse books with badges such as popular, favorite, recommended to increase the effectiveness and usability

This document describes prerequisite for badging a textbook and steps to badge a book.

## Intended Audience

Badge issuer

## Prerequisite

 - [ Create](http://docs.sunbird.org/latest/apis/badgingframeworkapi/#operation/CreatePost) and assign the badge issuer role
 - Crete [ Badge class](http://www.sunbird.org/apis/badgingframeworkapi/#operation/BadgeCreatePost)


### Create Issuer

This API is used to create a badge issuer entity

* To accord badges

    * Create the Issuer entity

    * Create the Badge Class entity

    * and the Assertion

* the **_/create/_** endpoint executes the "Create Issuer" request based on parameters provided as metadata in the request body.

* It is a must to provide values for all mandatory parameters

<b>API Parameters for Create Issuer API</b>

**FormData Parameters**

<table>
  <tr>
    <td>Parameter</td>
    <td>Value type</td>
    <td>Description</td>
    <td>Mandatory/Optional</td>
  </tr>
  <tr>
    <td> name	</td>
    <td>string</td>
    <td>The unique name of the badge issuing entity or organization</td>
    <td> Required
</td>
  </tr>
  <tr>
    <td> description	

</td>
    <td>string</td>
    <td>A short description of the badge issuing entity or organization</td>
    <td>Required</td>
  </tr>
  <tr>
    <td>url	</td>
    <td>string</td>
    <td>The valid homepage URL of the badge issuing entity or organization</td>
    <td>Required
</td>
  </tr>
  <tr>
    <td> email	

</td>
    <td>string</td>
    <td>The valid contact E-mail address of the issuing entity or organization</td>
    <td>Required</td>
  </tr>
  <tr>
    <td>image	

</td>
    <td>file </td>
    <td>An image/logo representing the badge issuer</td>
    <td>Optional</td>
  </tr>
</table>


**Header Parameters:**

<table>
  <tr>
    <td>Header Parameter</td>
    <td>Value Type</td>
    <td>Description</td>
    <td>Mandatory/Optional</td>
  </tr>
  <tr>
    <td>Authorization	</td>
    <td>String</td>
    <td>You require authorization key to use an API. Raise a request to the administrator for the authorization key. Mention the received key here.
Authorization value should come as follow in a header:
"Bearer {{auth-key}}" 
</td>
    <td>Mandatory</td>
  </tr>
</table>

### Create Badge class

This API is associated with creating a badge class.

* **_/badge/create_** endpoint executes the Create Badge Class request based on parameters provided as metadata in the request body

* It is mandatory to provide values for the required parameters

* Mandatory fields cannot be null or empty

**Create Badge Class API**

**Form Data Parameters:**

<table>
  <tr>
    <td>Parameter</td>
    <td>Value type</td>
    <td>Description</td>
    <td>Mandatory/Optional</td>
  </tr>
  <tr>
    <td>  issuerId

</td>
    <td>string</td>
    <td>Please append a valid Issuer ID To the Request URL</td>
    <td> Required
</td>
  </tr>
  <tr>
    <td> name

</td>
    <td>string</td>
    <td>The name of the badge/achievement</td>
    <td>Required</td>
  </tr>
  <tr>
    <td> description
</td>
    <td>string</td>
    <td>A short description of the badge/achievement.</td>
    <td>Required
</td>
  </tr>
  <tr>
    <td> criteria
</td>
    <td>string</td>
    <td>It’s either a text string or a URL of a remotely hosted page describing the criteria for achievement</td>
    <td>Required</td>
  </tr>
  <tr>
    <td> rootOrgId
</td>
    <td>string </td>
    <td>An ID which uniquely identifies the Root Organisation</td>
    <td>Required</td>
  </tr>
  <tr>
    <td> type

</td>
    <td>string </td>
    <td>The Badge class type It can possibly be either of two (user | content)</td>
    <td>Required</td>
  </tr>
  <tr>
    <td> subtype

 </td>
    <td>string</td>
    <td>It represents the Badge Subtype (possible values: award, certificate, endorsement, authorization)</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>roles

</td>
    <td>string</td>
    <td>Represents Single or multiple roles, possibly a JSON array of roles (e.g. "roleId1" or [ "roleId1", "roleId2" ], any valid role inside system)</td>
    <td>Required</td>
  </tr>
  <tr>
    <td> image

</td>
    <td>file </td>
    <td>It is a graphic which represents the Badge</td>
    <td>Required</td>
  </tr>
</table>


<b>Header Parameters</b>

<table>
  <tr>
    <td>Parameter
</td>
    <td>Value Type</td>
    <td>Description</td>
    <td>Mandatory/Optional</td>
  </tr>
  <tr>
    <td>Authorization
</td>
    <td>string </td>
    <td>You require authorization key to use an API. Raise a request to the administrator for the authorization key. Mention the received key here.
Authorization value should come as follow in a header:
"Bearer {{auth-key}}" 
</td>
    <td>Required</td>
  </tr>
</table>

**Response Code**

**200 'SUCCESS**: The Create Badge Class operation is successful!'

**400 BAD REQUEST**: Create Badge Class operation failed. The possible reason for failure is that you might have missed providing input for a mandatory API parameter.

**500 INTERNAL SERVER ERROR**:  Looks like something went wrong! These errors are tracked automatically, but if the problem persists feel free to contact us. In the meantime, try refreshing.

## The task flow for Assigning a Badge to a Book

You need to design and develop badging as a framework to make it extensible and support multiple use cases. Currently, you need to create badges on the platform only through the backend, by using API. Issuing of the Official badge to Textbooks can be performed through Sunbird user interface and API as well. After assigning a badge to a book, the badge is viewed on the portal beside the book.

To complete this scenario, the admin creates badges and assign a badge issuer role. The badge issuer can assign the badge to book using APIs.

<b>Assigning Badge to a Textbook Using API</b>:

This API is associated with badge assertion that means badging a textbook or user.

* **_/badge/assertion/create_** endpoint executes the Create Badge Assertions request based on parameters provided as metadata in the request body

* It is mandatory to provide values for parameters

* Mandatory fields cannot be null or empty

Header Parameters for Create Badge Assertion API

<table>
  <tr>
    <td>Parameter</td>
    <td>Value Type</td>
    <td>Sample Value</td>
    <td>Description</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>Content-Type
</td>
    <td>String</td>
    <td>The possible media type: Application/JSON
</td>
    <td>The Content-Type entity is the media type of the resource.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>Authorization
</td>
    <td> String</td>
    <td>NA</td>
    <td>You require authorization key  to use an API. Raise a request to the administrator for the authorization key. Mention the received key here.</td>
    <td>Yes</td>
  </tr>
</table>

**Request Body Parameter for Create Badge Assertion API**

<table>
  <tr>
    <td>Parameter</td>
    <td>Value Type</td>
    <td>Sample Value</td>
    <td>Description</td>
    <td>Is Mandatory</td>
  </tr>
  <tr>
    <td>id</td>
    <td>String</td>
    <td>unique API ID</td>
    <td>Represents a unique API </td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>ver</td>
    <td>String</td>
    <td>1.9</td>
    <td>Represents the version of the API which is used for </td>
    <td>No</td>
  </tr>
  <tr>
    <td>ets</td>
    <td>Integer</td>
    <td>2013/10/15 16:16:39
</td>
    <td>Represents the EPOCH (UTC) timestamp in milliseconds since EPOCH</td>
    <td>No </td>
  </tr>
  <tr>
    <td>RecipientType</td>
    <td>String</td>
    <td>Content</td>
    <td>The type of receiving end</td>
    <td>Yes</td>
  </tr>
   <tr>
    <td>RecipientID</td>
    <td>String</td>
    <td>6fbd1dd5-418c-4cc8-899c-7e749992f10</td>
    <td>Unique ID for the recipient. Valid userId or contentId</td>
    <td>Yes</td>
  </tr>
   <tr>
    <td>IssuerID</td>
    <td>String</td>
    <td>issuerlug</td>
    <td>Unique ID for the badge issuer</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>BadgeID</td>
    <td>String</td>
    <td>badgelug</td>
    <td>Unique ID for a badge</td>
    <td>Yes</td>
  </tr>
</table>

**Request Body Sample**:
<pre><code>
{
  "id": "unique API ID",
  "ver": "1.9",
  "ets": 2013/10/15 16:16:39,
  "params": {
    "msgid": "0995640c-901f-4097-87d3-150efea987518",
    "did": "f8aa786ce134280b3868b5473d622a758e3d2b8a"
  },
  "request": {
    "recipientId": "6fgd1dh5-558c-4cg5-874b-7e7813192y10",
    "recipientType": "content",
    "evidence": "https://sunbirddev.blob.core.windows.net/user/uploads/badges/bfd103a3c494170dd7de199a97e5486.png",

    "issuerId": "issuerlug-55 ",
    "badgeId": "badgeslug-102
  }
}

</code></pre>

The body refers to the format of the request. The body contains metadata about the creation of badge assertions.

<b>Response Body Sample</b>
<pre><code>{
    "id": "api.issuer.badge.assertion.create",
    "ver": "v2",
    "ts": "2017-10-03 09:48:55:798+0000",
    "params": {
        "resmsgid": null,
        "msgid": "26495f1c-e86c-4046-a88d-53636f08ae17",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "assertionDate": "2017-10-03T09:48:55.081559",
        "assertionImageUrl": "https://sunbirdstaging.blob.windows.net/badgr/uploads/badges/c630b460be6188c596a87d58d938bf08.png",
        "badgeId": "badgeslug-89",
        "assertionIdUrl": "https://staging.open-sunbird.org/badging/public/assertions/f025836-aca2-4b34-ae94-740d495116f4",
        "revoked": false,
        "issuerId": "issuerslug-57",
        "createdDate": "2018-10-03T09:48:54.217417Z",
        "assertionId": "f0258836-aca2-4b24-ae94-740d495116f4",
        "issuerIdUrl": "https://staging.open-sunbird.org/badging/public/issuers/issuerslug-58",
        "recipient": {
            "salt": "ea0bd0e3-b1e6-4aa7-a1baa-047d46eb8917",
            "type": "email",
            "hashed": true,
            "identity": "sha256$76232f81f10f22480e537a3e6dd11e0f7ffa36ab7807903f574143d22fe8e61b"
        },
        "verify": {
            "url": "https://staging.open-sunbird.org/badging/public/assertions/f0258836-aca2-4c24-ae94-730d495116ff4",
            "type": "hosted"
        },
        "revocationReason": null,
        "recipientEmail": "support-staging@open-sunbird.org",
        "badgeIdUrl": "https://staging.open-sunbird.org/badging/public/badges/badgeslug-88"
    }
}

</code></pre>

For more information, refer to the [badge assertion](http://www.sunbird.org/apis/badgingframeworkapi/#operation/BadgeAssertionSearchPost) API doc.

## Concepts Covered

Badges

Badges for content

Badge issuer
