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

To explain the parts of the microservice definition:
- A **logical unit** of work is that which generates value for a user. E.g. The *Content Management* microservice is responsible for the lifecycle of content, collections, and assets on the platform.
- An **Application Programming Interface (API)** is a computing tool (web service, UI component, etc) that implements a set of rules. E.g.*Create Content* is an API within the Content Management microservice. The APIs are enhanced as required with each release and hence there are versions of the API. Sunbird APIs are:
    - REST based (JSON over HTTPS)
    - Stateless
    - Versioned
    The API endpoints follow a common URL structure, viz; https://{host:port}/{module}/{version}/{api_name}.
 - The contract of an API consists of a well defined input, output, a set of test cases, along with usage and compatibility rules. Every API has a contract.  

Currently, Sunbird has the following microservice categories. Each microservice has its own set of APIs.   

## Content & Learning Services

The **Content and Learning Services** category has the following microservices:

- [**Content Management:**](https://apis/content/){:target="_blank"} Provides services to manage content objects and their lifecycle for a defined taxonomy in a learning domain. This service is dependent on the taxonomy microservice as every content piece must be tagged with the appropriate taxonomy.
- **Usage & Tracking Service:** Provides services for enrolment, usage and progress tracking of trackable learning objects like online courses, quizzes, etc.

## Contribution & Curation Services

The **Contribution & Curation Services** category has the following microservices:

- **Contribution Management:** This service enables organisations to digitally plan, coordinate and manage crowd sourcing for content contributions.
- [**Contributor Management:**](https://apis/opensaber/){:target="_blank"} This service enables a registry of individual contributors and contributing organisations that nominate and contribute digital content via sourcing projects.

## Taxonomy & Tagging Services

The **Taxonomy & Tagging Services** category has the following microservices:

- [**Taxonomy Framework Management:**](https://apis/dialapi/){:target="_blank"} Provides the ability to create, organise and manage taxonomy frameworks in a learning domain. This microservice is domain independent, i.e. can be used to model the taxonomy of any learning domain, e.g: K-12, Leadership training, Professional training, etc.
- **Content Category Management:** Provides the ability to create and manage categories for content, collections, and question sets.

## Telemetry & Data, Analytics Services

The **Telemetry & Data, Analytics Services** category has the following microservices:

- **Telemetry Service:** Provides services to collect telemetry and ingest the telemetry into the data pipeline for processing.
- **Data Service:** Provides services to manage report jobs and data exhausts.
- **Reports Service:** Provides services to create, review and publish reports to the Sunbird portal using the HawkEye framework.

## Registry & Discovery Services

The **Registry & Discovery Services** category has the following microservices:

- [**DIAL Service:**](https://apis/dialapi/){:target="_blank"} Provides services to manage and implement DIAL codes. DIAL is an open source framework to codify and link physical resources (like textbooks) with digital resources in a dynamic and extensible manner, using QR codes.
- **Search Service:** Provides services to search and discover content and knowledge assets.
- **User & Org Management:** This service enables a registry of users and organisations on the Sunbird platform. It provides services to manage the lifecycle, administration, and permissions of users and organisations.
- [**Location Service:**](https://apis/locationapi/){:target="_blank"} This service enables the registry of geographic locations. It provides services to create and manage locations for each organisation.
- [**Device Management:**](https://apis/deviceapi/){:target="_blank"} This service enables the registry of devices accessing the sunbird platform. The device profile and location of device is stored in the device registry.


## Interaction & Collaboration Services

The **Interaction & Collaboration Services** category has the following microservices:

- **Notifications Service:** Provides services to send user notifications using multiple channels such as email, SMS, and in-app.
- **Groups Service:** Provides services to create and managing groups of registered users, assign activities to group members and track assigned activities.



## Practice, Sensing & Assessment Services

The **Practice, Sensing & Assessment Services** category has the following microservice:

- **Assessment Service:** Provides services to create and manage questions and question sets that are useful to assess proficiency of learners.


## Credentialing & Badging Services

The **Credentialing & Badging Services** category has the following microservice:

- **Credentialing Service:** Provides services to issue digital certificates as per inCredible specifications. It also enables storage and verification of digitally issued certificates.

## Infra & Shared Services

The **Infra & Shared Services** category has the following microservices:

- **Configuration Management:** Provides services to manage configurations like system settings, and UI forms.
- **API Management:** Provides services to create, manage and validate API tokens, to register mobile and desktop apps, and to issue and refresh API tokens of registered mobile and desktop app devices.
- **Logging Service:** Provides services to client applications like mobile and desktop apps to save error logs on the server.



