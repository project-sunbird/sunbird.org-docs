---
title: Knowledge Platform Object Schema
page_title: Knowledge Platform Object Schema
description: Explains how to create schemas for knowledge platform objects
keywords: Knowledge Platform objects, schemas, definition
allowSearch: true
---


## Overview

Most databases follow schema oriented structures. However, Neo4j supports schema-less data structure. The schema is required to validate specific metadata of specific data objects.

The Knowledge Platform uses the Graph engine to communicate with Neo4j. The Graph engine expects schema definitions for each object type. It validates the data object with the object definition during various CRUD operations.

After setting up the environment and starting Neo4j, it is mandatory to have definition objects available in Neo4j. The Graph engine cannot create any data objects without these objects. 

## Knowledge Platform and Definition Schema

The Knowledge Platform supports various types of objects. To add definition schema, all the definition objects must be created on Neo4j. The Knowledge Platform provides the `Save Definition` API that either adds or updates existing schema and the `Get Definition` object API that fetches definition object schema details. There are various object types of definition that are available in the [Knowledge Platform repository](https://github.com/project-sunbird/sunbird-learning-platform/tree/release-2.0.0/docs/domain_model_v2/definitions). For example, [content_definition.json](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions/content_definition.json), [framework_definition.json](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions/framework_definition.json).These definitions can be on-boarded using APIs or by running the Jenkins job.

### Update Definition (using API)
To add/update object definitions, use the `Save Definition` API. You can fetch the definitions using `Get Definition' API. The path for the Save Definition `/action/taxonomy/domain/definition/<Object Type>`


#### Request Body to Save Object Definition (sample request body for Term):
```
{
  "definitionNodes": [
    {
      "objectType": "Term",
      "properties": [
        {
          "propertyName": "name",
          "title": "Name",
          "description": "Name of the Term",
          "category": "General",
          "dataType": "Text",
          "required": true,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'text', 'order': 1}",
          "indexed": true
        },
        {
          "propertyName": "code",
          "title": "Code",
          "description": "Code of the Term",
          "category": "General",
          "dataType": "Text",
          "required": true,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'text', 'order': 2}",
          "indexed": true
        },
        {
          "propertyName": "category",
          "title": "Category",
          "description": "Category of the Term",
          "category": "General",
          "dataType": "Text",
          "required": true,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'text', 'order': 2}",
          "indexed": true
        },
        {
          "propertyName": "translations",
          "title": "Translations",
          "description": "Translations for the term",
          "category": "General",
          "dataType": "JSON",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'object', 'order': 2}",
          "indexed": true
        },
        {
          "propertyName": "index",
          "title": "Index",
          "description": "Index position of the term",
          "category": "General",
          "dataType": "Number",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'number', 'order': 3}",
          "indexed": false
        },
        {
          "propertyName": "description",
          "title": "Description",
          "description": "description of the term",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{'inputType': 'text', 'order': 1}",
          "indexed": true
        },
        {
          "propertyName": "status",
          "title": "Status",
          "description": "Status of the term",
          "category": "general",
          "dataType": "Select",
          "range": [
            "Draft",
            "Live",
            "Review",
            "Retired"
          ],
          "required": false,
          "indexed": true,
          "displayProperty": "Editable",
          "defaultValue": "Live",
          "renderingHints": "{'inputType': 'select', 'order': 3}"
        },
        {
          "propertyName": "createdBy",
          "title": "Created By",
          "description": "",
          "category": "audit",
          "dataType": "Text",
          "range": [],
          "required": false,
          "indexed": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{ 'inputType': 'text',  'order': 4}"
        },
        {
          "propertyName": "createdOn",
          "title": "Created On",
          "description": "",
          "category": "audit",
          "dataType": "Date",
          "range": [],
          "required": false,
          "indexed": false,
          "displayProperty": "Readonly",
          "defaultValue": "",
          "renderingHints": "{ 'order': 11 }"
        },
        {
          "propertyName": "lastUpdatedBy",
          "title": "Last Updated By",
          "description": "",
          "category": "audit",
          "dataType": "Text",
          "range": [],
          "required": false,
          "indexed": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "{ 'inputType': 'text',  'order': 5}"
        },
        {
          "propertyName": "lastUpdatedOn",
          "title": "Last Updated On",
          "description": "",
          "category": "audit",
          "dataType": "Date",
          "range": [],
          "required": false,
          "indexed": false,
          "displayProperty": "Readonly",
          "defaultValue": "",
          "renderingHints": "{ 'order': 6}"
        },
        {
          "propertyName": "consumerId",
          "title": "consumerId",
          "description": "R1.15",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        },
        {
          "propertyName": "appId",
          "title": "appId",
          "description": "R1.15",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        },
        {
          "propertyName": "channel",
          "title": "Channel",
          "description": "Channel Id of Framework Creator",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        },
        {
          "propertyName": "lastStatusChangedOn",
          "title": "lastStatusChangedOn",
          "description": "Timestamp of last status update",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        },
        {
          "propertyName": "label",
          "title": "Label",
          "description": "R-1.15-Label",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        },
        {
          "propertyName": "value",
          "title": "value",
          "description": "R-1.15-Value",
          "category": "General",
          "dataType": "Text",
          "required": false,
          "displayProperty": "Editable",
          "defaultValue": "",
          "renderingHints": "",
          "indexed": true
        }
      ],
      "inRelations": [
        {
          "relationName": "hasSequenceMember",
          "objectTypes": [
            "Category"
          ],
          "title": "categories",
          "description": "Categories using the term",
          "required": false,
          "renderingHints": "{ 'order': 7}"
        },
        {
          "relationName": "hasSequenceMember",
          "objectTypes": [
            "CategoryInstance"
          ],
          "title": "categories",
          "description": "CategoryInstance using the term",
          "required": false,
          "renderingHints": "{ 'order': 8}"
        },
        {
          "relationName": "associatedTo",
          "objectTypes": [
            "Content"
          ],
          "title": "contents",
          "description": "Content associated with the term",
          "required": false,
          "renderingHints": "{ 'order': 9}"
        },
        {
          "relationName": "hasSequenceMember",
          "objectTypes": [
            "Term"
          ],
          "title": "parents",
          "description": "Parent terms (in sorted order)",
          "required": false,
          "renderingHints": "{ 'order': 10}"
        },
        {
          "relationName": "associatedTo",
          "objectTypes": [
            "Term"
          ],
          "title": "associationswith",
          "description": "Terms from which the current term is associated",
          "required": false,
          "renderingHints": "{ 'order': 11}"
        }
      ],
      "outRelations": [
        {
          "relationName": "hasSequenceMember",
          "objectTypes": [
            "Term"
          ],
          "title": "children",
          "description": "Child terms (in sorted order)",
          "required": false,
          "renderingHints": "{ 'order': 12}"
        },
        {
          "relationName": "associatedTo",
          "objectTypes": [
            "Term"
          ],
          "title": "associations",
          "description": "Terms associated with the current term",
          "required": false,
          "renderingHints": "{ 'order': 13}"
        }
      ],
      "systemTags": [],
      "metadata": {
        "ttl": 0.08,
        "limit": 50,
        "fields": [
          "identifier",
          "name",
          "code",
          "description",
          "category",
          "status",
          "translations"
        ]
      }
    }
  ]
}
```
#### Response Body to Save Object Definition (sample response body for Term):

```
{
    "responseCode": "OK",
    "result": {}
}
```

### Update Definition (Using Jenkins Job):

You can also update Object Definitions using Jenkins job. The following is the Jenkins job file path:
`jenkins/Deploy/dev/KnowledgePlatform/Neo4jDefinitionUpdate`

The script path for the Jenkins file:
`pipelines/deploy/neo4j-definition-update/Jenkinsfile`

This job reads the definition files of all the objects available in the [Knowledge Platform](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions) and updates all the definitions.


