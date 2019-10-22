---
title: Current Release Tags and Jenkins Jobs
page_title: Current Release Tags and Jenkins Jobs
description: Provides information on the Release Tags currently available and the Jenkins jobs that can use them
published: true
allowSearch: true
---

## Overview

This page provides information on the release tags available for Sunbird installation, the repository in which the latest code can be found and the jobs that can use them.

## List of Current Release Tags

> **Note**: The first tag against the repository name is the latest tag for that repository.


| Repository                | Current Release Tag           | Jobs using the Repository |
|--------------------------|-------------------------------|----------------------------|
| sunbird-devops            | release-2.3.0 | Build/Core/Player Build/Core/Proxy All jobs under ArtifactUpload/{{env}}/Core All jobs under Deploy/{{env}}/Core except FunctionalTestCases All jobs under OpsAdministration/{{env}}/Core All jobs under Provision/{{env}}/Core    |
| sunbird-lms-service       | release-2.3.0 | Build/Core/Learner       |
| sunbird-utils             | release-2.3.0 | Build/Core/Cassandra |
| sunbird-content-service   | release-2.3.0 | Build/Core/Content |
| sunbird-auth              | release-1.15.0 | Build/Core/Keycloak |
| SunbirdEd-portal          | release-2.3.0 | Build/Core/Player |
| sunbird-telemetry-service | release-2.1.0 | Build/Core/Telemetry |
| sunbird-course-service    | release-2.3.0 | Build/Core/Lms | 
| sunbird-data-pipeline     | release-2.3.0| Build/DataPipeline/DataPipeline All jobs under ArtifactUpload/{{env}}/DataPipeline All jobs under Deploy/{{env}}/DataPipeline All jobs under OpsAdministration/{{env}}/DataPipeline All jobs under Provision/{{env}}/DataPipeline|
| secor                     | secor-0.25 | Build/DataPipeline/Secor  |
| sunbird-analytics         | release-2.3.0 | Build/DataPipeline/Analytics|
| sunbird-learning-platform | release-2.3.0 | All jobs under Build/KnowledgePlatform All jobs under ArtifactUpload/{{env}}/KnowledgePlatform All jobs under Deploy/{{env}}/KnowledgePlatform All jobs under OpsAdministration/{{env}}/KnowledgePlatform All jobs under Provision/{{env}}/KnowledgePlatform |
