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

| Framework Name | Categories            | Terms                               |
|----------------|-----------------------|-------------------------------------|
| ABC            | Resources             | Ground Water, Spring, Surface Water |
|                | Governance            | Ground Water, Spring, Surface Water |
|                | Measurement & Mapping | Ground Water, Spring, Surface Water |
|                | Funds                 | State, Central, Global              |
|                | Management            | Ground Water, Spring, Surface Water |

ABC Organization, may choose a predefined category and associate it to their own framework. Each category in the framework has terms associated with it. These terms are relevant to the created framework and can be created by the organization. 

While creating a new framework, the framework creator needs to set up a new framework and align it to the categories and terms. A category can have terms either in sequential list or in hierarchical structure. Terms can be associated with other terms across categories. As a result, it is possible to select a term in the first category and hence restrict the set of available terms for the next category and so on. The organizations that are adopting Sunbird can link the categories and also change the labels but cannot override or add a new categories on their own. However, the Sunbird instance has the following categories in its predefined frameworks:

    - Subject: classification of stream specific values
    - Board: certifying body/stream government or private organization
    - Grade Level: maturity level for knowledge  
    - Medium: language of the course 
    - Topic: detail of the concepts 
    
A user can select one or more category amongst the defined category. 
 
For example, for the organization ABC organization the framework name is ABC and code as abc1; the category selected is **Subject** and the label is modified as **Resources** which defines the various water resources and contains the terms as Ground Water, Spring, Surface Water and so on. 

### Prerequisites

1. An intialized Sunbird instance with channel

2. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)
  
3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

4. Onboarding the following with access to the API

    - Admin user     

    - [Individual user](apis/userapi/#operation/Create%20User)

    - [Individual Organization](apis/orgapi/#operation/Organisation%20Create) access 

    - [Map users to the organization](apis/orgapi/#operation/Organisation%20Add%20User)

5. Access to [Framework API](apis/framework/)

### Taskflow
 
The sequence of tasks the organization administrator follows to create a framework includes:

#### Create Framework

1. Use the [Create Framework API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CreatePost), to create a new framework. Specify values for the parameters in the request body of the API. 
Following is an example of request body for creating a framework, the sample values provided in the request body are indicative:

2. Path for creating the Framework: `{{host}}/framework/v1/create`

##### Request Body to Create Framework

To retrieve the channels for the request parameter, use [List Channel API](apis/framework/#operation/ChannelV1ListPost)

    {
    "request": {
        "framework": {
            "name": "ABC",
            "code": "abc1",
            "description": "Framework for ABC Management",
            "translations": {"hi":"ABC-अनुवाद","ta":"ABC மொழிபெயர்ப்பு"},
            "type": "TPD",
            }
        }
    } 

**Description of Parameters**

- Name: The name of the framework as provided by the organization
- Code: A user defined value that is used as the framework identifier 
- Description: Describes the framework
- Translations: Enables framework in different languages 
- Type: defines the type of content

##### Response Body to Create Framework

    {
    "responseCode": "OK",
    "result": {
        "framework": {
            "identifier": "abc1",
            "code": "abc1",
            "translations": "{\"hi\":\"ABC-अनुवाद\",\"ta\":\"ABC மொழிபெயர்ப்பு\"}",
            "name": "ABC",
            "description": "Framework for ABC Management",
            "type": "",
            "objectType": "Framework"
            }
        }
    }

#### Create Category

1. Use the [Add Category API](apis/framework/#operation/FrameworkV1CategoryCreatePost), to create a new category in the framework. 

> Note: You must send a request to [Sunbird Team](info@sunbird.org) for creating new category. 

The sample values provided in the request body are indicative. The API describes the procedure to change the label(resources) of an existing category (subject):

2. Path for creating category: `{{host}}/framework/v1/category/create?framework=abc1`

##### Request Body to Create Categories

    {
    "request": {
        "category":{
            "name":"resources",
            "description":"Subject is changed to Resources",
            "code":"subject"
            }
        }
    }

##### Response Body to Create Categories

    {
        "responseCode": "OK",
        "result": {
            "node_id": "abc_subject",
            "versionKey": "1535716551605"
            }
    }


#### Create a Term

1. Use the [Add Term API](apis/framework/#operation/FrameworkV1TermCreatePost), to create a new term in the category.
The categories can be retrieved and listed using [Fetch API](apis/framework/#operation/FrameworkV1CategoryReadClassGet). The sample values provided in the request body are indicative.

2. Path for creating category: `{{host}}/framework/v1/term/create?framework=abc1&category=subject`

##### Request Body to Add Terms 

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

##### Response Body to Add Terms

    {
    "responseCode": "OK",
    "result": {
        "node_id": [
            "abc1_subject_river",
            "abc1_subject_sea"
            ]
        }
    }

### Concepts Covered

**Framework**- A structure designed to define the scope of something. On Sunbird, the framework is defined through a string of vocabularies

### Additional Topics

How do I [seed a framework in Sunbird](developer-docs/how-to-guide/how_to_seeddata_in_framework)