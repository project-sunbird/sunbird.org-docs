---
title: Configure Reviewer Checklist
page_title: Configure Reviewer Checklist
description: Technical document on configuring checklist for reviewer
published: true
allowSearch: true
---

## Overview

Any content published on Sunbird undergoes a review to ensure that published content adheres to defined guidelines and standards set by the organization. Each organization can set guidelines based on their organization standards. Sunbird provides the feature of configuring review checklist. Any adopter can use this feature and configure checklists for the review process. A content reviewer on Sunbird can perform the following activities: 

a. Request changes in the content submitted for review
b. Publish the content submitted for review

Currently, before a content piece is published, the reviewer validates the content with a pre-defined checklist. This checklist can be configured based on organization requirements. This page details the procedure on how to configure the review checklist. Configurations are supported at the following two levels:

a. Instance level
b. Channel level

When configuration is done for the Channel, it overrides configurations done for the Instance. 

> Note: Configurations are set internally, users can override default configuration to customize checklists for organizational requirements.

Different configuration can be defined differently for the following content types:

* Course
* Textbook
* Resource and Collection

## UI Display with Default Configurations
The UI display, when there are no configurations set for the checklist, is as described:

1. When requesting changes to content, an information message **Please detail the required changes in the comments** is displayed. Enter the comments here to enable the **Request Changes** button.

2. When publishing reviewed content, a confirmation message **Are you sure you want to publish?** is displayed. Click the **Publish** button to publish content.

## UI Display with Customized Configurations 

The UI display, when configurations are set for the checklist, is as described:

1. When requesting changes to content, the configured checklist is displayed with a comment box. The reviewer must select atleast one checkbox and provide comments in the comment box to enable **Request Changes** button.

2. When publishing reviewed content, the configured checklist is displayed with a comment box. The reviewer must select atleast one checkbox to enable **Publish** button

3. In case of any system failure while requesting changes to content or while publishing reviewed content, an error message **Something went wrong. Please try again later** is displayed

## Configuring Review Checklist

Use the create/update form API with the following API request

**Sample API request for Request Changes with configuration:**


	{
		"request": {
			"type": "content",
			"action": "requestforchanges",
			"subType": "resource",
			"data": {
				"templateName": "defaultTemplate",
				"action": "requestforchanges",
				"fields": [{
					"title": "Please tick the reasons for requesting changes and provide detailed comments:",
					"otherReason": "Other Issue(s) (if there are any other issues, tick this and provide details in the comments box)",
					"contents": [{
							"name": "Appropriateness",
							"checklist": [
								"Has Hate speech, Abuse, Violence, Profanity",
								"Has Sexual content, Nudity or Vulgarity",
								"Has Discriminatory or Defamatory content",
								"Is not suitable for children"
							]
						},
						{
							"name": "Content details",
							"checklist": [
								"Inappropriate Title or Description",
								"Incorrect Board, Grade, Subject or Medium",
								"Inappropriate tags such as Resource Type or Concepts",
								"Irrelevant Keywords"
							]
						},
						{
							"name": "Usability",
							"checklist": [
								"Content is NOT playing correctly",
								"CANNOT see the content clearly on Desktop and App",
								"Audio is NOT clear or NOT easy to understand",
								"Spelling mistakes found in text used",
								"Language is NOT simple to understand"
							]
						}
					]
				}]
			}
		}
	}


**Sample API request for Publish option with configuration:**

	{
		"request": {
			"type": "content",
			"action": "publish",
			"subType": "resource",
			"data": {
				"templateName": "defaultTemplate",
				"action": "publish",
				"fields": [{
					"title": "Please confirm that ALL the following items are verified (by ticking the check-boxes) before you can publish:",
					"contents": [{
							"name": "Appropriateness",
							"checklist": [
								"No Hate speech, Abuse, Violence, Profanity",
								"No Sexual content, Nudity or Vulgarity",
								"No Discrimination or Defamation",
								"Is suitable for children"
							]
						},
						{
							"name": "Content details",
							"checklist": [
								"Appropriate Title, Description",
								"Correct Board, Grade, Subject, Medium",
								"Appropriate tags such as Resource Type, Concepts",
								"Relevant Keywords"
							]
						},
						{
							"name": "Usability",
							"checklist": [
								"Content plays correctly",
								"Can see the content clearly on Desktop and App",
								"Audio (if any) is clear and easy to understand",
								"No Spelling mistakes in the text",
								"Language is simple to understand"
							]
						}
					]
				}]
			}
		}
	}

