---
title: Create Badges
page_title: Create Badges
description: Create a badge for a user in Sunbird instance
keywords: create badge, badge issuer, assign badges 
published: true
allowSearch: true
---
## Scenario

As a part of the employee development and training program, the XYZ Corp., needs to create and administer a course. At the end of the course, the course administrator would like to recognize employees who have successfully completed this course. 

To enable this, Sunbird allows administrators to create and award badges. Badges can be specific to each course. The administrator can also create an entity called a **Badge Issuer** who awards the badges. Once the badge is awarded to an employee, the badge is displayed on that employee's profile page.

Sunbird also allows you to award badges to content. The following example shows you how to award a badge to a user. However, you can follow the same procedure to award badges to content artifacts.
 
## Prerequisites

1. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)
  
2. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

3. Create the organization and users associated with the badge awarding process. Ensure that you have created the specific badge recipient and the user who awards the badge. For details, refer to [How to create organisations](developer-docs/how-to-guide/how_to_create_organization) and [How to create users](developer-docs/how-to-guide/how_to_create_user).

4. Assign the role, with permissions to award badges, to specific users. For details on role assignment, refer [How to assign roles](features-documentation/admin_assigning_users/index.html)

## Taskflow

The sequence of tasks an administrator follows to create badges are:

1. Creating the badge issuer entity using the [Create Badge Issuer API](apis/badgingframeworkapi/#operation/CreatePost)

1. Creating the badge description and metadata using the [Create Badge Class API](apis/badgingframeworkapi/#operation/BadgeCreatePost)

1. Award an instance of the badge using the [Badge Assertion API](apis/badgingframeworkapi/#operation/BadgeAssertionCreatePost)

To issue badges, you need to create a badge issuer. The organization administrator decides whether a single badge issuer issues all badges or multiple badge issuers create badges for different types of badges. In the following example, the organization administrator decides that a single issuer issues all badges. 


### Create Badge Issuer

The [Create Badge Issuer API](apis/badgingframeworkapi/#operation/CreatePost) is used to create the badge issuer. The organisation administration decides that badges will be issued by an entity called XYZ Corp Certifications. The email address for XYZ Corp Certifications is `certifications@xyzcorp.com` and the URL for the entity is `https://intranet.xyzcorp.com/certifications`. We will use these details when creating the badge issuer. 

Following is an example of request body for creating the XYZ Corp Certifications badge issuer entity, the sample values provided in the request body are based on the scenario:

**Header Parameters**

|Header|Type|Description|Sample|Mandatory?|
|-------------|------|--------------------------|-------------------|----|
|Content-type |String|Mime type of the request  |multipart/form-data|Yes |
|Authorization|String|Authorization key received|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|Yes|

#### cURL Request

    curl -X POST \
    https://sunbird.xyzcorp.com/api/badging/v1/issuer/create \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-type: multipart/form-data' \
    -F 'name=XYZ Corp Certifications' \
    -F 'description=XYZ Corp certifications agency which is authorised to issue all badges on behalf of XYZ Corp' \
    -F url=https://intranet.xyzcorp.com/certifications \
    -F email=certifications@xyzcorp.com \
    -F image=@/Users/someuser/xyz_certifications_logo.png

On successful execution of the issuer creation API, an `issuerId` is generated and following parameters are returned in the response. 

#### Response Body

    javascript
    {
        "responseCode": "OK",
        "result": {
            "issuerId": "issuerslug-174",
            "issuerIdUrl: "http://sunbird.xyzcorp.com/public/issuers/issuerslug-174",
            "image": "https://sunbird.xyzcorp.com/badge/uploads/issuers/issuer_logo_cb9fe2a8-82d0-4201-bd40-23fbe985fdd4",
            "createdDate": "2018-08-07T08:46:44.193012Z",
            "issuerUrl: "https://intranet.xyzcorp.com/certifications",
            "name": "XYZ Corp Certifications",
            "description": "XYZ Corp certifications agency which is authorised to issue all badges on behalf of XYZ Corp",
            "email": "certifications@xyzcorp.com"
        }
    }
    > **Note:**
    > * Save the created **issuerId**
    > * The badge issuer is created, which is required to [Create Badge Class](/how_to_create_badge#create-badge-class) and award badge to the user. 

### Create Badge Class

Once the issuer has been created, you can create new badge classes using the [Create Badge Class API](apis/badgingframeworkapi/#operation/BadgeCreatePost). A **BadgeClass** represents the type of badge to be awarded. The same class can be awarded multiple times to different recipients. Each time it is awarded, there will be a new instance. 

It is recommended to create a new class for each type of accomplishment which is being recognised. The **BadgeClass** needs to be created only once for each type of badge. It is not required to create all the badge classes at once. As new types of accomplishments are recognised, new badge classes can be created.

The organization administrator must:

1. Decide badge name 

2. Set the criteria for awarding the badge

3. Choose roles in the system who are authorized to award instance of the badge class

4. Choose an image to be associated with the badge. This image will be displayed on the profile page of all the people who receive the badge 

5. Specify the **rootOrgId** within which this badge class is defined

6. Use the **issuerId** received from the [Create Issuer API](apis/badgingframeworkapi/#operation/CreatePost) call to indicate which entity is awarding the badge

In our scenario, 
1. XYZ Corp Certifications decides that it will issue a badge called **Basic Alphabet Expert**, to employees who complete their basic alphabet training

2. The criteria for awarding the badge is that the employee can list all the letters of the alphabet

3. This class of badges will be issued by the users who are assigned the **BADGE_ISSUER** role

4. The graphic design unit at XYZ Corp has designed a cool emblem for this badge which is present on the administrator's computer.

We will use these details to construct the request body for creating badge class

**Header Parameters**

|Header|Type|Description|Sample|Mandatory?|
|-------------|------|--------------------------|-------------------|----|
|Content-type |String|Mime type of the request  |multipart/form-data|Yes |
|Authorization|String|Authorization key received|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|Yes|

#### cURL Request

The organisation administrator will execute a request with the following parameter values.

    curl -X POST \
    https://sunbird.xyzcorp.com/badging/api/v1/issuer/badge/create \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-type: multipart/form-data' \
    -F issuerId=issuerslug-174 \
    -F 'name=Basic Alphabet Expert' \
    -F 'description=Awarded for expertise in using basic alphabet' \
    -F 'criteria=Recipient of this badge has successfully listed all the letters of the alphabet' \
    -F rootOrgId=0124758459210711040 \
    -F type=user \
    -F subtype=certificate \
    -F roles=BADGE_ISSUER \
    -F image=@/Users/someuser/basic_alpha_badge_logo.png

    > **Note:**
    > * In the previous section, we had created a new issuer entity which had been given the `issuerId` of `issuerslud-174` 
    > * When creating organisations and users, the organization administrator received the `rootOrgId` for XYZ Corp as `0124758459210711040`

#### Response Body

    javascript
    {
        "responseCode": "OK"
        "result": {
            "badgeId": "badgeslug-66",
            "criteria": "http://sunbird.xyzcorp.com/public/badges/badgeslug-66/criteria",
            "roles": ["BADGE_ISSUER"],
            "name": "Basic Alphabet Expert",
            "description": "Awarded for expertise in using basic alphabet",
            "type": "user",
            "rootOrgId": "0124758459210711040",
            "issuerId": "issuerslug-174",
            "createdDate": "2018-08-07T08:47:32.431314Z",
            "recipientCount": 0,
            "subtype": "certificate",
            "issuerIdUrl": "http://sunbird.xyzcorp.com/public/issuers/issuerslug-174",
            "badgeIdUrl": "http://sunbird.xyzcorp.com/public/badges/badgeslug-66"
        }
    }

1. Save the created **badgeId**. It is required to [Award the badge](developer-docs/how-to-guide/how_to_create_badge#awarding-the-badge) to a user

### Awarding the Badge

Once the badge class is created, any user with the **BADGE_ISSUER** role referenced when creating the badge class, issues the badge to employees who finish the course. The badge Assertion API is associated with fetching and listing the assertions of a badge. 

> **Note:** Save the **issuerId**, received after creating the issuer and the **badgeId**, received after creating the badge class. You require these IDs to award the badge.

You will also need the **userId** of the person who receives the badge. You can get the **userId** after searching for the user using [Search User API](apis/userapi/#operation/Search%20User). In our scenario, the user identified by `userId: "d0e8c059-e038-4baf-834f-c702764a4b58"` has demonstrated listing the alphabet. The organisation admin now chooses to issue the badge to this user. The following is an example of request body for this task:

**Header Parameters**

|Header|Type|Description|Sample|Mandatory?|
|-------------|------|--------------------------|-------------------|----|
|Content-type |String|Mime type of the request  |application/json   |Yes |
|Authorization|String|Authorization key received|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|Yes|
|X-Authenticated-User-Token|String|Unique token to authenticate user|eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2|Yes|

#### cURL Request

    curl -X POST \
    https://sunbird.xyzcorp.com/api/badging/v1/issuer/badge/assertion/create \
    -H 'Authorization: Bearer abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' \
    -H 'Content-Type: application/json' \
    -d '  {
    "request": {
        "recipientId": "d0e8c059-e038-4baf-834f-c702764a4b58",
        "recipientType": "user",
        "issuerId": "issuerslug-174",
        "badgeId": "badgeslug-66"
    }
    } 

#### Response Body

    javascript
    {
        "responseCode": "OK",
        "result": {
            "assertionDate": "2018-08-17T05:16:00.047850",
            "assertionImageUrl": "https://sunbird.xyzcorp.com/badge/uploads/badges/ca19a8e0f7c067fe6429f2a91ac5defe.png",
            "badgeId": "badgeslug-66",
            "assertionIdUrl": "http://sunbird.xyzcorp.com/public/assertions/9cddb166-eed1-4291-9545-c57a2199f49e",
            "revoked": false,
            "issuerId": "issuerslug-",
            "createdDate": "2018-08-17T05:16:00.071368Z",
            "assertionId": "9cddb166-eed1-4291-9545-c57a2199f49e",
            "issuerIdUrl": "http://sunbird.xyzcorp.com/public/issuers/issuerslug-174",
            "recipient": {
            }
        }
    }

## Concepts covered

**Badges**

**User Badges**


## Additional Topics

Once the badge class is registered successfully, the organization administrator can assign a registered user as the badge issuer through the user interface. For details on issuing the badge through the user interface refer [Issuing Badges using User Interface](features-documentation/badging_framework/content_badges/)
