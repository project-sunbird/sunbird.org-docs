---
title: Add Content to Framework
page_title: Add Content to Framework
description: Add content in framework in Sunbird instance
keywords: framework data, seed data in framework
published: true
allowSearch: true
---
## Scenario

ABC organization, is a global conglomerate that works in the domain of education and collaborates with different institutions, NGOs and academicians around the world. The primary vision of organizing and enabling seamless discoverability of the content, they decide to implement a framework. As in the process, a framework is already created which is empty. Subsequently, the users must to be able to assign group or categorise programs according to industry, condition, specialty and focus. This information will be used to track against our key condition growth goals, grant and other reporting, and for research and evaluation purposes 
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

{% image src='developer-docs/how-to-guide/images/seed_framework' full center alt='Relationship between Framework, Category, and Terms' zoom %} 

After you create a framework, it must be seeded with the required data classified under different components such as:
   - Categories
   - Terms  
Once the framework is successfully seeded, then it must be associating with terms and categories.

>**Note**: It is recommended that there is a preplanned classification of content and their associations, this ensures that the framework is usable across the system.

### Prerequisites

1. An intialized Sunbird instance with channel

2. The [API Key for access](developer-docs/how-to-guide/generate_apikey/) and basic authentication
  
3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)

4. Onboarding the following with access to the API
    - Admin user     
    - [Individual User](apis/userapi/#operation/Create%20User)
    - [Individual Organization](apis/orgapi/#operation/Organisation%20Create) access 
    - [Map users to the organization](developer-docs/how-to-guide/how_to_create_org_add_user)

5. Access to [Framework API](http://www.sunbird.org/apis/framework/)

6. Follow the steps as mentioned in [Using POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation) section to execute the Create Term API

### Taskflow

In this context, the category objects forms the master of all categories and can be inherited by any framework. Each master list category has the list of all possible category values. You can either choose to use the default values for a category of your framework or override them as per the framework context using the appropriate API.

For example, for ABC organization the framework name is ABC and code as abc1; select the category as subject and change the label as Resource type which defines the various water resources and contains the terms as rain water, lake, ponds and so on. 

A term is created for each value of a category instance: 
Terms are used to tag content and other platform objects. The order of terms within a category is defined using the sequence relation between category instance and the term in the request payload of creating term API. 

The following are the various properties associated with each term:

- name: name of the term
- code: unique code of the term, which will be validated from master category
- category: category of the term
- translations: translations for the term in different languages
- index: order of display of the term
- description: description of the term

Each term can have relationship with framework category and terms:

- categories: list of framework category
- parents: list of parent term
- children: list of child terms
- associations: list of terms associated from other the other category

### Adding Category

To add a category follow these steps: 
1. Check for the existing categories, to do so use [Fetch Category API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1CategoryReadClassGet)
For your reference, the following is the list of default categories:
 - class
 - medium
 - subject
 - gradelevel
 - topic 

2. Create a new category by using [Create category API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1CategoryCreate), ensure to provide the appropriate value for “code” parameter in the request payload. The code parameter inherits the master category schema. 
>**Note**: You can only create a new category using any of the available master list categories. 
> If you want to create a new master category, send an email to support@sunbird.org

3. Provide the valid input for the query parameters **framework**. Append the parameter to the endpoint request URI while you are sending the API request

4. Also, provide the appropriate values for the request body parameters in the payload

#### Request Body for creating framework category:

5. Path for creating framework : `POST: /framework/v1/category/create?framework=abc1`

    {
    "request": {
        "category":{
            "name":"Resource",
            "description":"Resource category of the framework",
            "code":"subject",
            "translations": "{\"en\":\"resource\"}"
        }
        }
    } 

#### Response Body

    {
        "id": "api.category.create",
        "ver": "1.0",
        "ts": "2018-11-19T11:00:57.914Z",
        "params": {
            "resmsgid": "64b331a0-ebea-11e8-8676-f72d022164ed",
            "msgid": "649b63e0-ebea-11e8-b107-49a5bcd087db",
            "status": "successful",
            "err": null,
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "node_id": "abc1_subject",
            "versionKey": "1542625257776"
        }
    }

**Description of Parameters**

Name: name of the category
Code: unique code of the category. This gets validated from the mater category
Description: Description of the category
Translations: Depicts the transalation of the category in different language

Other operation that you can perform on the categories under a framework are as follows: 

[Fetch](apis/framework/#operation/FrameworkV1CategoryReadClassGet) 
[Update](apis/framework/#operation/FrameworkV1CategoryUpdatePatch) 
[Search](apis/framework/#operation/FrameworkV1CategorySearchPost) 


### Adding Terms

1. To create a new term refer to [Create Term API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1TermCreatePost). Given below is an example of request body for creating terms

The categories can be retrieved and listed using [Fetch API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CategoryReadClassGet)

2. Provide the valid input for the query parameters “framework” and “category”. Append these parameters to the endpoint request URL while you are sending the API request.

3. Provide the appropriate values for the request body parameters in the payload.

>**Note**: The sample values provided in the request body are indicative.

##### Request Body for creating Terms 

`POST: /framework/v1/term/create?framework=abc1&category=subject`

    {
        "request": {
            "term": [
                {
                    "code": "river",
                    "name": "River",
                    "description":"Describes River",
                    "translations": "{\"en\":\"river\"}"
                },
                {
                    "code": "sea",
                    "name": "Sea",
                    "description":"Describes Sea",
                    "translations": "{\"en\":\"sea\"}"
                }
            ]
        }
    }


#### Response Body 

    {
        "id": "api.term.create",
        "ver": "1.0",
        "ts": "2018-11-19T11:21:37.973Z",
        "params": {
            "resmsgid": "47d52e50-ebed-11e8-8676-f72d022164ed",
            "msgid": "47ba5350-ebed-11e8-b107-49a5bcd087db",
            "status": "successful",
            "err": null,
            "errmsg": null
        },
        "responseCode": "OK",
        "result": {
            "node_id": [
                "abc1_subject_river",
                "abc1_subject_sea"
            ]
        }
    }  

**Description of Parameters**

Code: Unique value that is used for generating term identifier. 
Description: Description of the term
Name: Name of the terms
Translations: Transalation of the category in different language
 
Other operations that can be performed on terms of a category within a  framework are as follows:

[Fetch](apis/framework/#operation/FrameworkV1TermReadClass2Get) 

[Update](apis/framework/#operation/FrameworkV1TermReadClass2Get) 

[Search](apis/framework/#operation/FrameworkV1TermSearchPost)

### Publishing Framework

1. Once a framework is associated with its category and terms, it has to be published. Until it is published, the changes will not be available in the framework get API call.

2. Given below is the publish framework API sample request and response. Framework has to be passed as a query parameter and the request body should be blank.

>**Note**: The sample values provided in the request body are indicative.

##### Request Body for creating Terms 

`POST: /framework/v1/publish/abc1`
```
{}

```
`Response Body`
``` 
{
    "id": "api.framework.publish",
    "ver": "1.0",
    "ts": "2018-11-20T15:23:31.724Z",
    "params": {
        "resmsgid": "3d1d94c0-ecd8-11e8-8ee7-23985149ff3f",
        "msgid": "3d1b23c0-ecd8-11e8-b9fd-f7a268445f06",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "publishStatus": "Publish Operation for Framework Id 'abc1' Started Successfully!"
    }
}
```
  
Note: Once the framework is published, all the changes will be available in the framework get API.

## Concepts Covered

[How do I create a framework in Sunbird](developer-docs/how-to-guide/how_to_create_framework_in_sunbird)


