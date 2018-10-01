---
title: Create Content
page_title: Create Content
description: Create a content for a user in Sunbird instance
keywords: create content, create course, content creator, course creator 
published: true
allowSearch: true
---
## Scenario

XYZ Corporation is a global conglomerate which works in the domain of education and collaborates with different institutions, NGOs and academicians, in multiple regions of the world. The organization has adopted Sunbird and aims at creating content for all its stakeholders in order to cater to the evolving training needs and amplify learning opportunities. The organization allows all its stakeholders to access to the existing content assets and at the same time allows each of the stakeholder to create their own content. 

On successful completion of the course, the course administrator would like to certify these trainees so that it is easy to know who are the employees who have completed this course. 

## Prerequisites

1. The [API Key for access](http://www.sunbird.org/apis/) and basic authentication

2. An API client to make API calls. For example use Postman refer [Using Postman](http://www.sunbird.org/apis/framework/#tag/usingpostman)

3. Access to the [Content API](http://docs.sunbird.org/latest/apis/content/)

## Taskflow

Content in sunbird can be of different types:

1. Courses 
2. Collections

The sequence of tasks the organization needs to follow to complete the process of course creation:

1. Creating Resources using [Create Content API](http://docs.sunbird.org/latest/apis/content/#operation/Create%20Content)

1. Path for creating the Framework: <pre>{{host}}/content/v1/create</pre>

#### Request Body for creating a resource type content (Sample data)

	URL : 

#### Request Body 
	{
	"request": 
		{
		"content":
			{
			"name": "Resource1",
			"code": "Resource1",
			"mimeType": "application/pdf",
			"contentType":"Resource"
			}
		}
	}

#### Response Body 
	{
	"responseCode": "OK",
	"result": 
		{
		"node_id": "do_1125678814402068481125",
		"versionKey": "1534165214869"
		}
	}

1. Uploading content using [Upload Content API](http://docs.sunbird.org/latest/apis/content/#operation/Upload%20Content)

1. Creating collections using [Create Course API](http://docs.sunbird.org/latest/apis/courseprogressapi/#tag/Course-Progress-API) 

Uploading a resource type content

#### Request Body

	URL: POST /content/v3/upload/{content_ID}
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

Sample request body for creating collection (example: Textbook, Course, Textbook unit etc)(Sample data)
URL: POST /content/v3/create
Request Payload::
	{
	"request": 
		{
		"content": 
			{
			"name": "TextBook1",
			"code": "TextBook1",
			"mimeType": "application/vnd.ekstep.content-collection",
			"contentType":"TextBook"
			}
		}
	}

#### Response Body 
	{
	"responseCode": "OK",
	"result": 
		{
		"node_id": "do_1125698099506380801185",
		"versionKey": "1534400628740"
		}
	}

Updating content collection hierarchy

#### Request Body 

URL: POST /content/v3/hierarchy/update
Request Payload::
	{
	"request": 
		{
		"data": 
			{
				"nodesModified": 
				{
				"30b0cc0c-18dc-4462-9b2b-8390b90dd3acb": 
					{
					"isNew": true,
					"root": false,
					"metadata": {
					"name": "TextBookUnit1",
					"contentType": "TextBookUnit",
					"mimeType": "application/vnd.ekstep.content-collection"
					}
				}
			},
		"hierarchy": 
			{
			"do_1125698099506380801185": 
				{
				"contentType": "TextBook",
				"children": ["30b0cc0c-18dc-4462-9b2b-8390b90dd3acb"],
				"root": true
				},
				"30b0cc0c-18dc-4462-9b2b-8390b90dd3acb":  
				{
				"name": "TextBookUnit1",
				"contentType": "TextBookUnit",
				"children": ["do_1125698076546416641184"],
				"root": false
				}
			}
		}
	}

#### Response Body 
	{
		"responseCode": "OK",
		"result": 
		{
		"content_id": "do_1125698099506380801185",
		"identifiers": 
			{
			"30b0cc0c-18dc-4462-9b2b-8390b90dd3acb": "do_1125698113874165761186"
			}
		}
	}

## Concepts covered

**Content Creation**

## Additional Topics

Once the portal is updated successfully, the organization administrator can assign a registered user as the badge issuer through user interface. For details on issuing the badge through the user interface refer 
[Issuing Badges using User Interface](http://www.sunbird.org/features-documentation/badging_framework/content_badges/)