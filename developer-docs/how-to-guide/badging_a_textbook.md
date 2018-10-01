How to Mark/badge a book as Official

# Scenario

XYZ Corp is a global conglomerate with over ten thousand employees, spread across 7 locations. The organization required to create content, book and segregate the content for a different purpose. They can do so using Sunbird portal, they can even mark/badge those books with a different tag such as official,  editor’s pick, recommended and so on as required. In that case, when the users of the organization log into Sunbird, they can view the badged book distinguishably. The badge name is visible beside those textbooks that are already badges by badge issuers.Here, we will describe the workflow of assigning a badge to a textbook.

# Overview

Badges represent an award, a certificate, an endorsement or an authorization. As part of a learning platform, badging is an important concept that is highly useful for different users such as teachers, students, content and course creators, mentors, content authors and so on. It also plays a critical role in the curation of content and courses On Sunbird; there are two types of badges: 

1. Badges for Content 

2. Badges for People

Here we are discussing Badging content or book. Once an organization create/compile, and upload books on Sunbird portal, They can even mark/badge those books with a different tag such as Official,  Editor’s pick, Recommended and so on. In that case, when the users of the organization log into Sunbird, they can view the badged book distinguishably. The badge name is visible beside those textbooks that are already badges by badge issuers.

# Use case

Badging content (book) provides the benefits such as content usage, content effectiveness, and content segregation.

1. Organizations can create authorized content on Sunbird and mark them with appropriate badges such as Official. During search or navigation, badged content is displayed in the top results 

2. Organizations can create content for specific use cases such as content for special needs, specific age groups and so on. Badging such content aids their discoverability.

3.  Endorse books with badges such as popular, favorite, recommended to increase the effectiveness and usability

This document describes prerequisite for badging a textbook and steps to badge a book.

# Intended Audience

Badge issuer

# Prerequisite

 - Crete [ Badge class](http://www.sunbird.org/apis/badgingframeworkapi/#operation/BadgeCreatePost).

 - Assign the content badge issuer role

##   Create Badge class

This API is associated with creating a badge class.

* **_/badge/create_** endpoint executes the Create Badge Class request based on parameters provided as metadata in the request body

* It is mandatory to provide values for the required parameters

* Mandatory fields cannot be null or empty

**Create Badge class API**

**FormData Parameters:**

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


**Header Parameters **

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
    <td>You require authorization key  to use an API. Raise a request to the administrator for the authorization key. Menetion the received key here.</td>
    <td>Required</td>
  </tr>
</table>


**Response Code**

**200 'SUCCESS**: The Create Badge Class operation is successful!'

**400 BAD REQUEST**: Create Badge Class operation failed . The possible reason for failure is that you might have missed providing input for a mandatory API parameter.

**500 INTERNAL SERVER ERROR**:  Looks like something went wrong! These errors are tracked automatically, but if the problem persists feel free to contact us. In the meantime, try refreshing.

## Create Issuer

This API is used to create a badge issuer entity

* To accord badges

    * Create the Issuer entity

    * Create the Badge Class entity

    * and the Assertion

* the **_/create/_** endpoint executes the "Create Issuer" request based on parameters provided as metadata in the request body.

* It is a must to provide values for all mandatory parameters

**API Parameters for Create Issuer **API

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
    <td>You require authorization key  to use an API. Raise a request to the administrator for the authorization key. Menetion the received key here.
</td>
    <td>Mandatory</td>
  </tr>
</table>


#  The task flow for assigning a badge to a textbook

You need to design and develop badging as a framework to make it extensible and support multiple use cases. Currently, you need to create badges on the platform only through the backend, by using API. Issuing of the Official badge to Textbooks can be performed through Sunbird user interface and API as well. After assigning a badge to a book, the badge is viewed on the portal beside the book.

To complete this scenario, the admin creates badges and assign a badge issuer role. The badge issuer can assign the badge to book using APIs.

**Assigning Badge to a Textbook ****Using API:**

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
    <td>You require authorization key  to use an API. Raise a request to the administrator for the authorization key. Menetion the received key here.</td>
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
    <td></td>
    <td>Represents an unique API </td>
    <td>Yes?</td>
  </tr>
  <tr>
    <td>ver</td>
    <td>String</td>
    <td></td>
    <td>Represents the version of the API which is used for </td>
    <td>No</td>
  </tr>
  <tr>
    <td>ets</td>
    <td>Integer</td>
    <td></td>
    <td>Represents the EPOCH (UTC) timestamp in milliseconds since EPOCH</td>
    <td>No </td>
  </tr>
  <tr>
    <td>params</td>
    <td></td>
    <td></td>
    <td></td>
    <td>No</td>
  </tr>
  <tr>
    <td>request</td>
    <td></td>
    <td></td>
    <td></td>
    <td>Yes</td>
  </tr>
</table>


**Request Body Sample**:

{  "id": "string",  "ver": "string",  "ets": 0,  "params": {    "msgid": "string",    "did": "string"  },  "request": {    "recipientId": "6fbd1dd5-418c-4cc5-834b-7e7413192f10",    "recipientType": "content",    "evidence": "https://sunbirddev.blob.core.windows.net/user/uploads/badges/bfd203a3c494170dd7de199a97e05486.png",    "issuerId": "swarn",    "badgeId": "something"  }}

The body refers to the format of the request. The body contains metadata about the creation of badge assertions. 

Response Body Sample

{

  "id": "string",

  "ver": "string",

  "ets": 0,

  "params": {

    "msgid": "string",

    "resmsgid": "string",

    "err": null,

    "err_msg": null,

    "err_detail": null,

    "status": "success"

  },

  "responseCode": "string",

  "result": {

    "assertionDate": "string",

    "assertionImageUrl": "string",

    "assertionIdUrl": "string",

    "revoked": true,

    "issuerId": "string",

    "assertionId": "string",

    "recipient": {

      "type": "string",

      "salt": "string",

      "hashed": true,

      "identity": "string"

    },

    "verify": {

      "url": "string",

      "type": "string"

    },

    "revocationReason": "string",

    "recipientEmail": "string",

    "createdDate": "string",

    "issuerIdUrl": "string",

    "badgeIdUrl": "string"

  }

}

For more information, refer to the [badge assertion](http://www.sunbird.org/apis/badgingframeworkapi/#operation/BadgeAssertionSearchPost) API doc.

# Concepts Covered

Badges

Badges for content

Textbook badge user

