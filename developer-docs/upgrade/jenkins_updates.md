---
title: Jenkins Updates
page_title:  Jenkins Updates
description:  Jenkins Updates
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0, jenkins updates
---
## Overview


## Process

1. If you need to make changes to some of the Jenkins jobs, do not directly make changes to the pre-configured jobs. Always create a job using the old job as template and make the custom changes.
2. Whenever a new configuration change is release by sunbird for a particular release, it is mandatory that you update your Jenkins jobs with the new updated configuration provided in the release.
3. By not updating the jobs configuration, the job may fail if there are some under the hood changes to Jenkinsfile, shared libraries or Jenkins parameters.
4. As part of the upgrade, the existing jobs which sunbird provides (not custom ones which you have created) are overwritten with new content.
5. Before upgrading, always take a backup of your existing configration using thin backup in Jenkins.
6. Once you are ready to upgrade, follow the below set of steps.

```
git clone https://github.com/project-sunbird/sunbird-devops.git
cd sunbird-devops && git checkout tags/release-2.0.0 -b release-2.0.0
cd deploy/jenkins
```
7. If there is no change in the folders or environments from your original setup, then you can just run the below scripts

```
sudo bash jenkins-server-setup.sh (to install if any new packages are required for jobs)
sudo bash jenkins-plugins-setup.sh (to install any new plugins that are required for jobs)
sudo bash jenkins-jobs-setup.sh (to update the job configurations)
```
8. If there are changes in environment and you require additional folders for other environments, then update the envOrder.txt file with new environment order and run the script.
9. The script will show the list if differences between your current configuration and new configuration. Take a deep look at these changes and when you are ready to update, provide the confirmation as YES.
10. The script will overwrite the existing jobs (only those sunbird provides by default) and update the configurations with new changes of that release.
11. Add the below two Jenkins environment variables under Mange Jenkins → Configure System

```
override_private_branch	true
override_public_branch	true
```
12. Go to Manage Jenkins → Configure System → Global Pipeline Libraries → Change Default Version to release-2.0.0-shared-lib
13. Go to Manage Jenkins → Configure System →Update public_repo_branch to refs/tags/release-2.0.0
14. Go to Manage Jenkins → Configure System →Update private_repo_branch to the branch name of your private repo branch in case you created a new branch for release-2.0.0 inventory updates.
15. Restart your Jenkins and you are ready to go.14. Restart your Jenkins and you are ready to go.
16. IMPORTANT: OPEN any one of the config file from Deploy directory and save it. Without this some of the new parameters may not be visible.
17. You can take a look at whats changed in existing job and accordingly update your custom job manually so that the same changes are available in your custom jobs.