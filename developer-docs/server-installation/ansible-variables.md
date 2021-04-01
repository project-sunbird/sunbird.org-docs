---
title: Ansible Variables Setup
page_title: Ansible Variables Setup
description: Setting up the Ansible variables in the private GitHub repository
keywords: ansible variables, variables, private GitHub repository, private repo
allowSearch: true
---
## Overview

Sunbird uses Ansible playbooks to manage its three major sub-systems (Knowledge Platform, Data Pipeline and Core Services), to ensure scalability, consistency and reliability of its IT environment. The Ansible variables help server setup, configuration management and automate deployment.   

    
## Updating the Private Repository with Hosts and Variables

Use the following Git commands sequentially to clone and update your private GitHub repository: 

1. `git clone` <a href="https://project-sunbird/sunbird-devops">https://github.com/project-sunbird/sunbird-devops</a>

2. `cd sunbird-devops; git checkout tags/release-3.7.0_RC15 -b release-3.7.0`

3. Copy the directory `sunbird-devops/private_repo/ansible` to your private repo location

4. Update the files `common.yml`, `hosts`, `secrets.yml` under `Core`, `KnowledgePlatform` and `DataPipeline`. After updating, push them to your private repo branch. The structure under the `ansible` directory is shown below.


> **Note** The following depicts the folder structure required in the private GitHub repository that contains Ansible hosts, secrets and variables.
  
```
ansible
└── inventory
    └── dev
        ├── Core
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        ├── DataPipeline
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        └── KnowledgePlatform
            ├── common.yml
            ├── hosts
            └── secrets.yml
```
