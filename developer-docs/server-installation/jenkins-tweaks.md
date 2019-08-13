---
title: Jenkins Tweaks
page_title: Jenkins Tweaks
description: Jenkins Tweaks
keywords: Jenkins Tweaks 
allowSearch: true
--- 

## Overview

This page explains how to create and remove folders for Jenkins Jobs

## Creating Folders for Jenkins Jobs 

The process of creating folders for Jenkins jobs is best explained using a scenario. 
Consider the scenario in which your current infrastructure consists of two environments - **dev** and **production**. In this scenario, the **envOrder.txt** file has an entry: 

```
dev=0
production=1
```

The general jobs workflow is **Build -> ArtifactUpload -> Deploy** 
The **Build** job automatically triggers the **ArtifactUpload** job which in turn automatically triggers the **Deploy** job. This workflow is executed only for the first environment, which in the example scenario is, the **dev** environment.  
The **production** environment has deploy jobs that pick up artifacts from the **Deploy** directory of the **dev** environment. 
The workflow remains the same irrespective of the number of directories in an environment.  The nth directory picks up artifacts from the n -1 directory. In case of the first directory, (in the example scenario, the dev directory) the deploy jobs pick up artifacts from ArtifactUpload job. 

Now, consider a new scenario in which there is an added environment named **pre-production**.  To add this environment and create jobs for this environment, do the following steps:

1.Update the **envOrder.txt** file and re-run the **jenkins-jobs-setup.sh** script.  

2.Hence, consider that the **envOrder.txt** file is updated as: 

        dev=0
        pre-production=1 
        **production=2

3.On executing the  **jenkins-jobs-setup.sh** script, it first displays the old, existing folder structure and checks for confirmation on its correctness. 

4.Since a new environment is getting added, specify the option as *n* in the confirmation dialogue box. 

5.Update the **envOrder.txt**.  (This is already done in the previous steps) 

6.Re-run the script and it displays the updated environment order that is added in the **envOrder.txt** file. 

7.Specify *y* in the script's confirmation dialogue box and restart Jenkins after executing the script. 

8.You can now see the new directory and jobs on Jenkins. 

9.In this scenario, the production jobs are configured to pick artifacts from the pre-production directory, and pre-production jobs are configured to pick artifacts from the dev environment.    
Repeat the steps to add any new environment and create jobs in that environment.
 
## Removing Folders for Jenkins Jobs  

To purge an environment or if you no longer require Jenkins jobs for the environment, the process to update Jenkins jobs is quite simple. Follow the same steps as mentioned in [Creating New Folders for Jenkins Jobs](#creating-folders-for-jenkins-jobs). However, instead of adding a new entry, remove the environment that is not required from the **envOrder.txt** file and update the order number (0,1,2 etc) 

Keeping the same scenario as in the **Creating New Folders for Jenkins Jobs** section:  

**Before Purge** the file entry is as follows:


    dev=0 
    pre-production=1 
    production=2

**After Purge** the file entry is as follows


    dev=0
    production=1


1.Run the **jenkins-jobs-setup.sh** script as mentioned in above steps, this updates the job configuration accordingly. 
2.You can also manually remove the **pre-production** environment from the Jenkins UI. 

Repeat the same steps to remove any environment.              
