---
title: Configuring User Profile 
page_title: Configuring User Profile 
description: Details on how to configure user profile 
keywords: user profile, profile configuration, configure user profile
allowSearch: true
published: true
---

## Overview

Since Sunbird release-1.11, user profile configurations are maintained in system_settings table in cassandra

## Prerequisites

1. Access to cassandra database

## Configuring User Profile 

Cassandra migration version 1.25 will configure the following user profile configurations in system_settings table

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

> fields - User data fields in Sunbird

> publicFields - The visibility of these fields cannot be changed to private

> privateFields - The visibility of these fields cannot be changed to public
