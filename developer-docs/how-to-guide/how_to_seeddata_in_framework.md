---
title: Seed Framework
page_title: Seed a Framework
description: Seed data in framework in Sunbird instance
keywords: framework data, seed data in framework
published: true
allowSearch: true
---
## Scenario

ABC organization with its vision of organizing and enabling seamless discoverability of the content decided to implement a framework. As in the process, a framework is already created which is empty. 

* Users need to be able to assign / group / categorise programs according to industry, condition, specialty and focus. For example: healthcare, endocrinology, diabetes, research/QI. This information will be used to track against our key condition growth goals, grant and other reporting, and for research and evaluation purposes 
* Content needs to be categorized. Lectures, case presentations, and supplemental documents need to be labeled so they can be added to categories related to label. 
* New programs in existing topic areas should be able to easily find appropriate top-rated lectures to add to their sessions.

With huge resource library and based on ABC organizations decision, they want to classify their content based on categories as and subcategories. The framework needs to be seeded as per their proposed classification.

| Framework Name | Categories            | Terms                               |
|----------------|-----------------------|-------------------------------------|
| ABC            | Resources             | Ground Water, Spring, Surface Water |
|                | Governance            | Ground Water, Spring, Surface Water |
|                | Measurement & Mapping | Ground Water, Spring, Surface Water |
|                | Funds                 | State, Central, Global              |
|                | Management            | Ground Water, Spring, Surface Water |

ABC, may choose a predefined category and associate it to their own framework. The categories in the framework has terms associated with it. These terms are relevant to the created framework and can be created by the organization. 

After you create a framework, you need to seed it with the required data classified under different components such as:
   - Categories
   - Terms  
and  associating these terms and categories 

>Note: Recommending to ensure that there a preplanned classification of content and their associations, this ensures that the framework is usable across the system.

### Prerequisites

1. An intialized Sunbird instance with channel

2. The [API Key for access](http://www.sunbird.org) and basic authentication
  
3. ​Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

4. Onboarding the following with access to the API
    - Admin user     
    - [Individual User](http://www.sunbird.org/apis/userapi/#operation/Create%20User)
    - [Individual Organization](http://www.sunbird.org/apis/orgapi/#operation/Organisation%20Create) access 
    - [Associated Users to Organization](http://www.sunbird.org/apis/)

5. Access to [Framework API](http://www.sunbird.org/apis/framework/)

### Taskflow

In this context, the category objects forms the master of all categories and can be inherited by any framework.
Each master list category has the list of all possible category values
You can either choose to use the default values for a category of your framework or override them as per the framework context using the appropriate API

For example, for ABC organization the framework name is ABC and code as abc1; the category selected is subject and change the label as Resource type which defines the various water resources and contains the terms as Rain water, lake, ponds and so on. 

While as, a term is created for each value of a category instance: 
Terms are used to tag content and other platform objects. 
The order of terms within a category is defined using the sequence relation between category instance and the term in the request payload of creating terms API 

The following values ensure that the term is tagged to right category 

- Value: value of the term
- Label: display label of the term
- Translations: display label of the term in multiple languages
- Tag: vocabulary tag associated with the term
- Index: index position of the term
- Children: list of terms that are children of the current term
- Associations: list of terms associated with the current term

### Adding Category

To retrieve the channels for the request parameter, use [List Channel API](http://www.sunbird.org/apis/framework/#operation/ChannelV1ListPost)
1. To add a category follow these steps: 
Check for the existing categories, to do so use  Fetch Category API
For your reference, the following is the list of default categories:
 - Curriculum
 - Class
 - Medium
 - Subject
 - Medium
 - Concept
 - Topic 

2. Create a new category by using [Create category API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1CategoryCreate), ensure to provide the appropriate value for “code” parameter in the request payload. The code parameter inherits the master category schema. 
Note: 
You can only create a new category using any of the available master list categories.
If you want to create a new master category, send an email to support@sunbird.org      

Following is an example of request body for creating a framework, the sample values provided in the request body are indicative:

3. Follow the steps mentioned in [Using POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation) section to execute the API

4. Path for creating category in the Framework: <pre>{{host}}/framework/v1/category/create</pre> 

    {
    "id": "string",
    "ver": "string",
    "ets": 0,
    "params": {
        "msgid": "string",
        "did": "string"
    },
    "request": {
        "category": {
        "code": "string",
        "name": "string",
        "description": "string"
        }
    }
    }
 
**Description of Parameters**

Name: depicts the name of the framework for the organization
Code: is user defined value that is used as framework identifier 
Description: is related to the framework
Translations: enables framework in different languages 
Type: defines the type of content


#### Response Body 

    {
    "id": "string",
    "ver": "string",
    "ets": 0,
    "params": {
        "msgid": "string",
        "resmsgid": "string",
        "err": null,
        "err_msg": null,
        "err_detail": null,
        "status": "success"
        },
    "responseCode": "string",
    "result": {
        "node_id": "string",
        "versionKey": "string"
        }
    }

5. You can rename an existing category using following: 

##### Request Body

    {
    "request": {
        "category":{
            "name":"resources",
            "description":"Subject is changed to Resources",
            "code":"subject"
            }
        }
    }

##### Response Body

    {
    "responseCode": "OK",
    "result": {
        "node_id": "abc_subject",
        "versionKey": "1535716551605"
        }
    }


5. Provide the valid input for the query parameters **framework**. Append the parameter to the endpoint request URI while you are sending the API request

6. Also, provide the appropriate values for the request body parameters in the payload Other operation that you can perform on the categories under a framework are as follows: 

[Fetch](apis/framework/#operation/FrameworkV1CategoryReadClassGet) 
[Update](apis/framework/#operation/FrameworkV1CategoryUpdatePatch) 
[Search](apis/framework/#operation/FrameworkV1CategorySearchPost) 

Associating categories 
It is necessary that each of the new category must be associated to any of the master categories, which can be done by providing appropriate values to the parameters in query string
For any references regarding the parameter usage refer to the Framework API resources  

### Adding Terms

1. To create a new term refer to [Create Term API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1TermCreatePost)

Following is an example of request body for seeding data in a framework, the sample values provided in the request body are indicative:

2. Path for creating the Framework: <pre>{{host}}/framework/v1/term/create</pre>
#### Create a Term

1. Use the [Add Term API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1TermCreatePost), to create a new term in the category.
The categories can be retrieved and listed using [Fetch API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CategoryReadClassGet). The sample values provided in the request body are indicative.

2. Path for creating category: `{{host}}/framework/v1/term/create?framework=ndf1&category=subject`

##### Request Body for Adding Terms 

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

Actual:

    {
    "id": "string",
    "ver": "string",
    "ets": 0,
    "params": {
        "msgid": "string",
        "did": "string"
        },
    "request": {
        "term": {
        "code": "string",
        "name": "string",
        "description": "string",
        "category": "string",
        "index": 0,
        "categoryinstances": [
            {}
            ],
        "parents": [
            {}
            ],
        "associationswith": [
            {}
            ],
        "children": [
            {}
            ],
        "associations": [
            {}
            ]
            }
        }
    }

##### Response Body for Adding Terms

    {
    "responseCode": "OK",
    "result": {
        "node_id": [
            "abc1_subject_river",
            "abc1_subject_sea"
            ]
        }
    }


Actual:
    {
    "id": "string",
    "ver": "string",
    "ets": 0,
    "params": {
        "msgid": "string",
        "resmsgid": "string",
        "err": null,
        "err_msg": null,
        "err_detail": null,
        "status": "success"
        },
    "responseCode": "string",
    "result": {
        "node_id": "string",
        "versionKey": "string"
        }
    }
  

**Description of Parameters**

Name: depicts the name of the framework for the organization
Code: is user defined value that is used as framework identifier 
Description: is related to the framework
Translations: enables framework in different languages 
Type: defines the type of content
 
2. Follow the steps as mentioned in [Using POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation) section to execute the Create Term API

3. Provide the valid input for the query parameters “framework” and “Category”. Append these parameters to the endpoint request URI while you are sending the API request

4. Also, provide the appropriate values for the request body parameters in the payload, other operations that can be performed on terms of a category within a  framework are as follows:

[Fetch](apis/framework/#operation/FrameworkV1TermReadClass2Get) 

[Update](apis/framework/#operation/FrameworkV1TermReadClass2Get) 

[Search](apis/framework/#operation/FrameworkV1TermSearchPost) 

## Concepts Covered

[How do I extend or customize a framework in Sunbird](http://www.sunbird.org/developer-docs)

[How do I seed a framework in Sunbird](http://www.sunbird.org/developer-docs)

[How do I associate framework to categories and categories to a terms in Sunbird](http://www.sunbird.org/developer-docs)

[How to use Postman](http://www.sunbird.org/developer-docs)
Taxonomy

Associating Categories 

### Additional Topics