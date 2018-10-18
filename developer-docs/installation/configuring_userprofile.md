---
title: Configuring User Profile 
page_title: Configuring User Profile 
description: Details on how to configure user profile 
keywords: user profile, profile configuration, configure user profile
allowSearch: true
published: true
---

## Overview

Sunbird Release 1.11, supports user profile configuration through the **system_settings** table in Cassandra.

## Prerequisites

1. Access to cassandra database

## Configuring User Profile 

During cassandra migration for Release 1.11 (CQL file version 1.25) will configure the following user profile configuration in system_settings table.

```
{
  "fields": [
    "firstName",
    "lastName",
    "profileSummary",
    "avatar",
    "countryCode",
    "dob",
    "email",
    "gender",
    "grade",
    "language",
    "location",
    "phone",
    "subject",
    "userName",
    "webPages",
    "jobProfile",
    "address",
    "education",
    "skills",
    "badgeAssertions"
  ],
  "publicFields": [
    "firstName",
    "lastName",
    "profileSummary"
  ],
  "privateFields": [
    "email",
    "phone"
  ]
}
```

Property Name  | Field Type  | Description
-------------- | ----------- | -----------
fields         | List        | List of supported user profile fields
publicFields   | List        | Visibility of these fields cannot be changed to private
privateFields  | List        | Visibility of these fields cannot be changed to public
