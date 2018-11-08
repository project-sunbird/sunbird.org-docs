---
title: Create Badges
page_title: Create Badges
description: Create a badge for a user in Sunbird instance
keywords: create badge, badge issuer, assign badges 
published: true
allowSearch: true
---
## Scenario

As a part of employee development and training program, the XYZ Corp., needs to create and administer a course. On successful completion of the course, the course administrator would like to certify these trainees so that it is easy to know who are the employees who have completed this course. 

To help with this, Sunbird provides the ability to create and award badges. The administrator can create specific badges for each course and then award it to the employees who completes the course. The administrator can also create an entity called a Badge Issuer who awards the badges. Once the badge is awarded to an employee, the badge is displayed on that employee's profile page.
This document explains the procedure of creating and awarding badges.

Sunbird also provides the ability to badge content. While this example shows how to award a badge to a user, the same procedure can be followed to award a badge to content.
 
## Prerequisites
You will to complete some prerequisite steps before you can create badges. You need to 
1. Get an API Key for accessing[Sunbird APIs](http://www.sunbird.org/apis/). To create an API key, please refer to [How to generate a Sunbird API key]().

2. Create users and organisations for those involved in the badge awarding process. This includes the badge recipient and the user who awards the badge. See [How to create users & organisations]() for details of how users and organisations are created and linked.

3. Assign roles to specific users who can award badges. For details of role assignment see [How to assign roles]()


## Taskflow

The sequence of tasks an admin follows to create badges are:

1. Creating the badge issuer entity using the [Create Badge Issuer API](apis/badgingframeworkapi/#operation/CreatePost)

1. Creating the badge description and metadata using the [Create Badge Class API](apis/badgingframeworkapi/#operation/BadgeCreatePost)

1. Award an instance of the badge using the [Badge Assertion API](apis/badgingframeworkapi/#operation/BadgeAssertionCreatePost)

To issue badges, a badge issuer must be created. It is up to the organization administrator whether to create a single badge issuer to issue all badges or create multiple badge issuers for each type of badge to be issued. In the scenario described here, the organization administrator decides that a single issuer can be used for issuing all badges. 


### Create Badge Issuer

The [Create Badge Issuer API](apis/badgingframeworkapi/#operation/CreatePost) is used to create the badge issuer. The organisation administration decides that badges will be issued by an entity called XYZ Corp Certifications. The email address for XYZ Corp Certifications is `certifications@xyzcorp.com` and the URL for the entity is `https://intranet.xyzcorp.com/certifications`. We will use these details when creating the badge issuer. 

Following is an example of request body for creating the XYZ Corp Certifications badge issuer entity, the sample values provided in the request body are based on the scenario:

#### Request Body

```javascript
{
    "request": {
        "name":"XYZ Corp Certifications",
        "description":"XYX Corp certifications agency which is authorised to issue all badges on behalf of XYZ Corp",
        "url": "https://intranet.xyzcorp.com/certifications",
        "email":"certifications@xyzcorp.com"
    }
}
```

**Notes**
  * **Name** assigned according to the name of the entity issuing badges
  * **Description** of the badge issuer
  * **URL** URL for the homepage of the entity who is issuing the badge
  * **Email** contains the certifications department email ID 

On successful execution of the issuer creation API, an `issuerId` is generated and following parameters are returned in the response. 

#### Response Body

```javascript
{
    "responseCode": "OK",
    "result": {
        "issuerId": "issuerslug-174",
        "issuerIdUrl: "http://localhost:8000/public/issuers/issuerslug-174",
        "image": null,
        "createdDate": "2018-08-07T08:46:44.193012Z",
        "issuerUrl: "https://intranet.xyzcorp.com/certifications",
        "name": "XYZ Corp Certifications",
        "description": "XYX Corp certifications agency which is authorised to issue all badges on behalf of XYZ Corp",
        "email": "certifications@xyzcorp.com"
    }
}
```

1. Save the created **issuerId**

1. The badge issuer is created, which is required to [Create Badge Class](/how_to_create_badge#create-badge-class) and award badge to the user 

### Create Badge Class

Once the badge issuer has been created, the organization administrator can create new badge classes using the [Create Badge Class API](apis/badgingframeworkapi/#operation/BadgeCreatePost). A BadgeClass represents a type of badge which can be awarded. The same badge class can be awarded multiple times to different recipients. Each time it is awarded, there will be a new Badge instance. 

It is recommended to create a new badge class for each type of accomplishment which is being recognised. The badge class only needs to be created once for one type of badge. It is not required to create all the badge classes at once. As new types of accomplishments are recognised, new badge classes can be created.

The organization administrator must:

1. Decide  badge name 

1. Set the criteria for awarding the badge

1. Choose roles in the system who are authorized to award instance of the badge class

1. Specify the rootOrgId within which this badge class is defined.

1. Use the issuerId received from the [Create Issuer API](apis/badgingframeworkapi/#operation/CreatePost) call to indicate which entity is awarding the badge

1. Choose an image to be associated with the badge. This image will be displayed on the profile page of all the people who receive the badge 

In our scenario, XYZ Corp Certifications decides that it will issue a badge called Basic Alphabet Expert to employees who complete their basic alphabet training. The criteria for awarding the badge is that the employee can list all the letters of the alphabet. This class of badges will be issued by the users who have the `BADGE_ISSUER` role. The graphic design unit at XYZ Corp has designed a cool emblem for this badge which is present on the administrator's computer.

We will use these details to construct the request body for creating badge class.

#### Request Body

The organisation administrator will execute a request with the following parameter values.

Parameter that are submitted through form ```application/x-www-form-urlencoded```, multipart, formdata, or both are usually used as the content type of the request 

```
issuerId: issuerslug-174
name: Basic Alphabet Expert
description: Awarded for expertise in using basic alphabet
criteria: Recipient of this badge has successfully listed all the letters of the alphabet
rootOrgId: 0124758459210711040
type: user
subtype: certificate
roles: BADGE_ISSUER
images : C:\Users\Pictures\badge_logo.png
```

**Notes**
  
  * In the previous section we had created a new issuer entity which had been given the `issuerId` of `issuerslud-174` 
  * When creating organisations and users, the system administrator received the `rootOrgId` for XYZ Corp as `0124758459210711040`


#### Response Body

```javascript
{
    "responseCode": "OK"
    "result": {
        "badgeId": "badgeslug-66",
        "criteria": "http://localhost:8000/public/badges/badgeslug-66/criteria",
        "roles": ["BADGE_ISSUER"],
        "name": "Basic Alphabet Expert",
        "description": "Awarded for expertise in using basic alphabet",
        "type": "user",
        "rootOrgId": "0124758459210711040",
        "issuerId": "issuerslug-174",
        "createdDate": "2018-08-07T08:47:32.431314Z",
        "recipientCount": 0,
        "subtype": "certificate",
        "issuerIdUrl": "http://localhost:8000/public/issuers/issuerslug-174",
        "badgeIdUrl": "http://localhost:8000/public/badges/badgeslug-66”
    }
}
``` 

1. Save the created ```badgeId```

1. The badge ID created is required to [Award the badge](/how_to_create_badge#awarding-the-badge) to a user

### Awarding the Badge

Once the badge class is created, any user with the `BADGE_ISSUER` role referenced when creating the badge class issues the badge to employees as they finish the course. The badge Assertion API is associated with fetching and listing the assertions of a badge. 

> Note: You would have saved the issuer ID received after creating the issuer and the badge ID received after creating the badge class. These IDs are required for awarding the badge.

You will also need the userId of the person who will receive the badge. You can get the user ID after searching for the user using [Search User API](apis/userapi/#operation/Search%20User). In our scenario, the user identified by `userId` `d0e8c059-e038-4baf-834f-c702764a4b58` has demonstrated listing the alphabet. The organisation admin now chooses to issue the badge to this user. The following is an example of request body for this task:

#### Request Body

```javascript
{
    "request": {
        "recipientId": "d0e8c059-e038-4baf-834f-c702764a4b58",
        "recipientType": "user",
        "issuerId": "issuerslug-174",
        "badgeId": "badgeslug-66"
    }
}
```

#### Response Body

```javascript
{
    "responseCode": "OK",
    "result": {
        "assertionDate": "2018-08-17T05:16:00.047850",
        "assertionImageUrl": "https://xyzcorp.blob.core.windows.net/badgr/uploads/badges/ca19a8e0f7c067fe6429f2a91ac5defe.png",
        "badgeId": "badgeslug-66",
        "assertionIdUrl": "http://localhost:8000/public/assertions/9cddb166-eed1-4291-9545-c57a2199f49e",
        "revoked": false,
        "issuerId": "issuerslug-",
        "createdDate": "2018-08-17T05:16:00.071368Z",
        "assertionId": "9cddb166-eed1-4291-9545-c57a2199f49e",
        "issuerIdUrl": "http://localhost:8000/public/issuers/issuerslug-174",
        "recipient": {
        }
    }
}
```

## Concepts covered

**Badges** > **User Badges**


## Additional Topics

Once the badge class is registered successfully, the organization administrator can assign a registered user as the badge issuer through user interface. For details on issuing the badge through the user interface refer [Issuing Badges using User Interface](http://www.sunbird.org/features-documentation/badging_framework/content_badges/)
