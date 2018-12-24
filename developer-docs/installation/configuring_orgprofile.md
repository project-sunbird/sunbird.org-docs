---
title: Configuring Organisation Profile 
page_title: Configuring Organisation Profile 
description: Details on how to configure organisation profile 
keywords: organisation profile, profile configuration, configure organisation profile
allowSearch: true
published: true
---

## Overview

Organisation profile configuration is used to customise organisation functionality without requiring any code changes. 

## Configuring Organisation Profile 

The organisation profile configuration is specified in ```sunbird.system_settings``` Cassandra database table with 'orgProfileConfig' field.

Property Name  | Field Type  | Description
-------------- | ----------- | -----------
csv.supportedColumns | Map | A map of supported Org Bulk Upload input CSV column names to Org API attribute names.
csv.mandatoryColumns | List | A list of attribute names which defines the mandatory columns in Org Bulk Upload input CSV.
csv.outputColumns | Map | A map of Org API attribute names to Org Bulk Upload status output CSV column names.
csv.outputColumnsOrder | List | A list of attribute names which specifies the order of columns in Org Bulk Upload status output CSV.

> **Note:** The list of fields in the following sample code are indicative. You can choose the same set of fields for each block or choose to have a different set of fields. 

### Sample

```
{
    "csv": {
        "supportedColumns": {
            "SCHOOL NAME": "orgName",
            "BLOCK CODE": "locationCode",
            "STATUS": "status",
            "SCHOOL ID": "organisationId",
            "EXTERNAL ID": "externalId",
            "DESCRIPTION": "description"
        },
        "outputColumns": {
            "organisationId": "SCHOOL ID",
            "orgName": "SCHOOL NAME",
            "locationCode": "BLOCK CODE",
            "locationName": "BLOCK NAME",
            "externalId": "EXTERNAL ID"
        },
        "outputColumnsOrder": ["organisationId", "orgName", "locationCode", "locationName", "externalId"],
        "mandatoryColumns": ["orgName", "locationCode", "status"]
    }
}
```
