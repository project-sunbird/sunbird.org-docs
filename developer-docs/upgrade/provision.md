---
title: Provision
page_title: Provision
description: Provision
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, Provision
---

## Overview

**IMPORTANT**: 1. Once all the variables and Jenkins configurations are complete, you can start provision and 
then go for build and deployment steps.
2. Provision all the services mentioned in the table below.

## Provision

Job Name | Job Path |
--- | --- |
Analytics API| Provision/\<env\>/DataPipeline/AnalyticsAPI |
LP Elasticsearch| Provision/\<env\>/KnowledgePlatform/CompositeSearch |
LogEsUpgrade6xx| Provision/\<env\>/Core/LogEsUpgrade6xx |
ESMapping| OpsAdministration/\<env\>/Core/ESMapping |

**Note**: For ESMapping Job provide the parameter value for **branch_name** as **course-batch-refactoring**
