---
title: How to Create a Course
page_title: How to Create a Course
description: Create course for users in Sunbird instance
keywords: create content, create course, content creator, course creator 
published: true
allowSearch: true
---
## Scenario

XYZ Corporation, is a global conglomerate that works in the domain of education and collaborates with different institutions, NGOs and academicians around the world. The organization has adopted Sunbird to cater to evolving training needs and amplify learning opportunities. The organization has provided open access to its existing content assets. The organization also offers certification courses to candidates. In order to offer such courses,   Multiple assets can be grouped together to offer a course.  

On successful completion of the course, the course administrator would like to certify employees  so that it is easy to know who are the employees who have completed this course. 

## Prerequisites

1. The [API Key for access](http://www.sunbird.org/apis/) and basic authentication

2. An API client to make API calls. For example use Postman refer [Using Postman](http://www.sunbird.org/apis/framework/#tag/usingpostman)

3. Access to the [Content API](http://docs.sunbird.org/latest/apis/content/)

## Taskflow

The content on Sunbird can be created using [user interface](feature-documentation/) and through APIs. Content in sunbird can be of different types:

1. Courses 
2. Collections
3. Resourses
4. Lesson Plan
5. Book

This document essentially explains the process of creating content using APIs. The sequence of tasks the organization needs to follow to complete the process of course creation through APIs:

1. Creating Course using [Create Content API](http://docs.sunbird.org/latest/apis/content/#operation/Create%20Content)

	- Path for creating a course: <pre>{{host}}/content/v1/create</pre>

#### Request Body 
	
	{
		"request": {
			"content": {
			"name": "training content",
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
			"contentType": "Course",
			"framework": "NCF",
			"mimeType": "application/vnd.ekstep.content-collection",
			"resourceType": "Course"
			}
		}
	}

#### Response Body 
	
	{
		"id": "api.content.create",
		"ver": "1.0",
		"ts": "2018-11-12T15:09:39.006Z",
		"params": {
			"resmsgid": "f978e5e0-e68c-11e8-baf5-3dae6351f44e",
			"msgid": "f9727d40-e68c-11e8-9d9c-9fb82598856b",
			"status": "successful",
			"err": null,
			"errmsg": null
		},
		"responseCode": "OK",
		"result": {
			"content_id": "do_112632353824178176130",
			"versionKey": "1542035378927"
		}
	}

2. Uploading courses using [Upload Content API](http://docs.sunbird.org/latest/apis/content/#operation/Upload%20Content)

	- Path for uploading a course:<pre>{{host}}/upload/{Content_ID}</pre>   

#### Request Body
	
	{
	"result": {
		"node_id": "string",
		"versionKey": "string",
		"content_url": "string"
		},
	"id": "string",
	"ver": "string",
	"ts": "string",
	"params": {
		"resmsgid": "string",
		"msgid": "string",
		"err": "string",
		"status": "string",
		"errmsg": "string"
		},
	"responseCode": {}
	}

#### Response Body

	{
	"request": {
		"filters": {
		"channel": "string",
		"objectType": [
			"string"
		],
		"contentType": [
			"string"
		],
		"status": [
			"string"
		]
		},
		"sort_by": {
		"createdOn": "string"
		},
		"fields": [
		"string"
		]
	}
	}

3. Creating course using [Create Course API](http://docs.sunbird.org/latest/apis/courseprogressapi/#tag/Course-Progress-API) 

Uploading a resource type content
	- Path for uploading a course:<pre>{{host}}POST/content/v3/upload/{content_ID}</pre>   

#### Request Body

	URL: 
	Path Parameter
	Path Parameter
	Parameter Type
	Description
	Is Mandatory
	Content ID
	Resource
	Content ID to Request URL
	Yes

	Form Parameter 
	Form Data Parameter
	Parameter Type
	Description
	Is Mandatory 
	ID
	uploadContent
	Content package file which is being uploaded
	Yes

#### Response Body
	
	{
	"responseCode": "OK",
	"result": 
		{
		"content_url": "https://ekstep-public-dev.s3-ap-south-1.amazonaws.com/content/do_1125678814402068481125/artifact/uploadcontent_1534165325742.zip",
		"node_id": "do_1125678814402068481125",
		"versionKey": "1534165326149"
		}
	}

## Concepts covered

**Content Creation**

## Additional Topics

Once the portal is updated successfully, the organization administrator can assign a registered user as the badge issuer through user interface. For details on issuing the badge through the user interface refer 
[Issuing Badges using User Interface](http://www.sunbird.org/features-documentation/badging_framework/content_badges/)
