---
layout: page
title: API Reference Documentation
page_title: API reference documentation
description: API reference documentation
keywords: API Documentation, API reference, API
published: true
allowSearch: true
---

Welcome to Sunbird API reference documentation!

Sunbird is built using microservices as building blocks that are mapped to building block types.
A microservice is defined as 'a **logical unit** of software functionality exposed via a set of **versioned APIs** with well **defined contract**'. Microservices are specific and with a fixed purpose, highly maintainable and testable, independently deployable and organized around functional units. A set of microservices are used to provide a solution.
The definition, it can be explained in detail as follows
- A **logical unit** of work is that which generates value for a user. E.g. The *Content and Collection* microservice is responsible for the lifecycle of content, collections, and assets on the platform.
- An **Application Programming Interface (API)** is a computing tool (web service, UI component) that implements a set of rules. E.g.*Create Content* is an API within the Content Management microservice. The APIs are enhanced as required with each release and hence there are versions of the API. Sunbird APIs are REST based (JSON over HTTPS), Stateless, and Versioned.
- The API endpoints follow a common URL structure, viz; https://{host:port}/{module}/{version}/{api_name}
- The contract of an API consists of a well defined input, output, a set of test cases, along with usage and compatibility rules. Every API has a contract.

This page details Sunbird's building block types, the microservices grouped under each building block type and the APIs for each set of microservice.

## Contribution & Curation

In the **Contribution and Curation**  building block type, Sunbird has microservices to manage the lifecycle of content and collections; create and manage questions and question sets that are useful to assess proficiency of learners; contribution management and contributor registry.

### Content Service {#content-service}

The **Content and Collection microservice** manages content and collection objects and their lifecycle for a defined taxonomy, in a learning domain. This microservice is dependent on the taxonomy microservice as every content piece must have the appropriate taxonomy tags. The content and collection microservices has the following APIs:
- [Content APIs](apis/content){:target="_blank"}
- [Content Lock APIs](apis/lockService){:target="_blank"} 
- [Textbook APIs](apis/tocapi){:target="_blank"}
- [Course Hieracrchy APIs](apis/coursehierarchyapi){:target="_blank"}

### Question & Question Set Service {#question-n-question-set}

The **Question and Question set microservice** provides services to create and manage questions and question sets that are useful to assess the  proficiency of learners. The APIs are grouped as:
- [Question Management APIs](apis/questionapi//){:target="_blank"}

### Contribution Service {#contribution-service}

The **Contribution microservice** enables organisations to digitally plan, coordinate and manage crowd sourcing of assets for defined programs. The APIs of this microservice are grouped into:
- [Program APIs](apis/programsapi/){:target="_blank"}
- [Bulk Content Approval APIs](apis/bulkapproveapi){:target="_blank"}

### Contributor Registry {#contributor-registry}

The **Contributor management microservice** enables a registry of individual contributors and contributing organisations that nominate and contribute digital assets via sourcing projects.
- [Registry APIs](apis/opensaber/){:target="_blank"}

### Related Microservices and/or APIs 
* [Telemetry Service](./developer-docs/telemetry/overview){:target="_blank"}
* [Composite Search APIs](apis/searchapi/){:target="_blank"} 
* [Assign User Role APIs](apis/userapi/#operation/Assign_User_Role/){:target="_blank"}
* [Reports Service](#reports-service)

## Taxonomy & Tagging
In the **Taxonomy and Tagging** building block type, Sunbird has microservices for taxonomy and framework management, and asset category management.

### Taxonomy Service {#taxonomy-service}

The taxonomy and framework management microservice uses two services 
- the taxonomy and framework service that provides the ability to create, organise and manage taxonomy frameworks in a learning domain; 
- the license service that manages content licenses. This microservice is domain independent, i.e. it can be used to model the taxonomy of any learning domain, e.g: K-12, Leadership training, Professional training. 

The APIs in this microservice are grouped as:
 - [Taxonomy Framework Management APIs](apis/framework/){:target="_blank"}
 - [License APIs](apis/license/){:target="_blank"}

### Asset Category Service {#asset-category-service}
The asset category microservice provides the ability to set rules to create and manage categories for different asset categories, such as content, collection, question set, etc.
- [Object Category Management APIs](apis/objectcategory/){:target="_blank"}

### Related Microservices and/or APIs
* [Content Service](#content-service)
* [Question and Question Set Service](#question-n-question-set)

## Discovery & Personalisation 

In the **Discovery & Personalisation** building block type, Sunbird has microservices that manage and implement DIAL codes, and search and discover knowledge assets.

### DIAL Service {#dial-service}

The **DIAL microservice** provides services to manage and implement DIAL (Digital Infrastructure for Augmented Learning) Codes. The APIs are grouped as:
* [D.I.A.L Code APIs](apis/dialapi/){:target="_blank"} 

### Asset Search Service {#asset-search-service}

The **Asset search microservice** provides services to search and discover assets on the platform. The APIs are grouped as:
* [Composite Search APIs](apis/searchapi/){:target="_blank"} 

### Related Microservices and/or APIs
* [Content Service](#content-service)
* [Taxonomy Service](#taxonomy-service)

## Interaction and Collaboration

In the **Interaction and Collaboration** building block type, Sunbird has microservices that send user notifications through multiple channels such as email, SMS, and OTPs; create and manage groups of registered users and track activities assigned to group members; allow users to participate in multiple categories of discussions and provide chatbot assistance to users.

### Group Service {#group-service} 

The **Group microservice** provides services to create and manage groups of registered users and track activities assigned to group members. The APIs are grouped as:
- [Group Management APIs](apis/groupapi/){:target="_blank"} 
    - [Group Activity APIs](apis/groupactivityapi/) 

### Discussion Forum Service {#discussion-forum-service}

The **Discussion forum microservice** provides services to allow users to participate in multiple categories of discussions. The APIs are grouped as:
- [Discussion Forum APIs](apis/discussionForum/){:target="_blank"} 

### Chatbot Service {#chatbot-service}
The **Chatbot microservice** provides services to provide chatbot assistance to users. The APIs are grouped as:
- [Chatbot APIs](apis/chatbotapi/){:target="_blank"} 

## Learn, Do, Practice, Sense & Assess

In the **Learn, Do, Practice, Sense, and Assess** building block type, Sunbird has microservices that helps to manage batches to track progress of participants in trackable learning objects and question sets for various usecases such as Practice, Sense, and Assess.

### Batch & Progress Service {#batch-n-progress-service}

The **Batch and Progress microservice** provides services to manage course enrolment, content usage, and track progress of trackable learning objects like online courses, course batches, quizzes, and batch certificates. They also include APIs for batch management that allow you to create, view, update and search for course batches.The APIs for this microservice are grouped into:
- [Course Batch Management APIs](apis/coursebatchmanapi/){:target="_blank"}
- [Course Enrolment APIs](apis/courseenrolmentapi/){:target="_blank"}
- [Course Progress APIs](apis/courseprogressapi/){:target="_blank"} 
- [Course Batch Certificates](apis/coursebatchcertificateapi/){:target="_blank"}

### Related Microservices and/or APIs 
* [Question Management APIs](apis/questionapi//){:target="_blank"}

## Credentialing & Badging

In the **Credentialing & Badging** building block, Sunbird has microservices that issue digital certificates and verify digitally issued certificates.

### Credential Service {#credential-service}

The **Credential microservice** provides services to issue digital certificates as per required specifications and enables the storage and verification of digitally issued certificates. The APIs are grouped as:
- [Certificate Generation APIs](apis/certificate/){:target="_blank"}   
- [Certificate Registry APIs](apis/certificateregistry/){:target="_blank"}  
- [Certificate Template APIs](apis/certificatetemplateapi/){:target="_blank"}  

### Related Services/APIs 
* [DIAL Service](#dial-service)
* [Batch and Progress Service](#batch-n-progress-service)]

## Open Data

For the **Open Data** building block, Sunbird has microservices for public, standard, and on-demand data exhaust.

### Public Data Service {#public-data-service}

The **Public Data microservice** provides services to manage report jobs and data exhausts that enable data aggregation across multiple sources. The APIs are grouped as:
- [Public Data Exhaust APIs](apis/dataexhaustapi/index.html#tag/Public-Data-Exhaust-API(s)){:target="_blank"} 

## Learning Infra, Telemetry & Analytics

In the **Learning Infra, Telemetry and Analytics** building block type, Sunbird has microservices to create, capture, enable, validate and manage:
* user lifecycle, administration, and permissions  
* registries for users, organisations, geographic locations and devices
* content and collection usage and progress tracking 
* system and UI form configurations 
* API tokens to register mobile and desktop apps
* issue and refresh API tokens of registered mobile and desktop app devices 
* client application and device error logs 

### User & Org Service {#user-n-org-service}

The **User and Org microservice** provides services to enable and manage the lifecycle, administration, and permissions of users; registries of users, organisations, geographic locations and devices; to send user notifications through multiple channels such as email, SMS, and OTPs. The APIs are grouped as:
- [User Management APIs](apis/userapi/){:target="_blank"}   
    - [Bulk Upload Service APIs](apis/bulkupload/){:target="_blank"}  
    - [Assign User Role APIs](apis/userapi/#operation/Assign_User_Role/){:target="_blank"}  
    - [User Feed APIs](apis/feedapi/){:target="_blank"}  
    - [User Consent APIs](apis/consentapi/){:target="_blank"}  
    - [Data Sync APIs](apis/datasyncapi/){:target="_blank"}  
- [Organisation Management APIs](apis/orgapi/){:target="_blank"}  
    - [Tenant Preference](apis/tenantpreferenceapi/){:target="_blank"}
- [Location Management APIs](apis/locationapi/){:target="_blank"} 
- [Device Management APIs](apis/deviceapi/){:target="_blank"} 
- [Notification APIs](apis/notificationapi/){:target="_blank"}  
    - [OTP APIs](apis/otpapi/){:target="_blank"}.

### Telemetry Service {#telemetry-service}

The [Telemetry Service](./developer-docs/telemetry/overview){:target="_blank"} microservice collects telemetry and ingests the telemetry into the data pipeline for processing. The APIs are grouped under the:

- [Telemetry API](apis/telemetryapi){:target="_blank"}

### Reports Service {#reports-service} 

The **Reports microservice** creates, reviews and publishes reports to the Diksha portal using the HawkEye framework. The APIs are grouped under the:
- [Report Service APIs](apis/reports/){:target="_blank"}

### Data Service {#data-service}

The data microservice provides services to manage report jobs and data exhausts that enable data aggregation across multiple source services. The APIs are grouped as:
- [Data Exhaust APIs](apis/dataexhaustapi){:target="_blank"} 
- [Druid Report APIs](apis/druidreportapi){:target="_blank"} 

### Configuration Service {#configuration-service}

The **Configuration microservice** provides services to manage system and UI form configurations.
- [Form APIs](apis/form/){:target="_blank"}  
- [Page APIs](apis/pagesapi/){:target="_blank"}  
- [System settings APIs](apis/systemsettingsapi/){:target="_blank"}  
- [Desktop app update](apis/desktop/app-update/){:target="_blank"} 

### API Management Service {#api-management-service}

The API management microservice provides services to create, manage and validate API tokens to register mobile and desktop apps, and to issue and refresh API tokens of registered mobile and desktop app devices
- [Echo API](apis/echoapi/){:target="_blank"}  
- [Kong register version 1](apis/kongcredentialregisterapiv1/){:target="_blank"}  
- [Kong register version 2](apis/kongcredentialregisterapiv2/){:target="_blank"}  
- [Refresh API tokens](apis/refreshtokenapi){:target="_blank"}  
- [Desktop register API](apis/desktop/device-registry/){:target="_blank"} 

### Logging Services {#logging-services}

The logging microservice provides services to capture and manage client application and device error logs
- [Client Log APIs](apis/clientlogapi){:target="_blank"}

