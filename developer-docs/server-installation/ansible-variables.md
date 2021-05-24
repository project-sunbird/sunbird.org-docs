---
title: Ansible Variables Setup
page_title: Ansible Variables Setup
description: Setting up the Ansible variables in the private GitHub repository
keywords: ansible variables, variables, private GitHub repository, private repo
allowSearch: true
---
## Overview

Ansible is the configuration management system used in Sunbird. The entire infrastructure setup, build and deployment of services and other configurations is handled primarily through ansible.

## Updating the Private Repository with Hosts and Variables

Use the following git commands sequentially to clone and update your private GitHub repository: 

1. `git clone` <a href="https://project-sunbird/sunbird-devops"><https://github.com/project-sunbird/sunbird-devops></a>

2. `cd sunbird-devops; git checkout tags/release-3.8.0_RC13 -b release-3.8.0_RC13`

3. Copy the directory `sunbird-devops/private_repo/ansible` to your private repo

4. Update the files **common.yml**, **hosts**, and **secrets.yml** under **Core**, **KnowledgePlatform** and **DataPipeline** directories. After updating, push them to your private repo branch. Your private repo structure starting from the root path should be exactly as shown below.
  
```bash
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

> Note:
>
>- The ansible inventory setup is a must before we can start to run jobs from the **Provision**, **ArtifactUpload** and **Deploy** directory in Jenkins. The **Build** directory on Jenkins does not require the ansible variables
>- It is highly recommended that you complete the ansible inventory update before proceeding further
