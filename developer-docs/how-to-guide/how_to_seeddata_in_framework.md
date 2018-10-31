---
title: Seed Framework
page_title: Seed a Framework
description: Seed data in framework in Sunbird instance
keywords: framework data, seed data in framework
published: true
allowSearch: true
---
## Scenario

ABC organization with its vision of organizing and enabling seamless discoverability of the content decided to implement a framework. As in the process, a framework is already created which is empty. Refer [Creating a Framework](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird)

* Users need to be able to assign / group / categorize programs according to Water Management, Conservation, Governance, Technologies, Agriculture, Health. This information will be used to track against our key condition growth goals, grant and other reporting, and for research and evaluation purposes. 
* Content needs to be categorized. Lectures, case presentations, and supplemental documents need to be labeled so they can be added to categories related to label. 
* New programs in existing topic areas should be able to easily find appropriate top-rated lectures to add to their sessions.

After you create a framework, you need to seed it with the required data classified under different components such as:

   - Categories

   - Terms

and associating these terms and categories 

With huge resource library and based on ABC Organizations decision, you can classify the content based on categories and subcategories. The framework needs to be seeded as per their proposed classification.

| Framework Name | Categories            | Terms              |
|----------------|-----------------------|--------------------|
| ABC            |Water Management| Domestic, Industry, Agriculture|
|                |Conservation | Awareness, Rain water harvesting, Recycling Waste Water|
|                |Governance | Policies, Citizens Rights and Duties, Government Programs, Privatization, Water Pricing|
|                |Technologies | Recycling Technologies, Irrigation Technologies, Water Conservation Technologies|
|                |Agriculture | Irrigation, Dams, Ground Water Management, Water Management Practises|
|                |Health | Safe water, Ground Water Contamination, Water Borne Diseases|
|                |Water Directory |         |

>Note: Recommending to ensure that there a preplanned classification of content and their associations, this ensures that the framework is usable across the system.

### Prerequisites

1. Software that can make API calls like curl or POSTMAN

2. Access to [Framework API](http://www.sunbird.org/apis/framework/)

3. Existing Framework, refer [Creating a Framework](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird)

## Taskflow

### Creating Framework

To create a framework, refer [Creating Framework](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird#creating-framework)

### Validating a Category

Use [Search Category API](../apis/framework/#operation/FrameworkV1CategorySearchPost) to fetch the list of the available master categories

### Configuring Category for the Instance

In this context, the category objects forms the master of all categories and can be inherited by any framework. Each master list category has the list of all possible category values. You can either choose to use the default values for a category of your framework or override them as per the framework context using [Add Category API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CreatePost). To create a category in the installed Sunbird instance refer [Adding a Category](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird#configuring-category-for-the-instance)

### Creating a Term

For example, for ABC organization the framework name is ABC and code as abc1; the category selected is subject and change the label as Conservation which narrates the awareness and methods of conseration of water as awareness, Rain water harvesting, recycling waste water. 

While as, a term is created for each value of a category instance, they are also used to tag content and other platform objects. 
The order of terms within a category is defined using the sequence relation between category instance and the term in the request payload of creating terms API 

The following values ensure that the term is tagged to right category 

- Value: Value of the term
- Label: Display name of the term
- Translations: Displays label of the term in different languages
- Tag: Vocabulary tag associated with the term
- Index: Index position of the term
- Children: List of terms that are sub-elements of the current term
- Associations: List of terms associated with the current term

### Adding Category

It is necessary that each of the new category must be associated to any of the master categories, which can be done by providing appropriate values to the parameters in query string
To add a category in the framework perform the following steps:

1. Retrieve the channels required for the request parameter of the category, using [List Channel API](../apis/framework/#operation/ChannelV1ListPost)

2. Add a category in the framework by following these steps: 
    - Use [Search Category API](../apis/framework/#operation/FrameworkV1CategorySearchPost) to fetch the list of the available master categories. Path for searching the category: `{{host}}/action/framework/v1/category/master/search`. refer [Validating a Category](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird#validating-a-category)

    - Create a new category by using [Add Category API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1CategoryCreate), ensure to provide the appropriate value for **code** parameter in the request body. The code parameter inherits the master category schema. Path for adding a category: `{{host}}/action/api/framework/v1/category/create?framework=abc1`. Refer [Configuring a Category for the Instance](../developer-docs/how-to-guide/how_to_create_framework_in_sunbird#configuring-category-for-the-instance). 

3. Also, provide the appropriate values for the request body parameters in the payload. Other operation that you can perform on the categories under a framework are as follows: 

[Fetch](../apis/framework/#operation/FrameworkV1CategoryReadClassGet)

[Update](../apis/framework/#operation/FrameworkV1CategoryUpdatePatch) 

[Search](../apis/framework/#operation/FrameworkV1CategorySearchPost) 

### Adding Terms

1. Add Terms in the category using [Add Term API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1TermCreatePost). The categories can be retrieved and listed using [Fetch API](http://www.sunbird.org/apis/framework/#operation/FrameworkV1CategoryReadClassGet).
Path for adding a term in the Framework: `{{host}}/framework/v1/category/create?framework=abc1&category=conservation` 

2. To create a new term refer [Create Term API](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1TermCreatePost)

3. Provide the valid input for the query parameters **Framework** and **Category**. Append these parameters to the endpoint request URI while you are sending the API request