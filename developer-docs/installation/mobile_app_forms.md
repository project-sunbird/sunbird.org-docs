---
type: landing
directory: 
title: Mobile app forms
page_title: Mobile app forms
description: Forms relatd to Mobile App 
keywords: 'App, form, Sunbird, Create form, update form, read form'
published: true
allowSearch: true
---

## Forms in Mobile App

**The following table lists down the available forms in Mobile app component:**

| Form | Description | Type | Subtype| Action| Component
| --- | --- |------| ------| ------| ------|
| **Force/Optional Upgrade** | This form is used to save/update/read or force/optional app upgrade | app | install | upgrade | app
| **Filter config for Course filter** | This form is used to get filter for courses | pageAssemble | course | filter | app
| **Filter config for Library filter** | This form is used to filter for library | pageAssemble | library | filter | app

### Input & Data Types 

**The following table lists down the supported input types with corresponding data types in Mobile app component:**

| Data Type | Input Type |
| --- | --- |
| String | text, number |
| List | fields, range |
| type | force, optional |

### JSON Structure definitions

**The following table lists down the example JSON structure with descriptions for each form in the Mobile app component:**

| Property Name | Type | Description | Default Value | Example |
| --- | --- | --- | --- | --- |
| templateName | `string` | The default template used for the form | NA |defaultTemplate, defaultApp UpgradeTemplate|
| code | `string` | Unique identifier of the field on the form | NA | upgrade, syllabus,topic,purpose etc|
| name | `string` | Name of the field on the form | NA |Upgrade of the  app, What syllabus do you follow?|
| language | `string` | Represents the display language of the field on a form | NA |en,hi,ta|
| range | `list` |  Represents the range of all the values specific to a particular field in a form | NA |  "templateName":"defaultTemplate", "action":"onboarding", "fields":[]|
| minVersionCode | `string`| Represents the minimum version of the app | NA |0,9|
| maxVersionCode | `string` | Represents the maximum version of the app | NA |10,15|
| versionName | `string` | Represents the name of version | NA | v1.0.1|
| type | `string` | Represents the type of the upgrade that is required | NA | optional, force|
| frameworkCategory | `boolean` | Specifies whther the code is part of framework or not  | NA | true, false|