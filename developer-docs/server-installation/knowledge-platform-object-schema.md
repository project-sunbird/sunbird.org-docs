---
title: Knowledge Platform Object Schema
page_title: Knowledge Platform Object Schema
description: Explains how to create schemas for knowledge platform objects
keywords: Knowledge Platform objects, schemas, definition
allowSearch: true
---


## Description

Most of the database follow schema oriented structure. But neo4j support schema-less data structure. But for validating specific metadata for the specific data object we need schema.
Knowledge Platform uses Graph Engine to communicate with neo4j. Graph Engine expects schema definition for each object type. It validates data object with the object definition during various CRUD operation.

When we set up the environment and start neo4j, we need to have definition objects available in neo4j. Without these object, Graph Engine will not be able to create any data object.

### Process for setting up the definition object

- Currently Knowledge Platform supports various types of objects.
- As part of adding definition schema, all the definition object should be created in neo4j.
- Knowledge Platform provides Save Definition API which will either add or update existing schema and Get Definition object API which will fetch definition object schema details.
- There are various object types definition, which are available in [Knowledge Platform repository](https://github.com/project-sunbird/sunbird-learning-platform/tree/release-2.0.0/docs/domain_model_v2/definitions).
- Ex: [content_definition.json](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions/content_definition.json), [framework_definition.json](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions/framework_definition.json)
- These definitions can be on-boarded via calling API or via running Jenkins job.

### Update Definition (using API):
- Use Definition Save API, to add/update object definition. Definition can be fetched using Definition Get API.
- Path for Save Definition: `/action/taxonomy/domain/definition/<Object Type>`

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
#### Response Body to Save Object Definition (sample request body for Term):
```
{
    "responseCode": "OK",
    "result": {}
}
```

### Update Definition (Using Jenkins Job):
- Object Definition can also be updated using Jenkins job.
- Below is the Jenkins job file path:
`jenkins/Deploy/dev/KnowledgePlatform/Neo4jDefinitionUpdate`
- Script path for Jenkins file:
`pipelines/deploy/neo4j-definition-update/Jenkinsfile`
- It will read definition files of all the object available in [Knowledge Platform](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-2.0.0/docs/domain_model_v2/definitions) and update all the definition.

