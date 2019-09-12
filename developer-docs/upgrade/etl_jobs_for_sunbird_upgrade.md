---
title: ETL Jobs for Sunbird Upgrades
page_title:  ETL Jobs for Sunbird Upgrades
description:  ETL Jobs for Sunbird Upgrades
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, etl jobs
---

## Overview

### Cassandra Decrypt

As part of release-2.0.0, we were encrypting all user external identity in cassandra, but since this is not private data
from 2.3.0 we are storing it as plain text. For data which is already encrypted, below is the jenkins job to decrypt the 
data.

Job Name | Job Path |
--- | --- |
CassandraDecrypt |  Deploy/<\env\>/Core/CassandraDecrypt |
