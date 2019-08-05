---
title: Running Builds, Artifact Uploads and Deployments
page_title: Running Builds, Artifact Uploads and Deployments
description: An overview to running builds, artifact uploads and deployments
keywords: Running builds, builds, artifact Uploads, Deployment
allowSearch: true
--- 

## Overview

After completing the Jenkins setup, you need to build and deploy Sunbird services to bring up the Sunbird instance. Sunbird services are deployed through build jobs. Most of the build jobs create artifacts either as zip files or docker images.

>To understand the scripts, jobs, job parameters and the associated environment variables, refer to the [Understanding Jenkins Scripts](developer-docs/server-installation/understanding-jenkins-scripts-jobs-parameters-and-variables) page. 


To understand the artifact upload jobs, refer to the [Artifact Uploads Jobs](developer-docs/server-installation/artifactupload-job) page. 


Adhere to the following sequence to deploy the services: 

1. [Artifact Upload Jobs](developer-docs/server-installation/artifactupload-job/)
2. [Knowledge Platform](developer-docs/server-installation/knowledge-platform)
3. [DataPipeline](developer-docs/server-installation/data-pipeline)
4. [Core Services](developer-docs/server-installation/artifactupload-job/core-services)