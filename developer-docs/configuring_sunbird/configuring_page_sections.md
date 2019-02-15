---
title: Configuration for page sections 
page_title: Configuration for page sections
description: Configuration for page sections
published: true
allowsearch: true
keywords: Page management, Page section
---
## Overview
Dynamic pages (consisting of one or more sections) can be configured in LMS for portal and mobile applications. The purpose of this document is to explain page creation.

## Prerequisites
API key is a pre-requisite to use LMS APIs.

## Page configuration
A page can consist of zero or more page sections. As such, to create a page first you need to create the required page sections.

## Create a page section
Use [Create Page Section API](http://docs.sunbird.org/latest/apis/pagesapi/#operation/SectionCreatePost) to create a new page section along with the search query to fetch the required contents (e.g. contents with an ongoing or upcoming open batch, contents with a badge etc.).

## Example 1: Create 'Open for enrollment' page section
Sample request for creating 'Open for enrollment' page section using Create Page Section API is given below. This page section fetches contents with one or more ongoing / upcoming open batches. Note that in below query the open batch count is installation name (e.g. Sunbird_Dev) specific. Format of this attribute is ```c_{sunbird_installation}_open_batch_count```. Likewise the attribute for private batch count is ```c_{sunbird_installation}_private_batch_count```. LMS environment variable ```sunbird_installation``` is used in the mentioned attribute names.

```
{
    "request": {
        "name": "Open for enrollment",
        "sectionDataType": "content",
        "display": {
            "name": {
                "en": "Open for enrollment"
            }
        },
        "searchQuery": {
            "request": {
                "filters": {
                    "contentType": ["Course"],
                    "status": ["Live"],
                    "objectType": ["Content"],
                    "c_Sunbird_Dev_open_batch_count": {
                        ">": "0"
                    }
                },
                "sort_by": {
                    "me_averageRating": "desc"
                },
                "limit": 10
            }
        }
    }
}
```

**Note**: From Release 1.14.0 Sprint 2 onwards, the above mentioned custom attributes for open batch count are always in lowercase to align with content attributes naming convention. As such, the above mentioned page section needs to be updated to use open batch count attribute name converted to lowercase e.g. c_sunbird_dev_open_batch_count (instead of c_Sunbird_Dev_open_batch_count). Use [Update Page Section API](http://docs.sunbird.org/latest/apis/pagesapi/#operation/SectionUpdatePatch) to update any such existing page section.

## Example 2: Create 'Featured content' page section
Sample request for creating 'Featured content' page section using Create Page Section API is given below. This page section fetches contents with specified content type and badge ID.
```
{
    "request": {
        "name": "Featured Content",
        "sectionDataType": "content",
        "display": {
            "name": {
                "en": "Featured Content"
            }
        },
        "searchQuery": {
            "request": {
                "filters": {
                    "contentType": ["Course", "TextBook", "Resource"],
                    "badgeAssertions.badgeId": ["exemplar"],
                    "status": ["Live"]
                },
                "sort_by": {
                    "me_averageRating": "desc"
                },
                "limit": 10,
                "exists": ["badgeAssertions.badgeId"]
            }
        }
    }
}
```

## Create a page
Use [Create Page API](http://docs.sunbird.org/latest/apis/pagesapi/#operation/CreatePost) to create a new page for portal and/or mobile application with one or more page sections.

### Example 1: Create 'explore-course' page with 'Open for enrollment' and 'Featured content' page sections
Sample request for creating 'explore-course' page using Create Page API for both portal and mobile applications is given below. In below, example the page section ID for 'Open for enrollment' and 'Featured content' is 0126471518035476481 and 01228382278062080019 respectively.
```
{
    "request": {
        "name": "explore-course",
        "organisationId": "your-org-id",
        "portalMap": [{
                "id": "0126471518035476481",
                "index": 1,
                "group": 1,
            },
            {
                "id": "01228382278062080019",
                "index": 1,
                "group": 2
            }
        ],
        "appMap": [{
                "id": "0126471518035476481",
                "index": 1,
                "group": 1
            },
            {
                "id": "01228382278062080019",
                "index": 1,
                "group": 2
            }
        ]
    }
}
```
