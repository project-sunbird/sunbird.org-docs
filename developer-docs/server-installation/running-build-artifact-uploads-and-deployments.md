---
title: Running Builds, Artifact Uploads and Deployments
page_title: Running Builds, Artifact Uploads and Deployments
description: An overview to running builds, artifact uploads and deployments
keywords: Running builds, builds, artifact Uploads, Deployment
allowSearch: true
--- 

## Overview

After completing the Jenkins setup, you need to build and deploy Sunbird services to bring up the Sunbird instance. Sunbird services are deployed through build jobs. Most of the build jobs create artifacts either as zip files or docker images.

> **Note**:To understand the scripts, jobs, job parameters and the associated environment variables, refer to the [Understanding Jenkins Scripts](developer-docs/server-installation/understanding-jenkins-scripts-jobs-parameters-and-variables){:target="_blank"} page. 

Adhere to the following sequence to deploy the services: 

1. [Knowledge Platform](developer-docs/server-installation/knowledge-platform){:target="_blank"}
2. [DataPipeline](developer-docs/server-installation/data-pipeline){:target="_blank"}
3. [Core Services](developer-docs/server-installation/core-services){:target="_blank"}
