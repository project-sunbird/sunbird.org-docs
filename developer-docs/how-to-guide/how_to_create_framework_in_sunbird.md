---
title: Create Framework
page_title: Create Framework
description: Create a new framework in Sunbird instance
keywords: create framework, new framework, create, framework
published: true
allowSearch: true
---
## Prelude

Before we get into details of how to create a new framework in Sunbird, its important to explain the concepts and differences between a **Taxonomy** and **Framework**. Both a taxonomy and framework describe the same domain. A taxonomy is an arrangement or division according to a predetermined system, while a framework is the resultant catalog that gives freedom for discussion, analysis and information retrieval. The framework extends the knowledge model of a taxonomy. The intent of creating a framework is to enable organizations organize their content in a structure which is easily discoverable. Within Sunbird, the main objective of the framework is to ensure that content creators have an easy interface to tag content with relevant metadata. Appropriate metadata allows user to search for content and get relevant results. Separating the taxonomy from its extension, in the form of framework(s) provides experts and pedagogues the power and flexibility to model and tag content. The framework consists of categories and terms within a specific domain.

Sunbird enables seamless access and discoverability of content through a framework. An organization can use existing framework categories (concepts) and terms (specifications) and further link them to their own framework.

## Scenario
Let us consider an example of an organization, ABC Organization, which works in the domain of water conservation and works with multiple NGOs, village panchayats, and district administration authorities in multiple states of India. They need to create the framework for the water management domain. Their framework will have terms associated with categories specific to the domain. The following example depicts the categories and terms specifically used for the water management framework:

| Framework Name | Categories            | Terms              |
|----------------|-----------------------|--------------------|
| ABC            | Resources             | River, Spring, Sea |
|                | Governance            | Local, State, Central |
|                | Funds                 | State, Central, Global|

ABC Organization, may choose a predefined category and associate it to their own framework. Each category in the framework has terms associated with it. These terms are relevant to the created framework and can be created by the organization. 

While creating a new framework, the framework creator needs to set up a new framework and align it to the categories and terms. A category can have terms either in sequential list or in hierarchical structure. Terms can be associated with other terms across categories. As a result, it is possible to select a term in the first category and hence restrict the set of available terms for the next category and so on. The organizations that are adopting Sunbird can link the categories and also change the labels but cannot override or add a new categories on their own. However, the Sunbird instance has the following categories in its predefined frameworks:

```
- Subject: Classification of stream specific values
- Curriculum: Certifying body/stream government or private organization
- Grade Level: Maturity level for knowledge  
- Medium: Language of the course 
- Topic: Details of the concept
```

Send a mail to [Sunbird Team](info@sunbird.org), if you want to create a new master category that is not part of Sunbird's predefined category list. You can however select and rename an existing category
 
For example, for ABC organization the framework name is ABC and code is abc1. The category **Subject** is renamed to **Resources**. The **Resources** category defines the various water resources and has the terms as River, Spring, Sea and so on. 

## Prerequisites

1. An intialized Sunbird instance with the channel 

2. The [API Key for access](../developer-docs/generating_sunbird_api_keys/) to required APIs and basic authentication
  
3. Software that can make API calls like curl or POSTMAN

4. Creation of the following entities with appropriate access permissions:
   - Admin user (created using Keycloak) who has permissions to create an organization
   - [Individual Organization](../apis/orgapi/#operation/Organisation%20Create)
   - [Individual user](../apis/userapi/#operation/Create%20User) 
   - [Mapping of created user(s) to the organization](../apis/orgapi/#operation/Organisation%20Add%20User)

5. Access to [Framework API](../apis/framework/)

## Taskflow
 
The sequence of tasks the organization administrator follows to create a framework includes:

### Creating Framework

1. Use the [Create Framework API](../apis/framework/#operation/FrameworkV1CreatePost), to create a new framework. Specify values for the parameters in the request body of the API. 

2. Path for creating the Framework: ```{{host}}/framework/v1/create```

>**Host**: The URL of the installed Sunbird instance

Following is an example of request body for creating a framework, the sample values provided in the request body are indicative:
To retrieve the channels for the request parameter, use [List Channel API](../apis/framework/#operation/ChannelV1ListPost) 

##### Request Body to Create Framework
    {
    "request": {
        "framework": {
            "name": "ABC",
            "code": "abc",
            "description": "Framework for ABC Management",
            "translations": {"hi":"ABC-अनुवाद","ta":"ABC மொழிபெயர்ப்பு"},
            "type": "Others",
            }
        }
    } 

**Description of Parameters**

Name: The name of the framework as provided by the organization

Code: A user defined value that is used as the framework identifier 

Description: Describes the framework

Translations: Enables framework in different languages 

Type: Non mandatory field that defines the type of framework and permissible values K-12, TPD, Agri, Others

##### Response Body to Create Framework
    {
    "responseCode": "OK",
    "result": {
        "framework": {
            "identifier": "abc1",
            "code": "abc",
            "translations": "{\"hi\":\"ABC-अनुवाद\",\"ta\":\"ABC மொழிபெயர்ப்பு\"}",
            "name": "ABC",
            "description": "Framework for ABC Management",
            "type": "Others",
            }
        }
    }

**Description of Parameters**

Identifier: The name of the framework as provided by the organization

Code: A user defined value that is used as the framework identifier 

Translations: Enables framework in different languages 

Name: Name of the organization 

Description: Describes the framework

Type: Defines the type of content

### Validating a Category

1. Use [Search Category API](../apis/framework/#operation/FrameworkV1CategorySearchPost) to fetch the list of the available master categories.

Path for searching the category: ```{{host}}/framework/v1/category/master/search```

##### Request Body for Searching Master Categories
    {
        "request": {
            "search":{
            "status":"Live"
            }
        } 
    }

**Description of Parameters**

Status: The depict the category with **Live** status

##### Response Body for Searching Master Categories
    {
    "responseCode": "OK",
    "result": {
        "count": 5,
        "categories": [
            {
                "identifier": "board",
                "code": "board",
                ...
                "status": "Live"
            },
            {
                "identifier": "gradeLevel",
                "code": "gradeLevel",
                ...
                "status": "Live"
            },
            {
                "identifier": "subject",
                "code": "subject",
                ...
                "status": "Live"
            },
            {
                "identifier": "medium",
                "code": "medium",
                ...
                "status": "Live"
            },
            {
                "identifier": "topic",
                "code": "topic",
                ...
                "status": "Live"
            },
            ]
        }
    }

**Description of Parameters**

Identifier: The name of the existing category 

Code: A defined value that is used as the category identifier. Currently, 5 codes are supported as board, gradelevel, subject, medium, and topic.  

Status: Depicts the status of the Category 

> Note: If you need to add a master category that doesnot exist in the master list of the existing category, you must send a request to <a href="mailto:info@sunbird.org?subject=New Category Request">Sunbird Team</a>. The request must have following values:
>   - Name of the category 
>   - Description 
>   - Data type of the category is string (contain Alphanumeric values and )
> 
> The Sunbird team sends the attributes of the created category   

### Configuring Category for the Instance

The ABC organization with the framework **ABC** and code as abc1; the category selected is Subject and the label is modified as **Resources** which defines the various water resources and contains the terms as River, Spring, Sea.

1. Use the [Add Category API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CreatePost), to create a new category in the framework. 

2. Path for adding the category: ```{{host}}api/framework/v1/category/create```

The sample values provided in the request body are indicative. The API describes the procedure to change the label(resources) of an existing category(subject):

##### Request Body for creating Category
    {
    "request": {
    "category": {
        "code": "subject",
        "name": "Resource",
        "description": "string",
        }
    }

**Description of Parameters**

Code: A user defined value that is used as the category identifier

Name: The name of the category 

Description: Short introduction of the category

##### Response Body for creating Category
    {
        "responseCode": "OK",
        "result": {
            "node_id": "abc_resource",
            "versionKey": "1535716551605"
            }
    }

**Description of Parameters**

Node_ID: The name of the framework as provided by the organization

VersionKey: Identifies the version of changed Category 

### Creating a Term

1. Use the [Add Term API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1TermCreatePost), to create a new term in the category.
The categories can be retrieved and listed using [Fetch API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CategoryReadClassGet). The sample values provided in the request body are indicative.

2. Path for creating category: `{{host}}/framework/v1/term/create?framework=abc1&category=subject`

##### Request Body to Create Terms 

    {
    "request": {
        "term": [
            {
            "code": "river",
            "name": "River",
            "description":"Describes River"
            },
            {
            "code": "sea",
            "name": "Sea",
            "description":"Describes Sea"
            }
            ]
        }
    }

**Description of Parameters**

Code: A user defined value that is used as the framework identifier 

Name: The name of the framework as provided by the organization

Description: Describes the framework

##### Response Body to Create Terms

    {
    "responseCode": "OK",
    "result": {
        "node_id": [
            "abc1_subject_river",
            "abc1_subject_sea"
            ]
        }
    }

**Description of Parameters**

Node_ID: Unique identifier for the created terms 

Name: The name of the framework as provided by the organization

Description: Describes the framework

### Concepts Covered

**Framework**- A structure designed to define the scope of something. On Sunbird, the framework is defined through a string of vocabularies

### Additional Topics

How do I extend or customize a framework in Sunbird

How do I seed a framework in Sunbird

How do I associate framework to categories and categories to a terms in Sunbird