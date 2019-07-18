---
title: Jenkins Tweaks
page_title: Jenkins Tweaks
description: Jenkins Tweaks
keywords: Jenkins Tweaks 
allowSearch: true
--- 


## **Creating new folders for Jenkins jobs** 

1. As an example, let us consider a scenario that your infrastructure currently consists of dev and production environment.

2. In this scenario, the **envOrder.txt** file will have entry as <div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd">**dev=0**
**production=1**</td></tr></tbody></table></div> 

3. The general jobs workflow is **Build -&gt; ArtifactUpload -&gt; Deploy** 

4. The build job will auto trigger the artifact upload job. The artifact upload job will auto trigger the deploy job. This is only for the first environment. In this scenario, the dev environment 

5. The production directory will have deploy jobs which will take artifacts from the deploy directory of dev. 

6. The flow is same for any number of folders, the nth folder will take artifacts from n -1 folder. In case of the first directory (dev in this case, the deploy jobs will take artifact from ArtifactUpload job) 

7. Now let us consider we added a new environment called pre-production. 

8. If we want to create jobs for this environment, we just update the **envOrder.txt** and re-run the **jenkins-jobs-setup.sh** script. 

9. Now let us consider we have updated our **envOrder.txt** file as 

    <div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd">**dev=0**

 **pre-production=1** **production=2**

10. When we run the **jenkins-jobs-setup.sh** script, it will first display the old structure of folders which is existing and ask for a confirmation if this is correct or not. 

11. Since we want to add a new environment, we need to tell the script that the old order is incorrect by specifying option as “n”. 

12. Now the script will ask us to update the **envOrder.txt**, which we already did. 

13. Re-run the script and it will display the updated environment order which we added in **envOrder.txt** 

14. Provide confirmations to the script and restart Jenkins after executing the script. 

15. You will be able to see the new directory and jobs now on Jenkins. 16. In this scenario, the production jobs will be configured to pick artifacts from pre-preoduction (earlier it was dev) and pre-preoduction job will be configured to pick artifacts from dev.    

## Removing folders for Jenkins jobs  

1. If you decide to purge some environment or no longer require Jenkins jobs for this environment, the process to update Jenkins jobs is quite simple. 

2. Follow the same steps as mentioned in Creating new folders for Jenkins jobs 

3. Instead of adding a new entry, just remove the environment you don’t require from the **envOrder.txt** file and update the order number (0,1,2 etc) 

4. Example:  

**Before Purge**

        dev=0 
        pre-production=1 
        production=2
    
**After Purge**

        dev=0
        production=1
        
5. Run the **jenkins-jobs-setup.sh** script as before and it will update the job configuration accordingly. 

6. Manually go and remove the pre-production directory from Jenkins UI, if required. 
                