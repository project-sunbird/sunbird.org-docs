---
title: How to Create a Course
page_title: How to Create a Course
description: Create course for users in Sunbird instance
keywords: create content, create course, content creator, course creator 
published: false
allowSearch: false
---
## Scenario

XYZ corporation, is a global conglomerate that works in the domain of education and collaborates with different institutions, NGOs and academicians around the world. The organization has adopted Sunbird to cater to evolving training needs and amplify learning opportunities. The organization has provided open access to its existing content assets and also offers certification courses to candidates. In order to offer such courses, organizations must create a curriculum, develop modules and add individual entities. Multiple assessments can be grouped together to offer a course. Each course material is comprised of well connected module to aid learning   

On successful completion of the course, the course administrator would like to certify employees  so that it is easy to know who are the employees who have completed this course. 

## Prerequisites

1. The [API Key for access](developer-docs/generating_sunbird_api_keys/) and basic authentication

2. An API client to make API calls. For example use Postman refer [Using Postman](apis/framework/#tag/usingpostman)

3. Access to the [Content API](apis/content/)

## Taskflow

The content on Sunbird can be created using [user interface](feature-documentation/) and through APIs. This document essentially explains the process of creating a course using APIs. The sequence of tasks the organization needs to follow to complete the process of course creation through APIs:

1. Creating Course using [Create Content API](http://docs.sunbird.org/latest/apis/content/#operation/Create%20Content)

	- Path for creating a course: <pre>{{host}}/content/v1/create</pre>

#### Request Body 
	
	{
    "request":
    	{
        "content":
        	{
            "name": "Course",
            "description": "Creating a sample course",
            "creator": "Test",
            "createdBy": "659b011a-06ec-4107-84ad-955e16b0a48a",
            "organisation": ["XYZCorp"],
            "createdFor": ["012567820191629312269"],
            "contentType": "Course",
            "framework": "xyz",
            "mimeType": "application/vnd.ekstep.content-collection",
            "resourceType": "Course"
        	}
    	}
	}

#### Response Body 
	
	{
	"result": 
		{
		"node_id": "string",
		"versionKey": "string"
		},
	"id": "string",
	"ver": "string",
	"ts": "string",
	"params": 
		{
		"resmsgid": "string",
		"msgid": "string",
		"err": "string",
		"status": "string",
		"errmsg": "string"
		},
	"responseCode": {}
	}

2. You can add resources to the course using [Update Hierarchy API](apis/content/#operation/Hierarchy%20Update%20Content)

#### Request Body

<To be added>

#### Response Body
	
<To be added>

## Concepts covered

## Additional Topics 

