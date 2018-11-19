---
title: Consuming Telemetry Data
page_title: Consuming Telemetry Data
description: Consuming Telemetry Data
keywords: Telemetry, analytics, time consumtion, edata, workflow summary, raw data
published: true
allowSearch: true
---

## Scenario

XYZ Corporation, is a global conglomerate that works in the domain of education and collaborates with different institutions, NGOs and academicians around the world. The organization has adopted Sunbird to cater to evolving training needs and amplify learning opportunities. The organization has provided open access to its existing content assets. The organization also offers certification courses to candidates. In order to offer such courses, Multiple assets can be grouped together to offer a course.

On successful completion of the course, the course administrator would like to certify employees so that it is easy to know who are the employees who have completed this course.

## Prerequisites

1. The [API Key for access](developre-doc/how-to-guide/gevnerate-apikey) and basic authentication

2. An API client to make API calls. For example use Postman refer [Using Postman](http://www.sunbird.org/apis/framework/#tag/usingpostman)

3. Access to the [Content API](http://docs.sunbird.org/latest/apis/content/)

4. Content should be created and available for the course

## Taskflow

The content on Sunbird can be created using [user interface](http://docs.sunbird.org/latest/features-documentation/contenteditor/) and through APIs as well. Content in sunbird can be of different types:

1. Courses

2. Collections

3. Resources

4. Lesson Plan

5. Book

This document essentially explains the process of creating content using APIs. The sequence of tasks the organization needs to follow to complete the process of course creation through APIs:

1. Creating Course using [Create Course ](http://docs.sunbird.org/latest/apis/content/#operation/Create%20Content)[API](http://docs.sunbird.org/latest/apis/content/#operation/Create%20Content)

  Path for creating a course:

    * {{host}}/course/v1/create

  Request Body
  ```
  {
	"request": {
		"course": {
		"name": "training course",
		"description": "training content for upskilling employees",
		"creator": "Creator01 user",
		"createdBy": "159e93d1-da0c-4231-be94-e75b0c226d7c",
		"organisation": [
			"XYZ Corporation",
			"XYZ"
		],
		"createdFor": [
			"01232002070124134414",
			"012315809814749184151"
		],
		"framework": "NCF",
		"resourceType": "Course"
		}
	}
}
  ```

### Response Body
```
{
"id": "api.course.create",
  "ver": "1.0",
  "ts": "2018-11-19T10:56:30.091Z",
  "params": {
    "resmsgid": "c5111ae0-ebe9-11e8-ac68-f9207ddcbbef",
    "msgid": "c5007910-ebe9-11e8-b46e-897f51258085",
    "status": "successful",
    "err": null,
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {

    "course_id": "do_2126371839184814081930",

    "versionKey": "1542624990048"
  }
}
```

2. Adding a content to a course: 

{{host}}/course/v1/hierarchy/update

### Request Body
```
{
  "request": {
    "data": {
      "nodesModified": {
        "6137dc8b-0e78-4676-b199-1040371b5c19": {
          "isNew": true,
          "root": false,
          "metadata": {
            "mimeType": "application/vnd.ekstep.content-collection",
            "contentType": "CourseUnit",
            "name": "Untitled Course Unit",
            "code": "6137dc8b-0e78-4676-b199-1040371b5c19",
            "framework": "NCFCOPY"
          }
        }
      },
      "hierarchy": {
        "do_2126371839184814081930": {
          "name": "training course",
          "contentType": "Course",
          "children": [
            "6137dc8b-0e78-4676-b199-1040371b5c19"
          ],
          "root": true
        },
        "6137dc8b-0e78-4676-b199-1040371b5c19": {
          "name": "Untitled Course Unit",
          "contentType": "CourseUnit",
          "children": [
            "do_112635138121129984111"
          ],
          "root": false
        },
        "do_112635138121129984111": {
          "name": "new resource content",
          "contentType": "Resource",
          "children": [],
          "root": false
        }
      },
      "lastUpdatedBy": "3b34c469-460b-4c20-8756-c5fce2de9e69"
    }
  }
}
```

Response Body
```
{
    "id": "api.hierarchy.update",
    "ver": "1.0",
    "ts": "2018-11-19T11:51:14.207Z",
    "params": {
        "resmsgid": "6a8cfaf0-ebf1-11e8-90ad-05662c0d1af3",
        "msgid": "6a5f8250-ebf1-11e8-84ae-a1fffa26981c",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content_id": "do_2126371839184814081930"
    }
}
```


## Concepts covered

Course Creation

## Additional Topics

Once the portal is updated successfully, the organization administrator can assign a registered user as the badge issuer through user interface. For details on issuing the badge through the user interface refer [Issuing Badges using User Interface](http://www.sunbird.org/features-documentation/badging_framework/content_badges/)

* © 2018 GitHub, Inc.

