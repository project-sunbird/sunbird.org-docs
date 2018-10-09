---
title: How to Create a Course
page_title: How to Create a Course
description: Create course for users in Sunbird instance
keywords: create content, create course, content creator, course creator 
published: false
allowSearch: false
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
    		"name": "string",
    		"code": "string",
    		"os": [
        	"string"
      		],
    	"minOsVersion": "string",
    	"compatibilityLevel": 0,
    	"minGenieVersion": "string",
    	"minSupportedVersion": "string",
    	"filter": "string",
    	"variants": "string",
    	"config": "string",
    	"visibility": [
    		"default",
    		"parent"
    		],
    	"audience": [
    		"Learner",
    		"Instructor"
    		],
    	"posterImage": "string",
    	"badgeAssertions": [
    		{}
    	],
    	"mimeType": [
        	"application/vnd.ekstep.ecml-archive",
        	"application/vnd.ekstep.html-archive",
        	"application/vnd.android.package-archive",
        	"application/vnd.ekstep.content-archive",
        	"application/vnd.ekstep.content-collection",
        	"application/vnd.ekstep.plugin-archive",
        	"application/vnd.ekstep.h5p-archive",
        	"application/epub",
        	"text/x-url",
        	"video/x-youtube",
        	"application/octet-stream",
        	"application/msword",
        	"application/pdf",
        	"image/jpeg",
        	"image/jpg",
        	"image/png",
        	"image/tiff",
        	"image/bmp",
        	"image/gif",
        	"image/svg+xml",
        	"video/avi",
        	"video/mpeg",
        	"video/quicktime",
        	"video/3gpp",
        	"video/mpeg",
        	"video/mp4",
        	"video/ogg",
        	"video/webm",
        	"audio/mp3",
        	"audio/mp4",
        	"audio/mpeg",
        	"audio/ogg",
        	"audio/webm",
        	"audio/x-wav",
       		"audio/wav"
      		],
    	"mediaType": [
        	"content",
        	"collection",
        	"image",
        	"video",
        	"audio",
        	"voice",
        	"ecml",
        	"document",
        	"pdf",
        	"text",
        	"other"
    		],
    	"appIcon": "string",
    	"grayScaleAppIcon": "string",
    	"thumbnail": "string",
    	"objects": "string",
    	"organization": [
    		"string"
    		],
      	"createdFor": [
        	"string"
      		],
      	"developer": "string",
      	"source": "string",
      	"board": "string",
      	"subject": "string",
      	"medium": "string",
      	"notes": "string",
      	"pageNumber": "string",
     	"publication": "string",
      	"edition": "string",
      	"publisher": "string",
      	"author": "string",
      	"owner": "string",
      	"attributions": [
        	"string"
      		],
      	"collaborators": [
        	"string"
      		],
      	"voiceCredits": [
        	"string"
      		],
      	"soundCredits": [
        	"string"
      		],
      	"imageCredits": [
        	"string"
      		],
      	"copyright": "string",
     	"license": [
        	"Against DRM license",
        	"Creative Commons Attribution-NoDerivs (CC-BY-ND)",
        	"Creative Commons Attribution (CC BY)",
        	"Creative Commons Attribution-ShareAlike (CC BY-SA)",
        	"Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)",
        	"Creative Commons Zero (CC0)",
        	"Free Art License",
        	"Open Audio License",
        	"Open Game License",
        	"Standard YouTube License",
        	"Other"
      		],
      	"forkable": true,
      	"translatable": true,
      	"ageGroup": [
        	"<5",
        	"5-6",
        	"6-7",
        	"7-8",
        	"8-10",
        	">10",
        	"Other"
      		],
      	"gradeLevel": [
        	"string"
      		],
      	"topic": [
        	"string"
      		],
      	"interactivityLevel": [
        	"Medium"
      		],
      	"contentType": [
           	"CourseUnit",
        	],
      	"resourceType": [
           	"Course"
     		],
      	"category": [
        	"core",
        	"learning",
        	"literacy",
        	"math",
        	"science",
        	"time",
        	"wordnet",
        	"game",
        	"mcq",
        	"mtf",
        	"ftb",
        	"library"
      		],
		"templateType": [
			"story",
			"worksheet",
			"mcq",
			"ftb",
			"mtf",
			"recognition",
			"activity",
			"widget",
			"other"
		],
		"genre": [
			"Picture Books",
			"Chapter Books",
			"Flash Cards",
			"Serial Books",
			"Alphabet Books",
			"Folktales",
			"Fiction",
			"Non-Fiction",
			"Poems/Rhymes",
			"Plays",
			"Comics",
			"Words"
		],
		"theme": [
			"History",
			],
		"keywords": [
			"string"
			],
		"domain": [
			"string"
			],
		"description": "string",
		"instructions": "string",
		"ownershipType": [
			"string"
			]
			}
		}
	}

#### Response Body 
	
	{
	"result": {
		"node_id": "string",
		"versionKey": "string"
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
