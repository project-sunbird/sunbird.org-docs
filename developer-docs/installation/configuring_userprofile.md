---
title: Configuring User Profile 
page_title: Configuring User Profile 
description: Details on how to configure user profile 
keywords: user profile, profile configuration, configure user profile
allowSearch: true
published: true
---

## Overview

User profile configuration is used to customise user functionality without requiring any code changes. 

## Prerequisites

1. Access to cassandra database

## Configuring User Profile 

The user profile configuration is specified in ```sunbird.system_settings``` Cassandra database table with 'userProfileConfig' field.

Property Name  | Field Type  | Description
-------------- | ----------- | -----------
fields         | List        | A list of supported user profile fields. The list of fields in the following sample code are indicative. You can choose the same set of fields for each block or choose to have a different set of fields. 
publicFields   | List        | A list of fields that are publicly visible. The user cannot modify these fields to be privately visible. 
privateFields  | List        | A list of fields that are privately visible.  The user cannot modify these fields to be publicly visible. 
csv.supportedColumns | Map | A map of supported User Bulk Upload input CSV column names to User API attribute names.
csv.mandatoryColumns | List | A list of attribute names which defines the mandatory columns in User Bulk Upload input CSV.
csv.outputColumns | Map | A map of User API attribute names to User Bulk Upload status output CSV column names.
csv.outputColumnsOrder | List | A list of attribute names which specifies the order of columns in User Bulk Upload status output CSV.
read.excludedFields | List | A list of attribute names which can be excluded from Get User by User ID API.
framework.fields | List | A list of framework fields supported in User profile.
framework.mandatoryFields | List | A list of mandatory framework fields in User profile.

> **Note:** The list of fields in the following sample code are indicative. You can choose the same set of fields for each block or choose to have a different set of fields. 

### Sample

```
{
    "fields": ["firstName", "lastName", "profileSummary", "avatar", "countryCode", "dob", "email", "gender", "grade", "language", "location", "phone", "subject", "userName", "webPages", "jobProfile", "address", "education", "skills", "badgeAssertions"],
    "publicFields": ["firstName", "lastName", "profileSummary"],
    "privateFields": ["email", "phone"],
    "csv": {
        "supportedColumns": {
            "NAME": "firstName",
            "MOBILE PHONE": "phone",
            "EMAIL": "email",
            "SCHOOL ID": "orgId",
            "USER_TYPE": "userType",
            "ROLES": "roles",
            "USER ID": "userId",
            "SCHOOL EXTERNAL ID": "orgExternalId"
        },
        "outputColumns": {
            "userId": "USER ID",
            "firstName": "NAME",
            "phone": "MOBILE PHONE",
            "email": "EMAIL",
            "orgId": "SCHOOL ID",
            "orgName": "SCHOOL NAME",
            "userType": "USER_TYPE",
            "orgExternalId": "SCHOOL EXTERNAL ID"
        },
        "outputColumnsOrder": ["userId", "firstName", "phone", "email", "organisationId", "orgName", "userType", "orgExternalId"],
        "mandatoryColumns": ["firstName", "userType", "roles"]
    },
    "read": {
        "excludedFields": ["userName", "avatar", "jobProfile", "address", "education", "webPages", "skills"]
    },
    "framework": {
        "fields": ["board", "gradeLevel", "medium", "subject"],
        "mandatoryFields": ["board", "gradeLevel", "medium"]
    }
}
```
