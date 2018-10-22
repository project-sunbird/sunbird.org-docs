---
title: Configuring User Profile 
page_title: Configuring User Profile 
description: Details on how to configure user profile 
keywords: user profile, profile configuration, configure user profile
allowSearch: true
published: true
---

## Overview

When upgrading from any lower version of Sunbird to Sunbird version 1.11, the system runs the Cassandra migration job. When the migration job is run, it automatically does the configuration for user profiles through the **system_settings** table in Cassandra. 

## Prerequisites

1. Access to cassandra database

## Configuring User Profile 

The CQL file version 1.25 holds the script to do the user profile configuration when the Cassandra database migration is done during Sunird version 1.11 upgrade. It does the following user profile configurations in the system_settings table.

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
fields         | List        | List of supported user profile fields. 
publicFields   | List        | Visibility of these fields cannot be changed to private
privateFields  | List        | Visibility of these fields cannot be changed to public
