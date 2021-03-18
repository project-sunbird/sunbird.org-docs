---
title: Update Ansible Variables
page_title:  Update Ansible Variables
description:  Update Ansible Variables
published: true
allowSearch: true
keywords: Upgrade, Sunbird 3.6.0, variable, Ansible updates
---
## Overview
As part of every release, new ansible variables are introduced. It is mandatory to update your inventory with the new variables for every release. These will be used by various services and without variables, Sunbird will not work as expected.

## Steps to update variables

1.git clone https://github.com/project-sunbird/sunbird-devops  
2.git checkout tags/release-3.5.0 -b release-3.5.0  
3.git checkout tags/release-3.6.0_RC8 -b release-3.6.0  
4.cd sunbird-devops/private_repo  
5.git diff release-3.5.0 ansible  
    OR 
6.git diff --word-diff=porcelain release-3.5.0 ansible


This will show the differences in variables between release-3.5.0 and release-3.6.0. If the line is in green, it means its newly added. If the line is in red, it means it has been removed.

Optional: Create a new branch in your private repo (in order to keep a older inventory copy as backup).

Update your private repo with the new variables and inventory group name changes as show by the diff command. Commit your changes and push it to your private repo branch.
