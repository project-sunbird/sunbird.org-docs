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

Sunbird is built using microservices. 
A microservice is defined as 'a **logical unit** of software functionality exposed via a set of **versioned APIs** with well **defined contract**'. Microservices are specific and with a fixed purpose, highly maintainable and testable, independently deployable and organized around functional units. A set of microservices are used to provide a solution. 

To explain the parts of the microservice definition -
- A **logical unit** of work is that which generates value for a user. E.g. The *Content Management* microservice is responsible for the lifecycle of content, collections, and assets on the platform.  

- An **Application Programming Interface (API)** is a computing tool (web service, UI component) that implements a set of rules. E.g.*Create Content* is an API within the Content Management microservice. The APIs are enhanced as required with each release and hence there are versions of the API. Sunbird APIs are -
    - REST based (JSON over HTTPS)  
    - Stateless  
    - Versioned  
    The API endpoints follow a common URL structure, viz; https://{host:port}/{module}/{version}/{api_name}.
 - The contract of an API consists of a well defined input, output, a set of test cases, along with usage and compatibility rules. Every API has a contract.  

Currently, Sunbird has the following microservice categories. Each microservice has its own set of APIs.   

## Content & Learning Services

The  **Content and Learning Services**  category has microservices for content management and content usage and tracking.

- **Content Management:**  The content management microservice manages content objects and their lifecycle for a defined taxonomy, in a learning domain. This microservice is dependent on the taxonomy microservice as every content piece must have the appropriate taxonomy tags. The content management microservices have the following APIs:
  - [Content APIs](apis/content){:target="_blank"}
  - [Textbook APIs](apis/tocapi){:target="_blank"}
  - [Course Hieracrchy APIs](apis/coursehierarchyapi){:target="_blank"}
  - [Content Lock APIs](apis/lockService){:target="_blank"}

- **Usage & Tracking Service**: The usage and tracking microservice is used for course enrolment, to manage content usage, and to track progress of trackable learning objects like online courses, course batches, quizzes, and batch certificates. They also include APIs for batch management that allow you to create, view, update and search for course batches.The APIs for this microservice are grouped into:
    - [Course Batch Management APIs](apis/coursebatchmanapi/){:target="_blank"}
    - [Course Enrolment APIs](apis/courseenrolmentapi/){:target="_blank"}
    - [Course Progress APIs](apis/courseprogressapi/){:target="_blank"} 
    - [Course Batch Certificates](apis/coursebatchcertificateapi/){:target="_blank"}

## Contribution & Curation Services

The **Contribution & Curation Services** category has microservices for contribution and contributor management. 

- **Contribution Management:** The contribution management microservice enables organisations to digitally plan, coordinate and manage crowd sourcing of content for defined programs. The APIs of this microservice are grouped into: 
    - [Program APIs](apis/programsapi/){:target="_blank"}
    - [Bulk Content Approval APIs](apis/bulkapproveapi){:target="_blank"}

- **Contributor Management:** The contributor management microservice enables a registry of individual contributors and contributing organisations that nominate and contribute digital content via sourcing projects.  
    - [Registry APIs](apis/opensaber/){:target="_blank"}

## Taxonomy & Tagging Services

The **Taxonomy & Tagging Services** category has microservices for taxonomy and framework management, and content category management.  

- **Taxonomy Framework Management:** The taxonomy and framework management microservice uses two services - the taxonomy and framework service that provides the ability to create, organise and manage taxonomy frameworks in a learning domain; and the license service that manages content licenses. This microservice is domain independent, i.e. it can be used to model the taxonomy of any learning domain, e.g: K-12, Leadership training, Professional training. The APIs in this microservice are grouped as:  
    - [Taxonomy Framework Management APIs](apis/framework/){:target="_blank"}
    - [License APIs](apis/license/){:target="_blank"}

- **Content Category Management:** The content category management microservice provides the ability to set rules to create and manage categories for different content categories, such as collections, question sets, etc.  
    - [Object Category Management APIs](apis/objectcategory/){:target="_blank"}

## Telemetry & Data, Analytics Services

The **Telemetry & Data, Analytics Services** category has the following microservices:

- **Telemetry Service**: The [Telemetry Service](./developer-docs/telemetry/overview){:target="_blank"} microservice collects telemetry and ingests the telemetry into the data pipeline for processing.
    - [Telemetry API](apis/telemetryapi){:target="_blank"}
    
- **Data Service:**: The data microservice provides services to manage report jobs and data exhausts that enable data aggregation across multiple sources services. The APIs are grouped as:
    - [Data Exhaust APIs](apis/dataexhaustapi){:target="_blank"} 
    - [Druid Report APIs](apis/druidreportapi){:target="_blank"} 

- **Reports Service:**  The reports microservice creates, reviews and publishes reports to the Sunbird portal using the HawkEye framework. The APIs are grouped under the:
    - [Report Service APIs](apis/reports/){:target="_blank"}

## Registry & Discovery Services

The **Registry & Discovery Services** category has microservices that manage and implement DIAL codes; search and discover content and knowledge assets; enable and manage the lifecycle, administration, and permissions of users; registries of users, organisations, geographic locations and devices. The APIs for this microservice are grouped under:

- [D.I.A.L Code APIs](apis/dialapi/){:target="_blank"} 
- [Composite Search APIs](apis/searchapi/){:target="_blank"} 
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

## Interaction & Collaboration Services

The **Interaction & Collaboration Services** category has microservices that send user notifications through multiple channels such as email, SMS, and OTPs; create and manage groups of registered users and track activities assigned to group members; allow users to participate in multiple categories of discussions and provide chatbot assistance to users. The APIs for the microservices are grouped under:

- [Notification APIs](apis/notificationapi/){:target="_blank"}  
    - [OTP APIs](apis/otpapi/){:target="_blank"}.
- [Group Management APIs](apis/groupapi/){:target="_blank"} 
    - [Group Activity APIs](apis/groupactivityapi/) 
- [Discussion Forum APIs](apis/discussionForum/){:target="_blank"} 
- [Chatbot APIs](apis/chatbotapi/){:target="_blank"} 

## Practice, Sensing & Assessment Services

The **Practice, Sensing & Assessment Services** category has a microservice that creates and manages questions and question sets that are useful to assess proficiency of learners. The APIs for this microservice are gouped under: 
- [Question Management APIs](apis/questionapi//){:target="_blank"}

## Credentialing & Badging Services

The **Credentialing & Badging Services** category has the microservice that issues digital certificates as per required specifications and enables the storage and verification of digitally issued certificates. The APIs for this microservice are grouped under:

- [Certificate Generation APIs](apis/certificate/){:target="_blank"}   
- [Certificate Registry APIs](apis/certificateregistry/){:target="_blank"}  
- [Certificate Template APIs](apis/certificatetemplateapi/){:target="_blank"}  

## Infra & Shared Services

The **Infra & Shared Services** category has microservices to manage system and UI form configurations; create, manage and validate API tokens to register mobile and desktop apps, and to issue and refresh API tokens of registered mobile and desktop app devices; and capture and manage client application and device error logs. The APIs are grouped under:
    
- **Configuration Management:**   
    - [Form APIs](apis/form/){:target="_blank"}  
    - [Page APIs](apis/pagesapi/){:target="_blank"}  
    - [System settings APIs](apis/systemsettingsapi/){:target="_blank"}  
    - [Desktop app update](apis/desktop/app-update/){:target="_blank"}  
- **API Management:**   
    - [Echo API](apis/echoapi/){:target="_blank"}  
    - [Kong register version 1](apis/kongcredentialregisterapiv1/){:target="_blank"}  
    - [Kong register version 2](apis/kongcredentialregisterapiv2/){:target="_blank"}  
    - [Refresh API tokens](apis/refreshtokenapi){:target="_blank"}  
    - [Desktop register API](apis/desktop/device-registry/){:target="_blank"}  
- **Logging Services:** 
    - [Client Log APIs](apis/clientlogapi){:target="_blank"}
