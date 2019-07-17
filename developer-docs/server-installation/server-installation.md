---
title: Installation
page_title: Installation
description: Infrastructure Design
keywords: infrastructure, design, infrastructure components
allowSearch: true
---


## Jenkins Setup

1. SSH to the Jenkins server
    - `git clone` <a href="https://github.com/project-sunbird/sunbird-devops.git" rel="nofollow" class="external-link">https://github.com/project-sunbird/sunbird-devops.git</a>** 
    - `cd sunbird-devops && git checkout tags/release-2.0.0 -b release-2.0.0`
    - `cd deploy/jenkins`
    - `sudo bash jenkins-server-setup.sh`
        
2. Once the `jenkins-server-setup.sh` script completes, open jenkins in browser by typing **domain-name:8080 / public-ip:8080**

3. Enter the initial password. Follow the on screen instructions. 

4. Choose install suggested plugin 

5. Create a admin user 6. Choose the default jenkins URL. You can either change this to your domain name or public IP. If in doubt, just use whatever is displayed on screen as this can be changed later if required in Jenkins configuration.

7. Switch back to the terminal session on the Jenkins server</p><div class="table-wrap"><table class="wrapped confluenceTable"><tbody><tr><td class="confluenceTd">
        
    - `sudo bash jenkins-plugins-setup.sh`
    - Enter the URL as localhost:8080
    - Enter the admin username and password

    
8. Now go to Manage Jenkins -&gt; Manage Plugins -&gt; Update Center -&gt; Check status of plugin install. If any plugins failed to install, install them manually by visiting the plugins section of Jenkins

9. Now switch back to the terminal session on the Jenkins server</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd">** cp envOrder.txt.sample envOrder.txt**  ** vi envOrder.txt** </td></tr></tbody></table></div>

10. Update the environment list as per your infrastructure in ascending order. For example if you have only dev and production, your ** envOrder.txt**will look like</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd"> ** dev=0**  **  production=1** </td></tr></tbody></table></div><p>

11. Now run the ** jenkins-jobs-setup.sh**script</p><div class="table-wrap"><table class="wrapped confluenceTable"><tbody><tr><td class="confluenceTd">** sudo bash jenkins-jobs-setup.sh** </td></tr></tbody></table></div><p>

12. Follow the onscreen instruction of the script. Provide choice as yes for all questions. The options are case sensitive, the script will display the accepted options. 

13. Once the script completes copying the job config, go to the browser and restart jenkins using ** public-ip:8080/restart OR domain-name:8080/restart**  

14. Go to ** http://&lt;jenkins_domain&gt;/credentials/store/system/domain/_/newCredentials**  

15. Select Username with Password 

16. Enter the username and password of the github account where the private repo will be hosted. 

17. Enter a unique long string for the ID field such as ** private-repo-creds**  

18. You can provide the description as private repo credentails and click OK. 

19. ** Goto http://&lt;jenkins_domain&gt;/configure**  

20. Choose the check box named “Environment variables” 

21. Click on Add and enter the following Name, Value pairs</p><div class="table-wrap">
<table class="wrapped confluenceTable"><colgroup><col style="width: 249.0px;"/><col style="width: 1505.0px;"/></colgroup><tbody><tr><th class="confluenceTh"><p>** Name** </p></th><th class="confluenceTh"><p>** Value** </p></th></tr><tr><td class="confluenceTd"><p>** ANSIBLE_FORCE_COLOR** </p></td><td class="confluenceTd"><p>true</p></td></tr><tr><td class="confluenceTd"><p>** ANSIBLE_HOST_KEY_CHECKING** </p></td><td class="confluenceTd"><p>false</p></td></tr><tr><td class="confluenceTd"><p>** ANSIBLE_STDOUT_CALLBACK** </p></td><td class="confluenceTd"><p>debug</p></td></tr><tr><td colspan="1" class="confluenceTd"><p>** hub_org** </p></td><td colspan="1" class="confluenceTd"><p>docker hub organization / username eg: In sunbird/player image, sunbird is the hub_org</p></td></tr><tr><td colspan="1" class="confluenceTd"><p>** private_repo_branch** </p></td><td colspan="1" class="confluenceTd"><p>The branch name in the private repository which you would like to use. This branch will have the inventory and secrets</p></td></tr><tr><td colspan="1" class="confluenceTd"><p>** private_repo_credentials** </p></td><td colspan="1" class="confluenceTd"><p>The unique string which you provided for ID field while entering the github repo credentials. eg: ** private-repo-creds** </p></td></tr><tr><td colspan="1" class="confluenceTd"><p>** private_repo_url** </p></td><td colspan="1" class="confluenceTd"><p>The github URL to your private repo. You can visit your private repo and click on clone button, which will display the https URL to your private repository. Only https URL is currently supporrted.</p></td></tr><tr><td colspan="1" class="confluenceTd"><p>** public_repo_branch** </p></td><td colspan="1" class="confluenceTd"><p>This is the branch or tag from where Jenkinsfile will be picked up. You can set this value as refs/tags/release-1.14.0 if you want to build from tags or provide the value of development branch like release-1.15 (not recommened since development branches are not stable). </p></td></tr><tr><td colspan="1" class="confluenceTd">** override_private_branch** </td><td colspan="1" class="confluenceTd">true</td></tr><tr><td colspan="1" class="confluenceTd">** override_public_branch** </td><td colspan="1" class="confluenceTd">true</td></tr></tbody></table></div><p>22. Scroll down to “Global Pipeline Libraries” section and click Add. Provide the values as below</p><div class="table-wrap"><table class="relative-table wrapped confluenceTable" style="width: 80.95%;"><colgroup><col style="width: 16.47%;"/><col style="width: 83.48%;"/></colgroup><tbody><tr><th class="confluenceTh">** Name** </th><th class="confluenceTh">Value</th></tr><tr><td class="confluenceTd">** Library Name** </td><td class="confluenceTd">deploy-conf</td></tr><tr><td class="confluenceTd">** Default version** </td><td class="confluenceTd">Tag name of the jenkins shared library. This should be same version of the release you are going to build and deploy. For example, if you decide to use tags release-2.0.0 as your base, jenkins shared library tag will be release-2.0.0-shared-lib. When you upgrade to tag release-2.1.0, this value should get changed to release-2.1.0-shared-lib</td></tr><tr><td class="confluenceTd">** Retrieval method** </td><td class="confluenceTd">Modern SCM</td></tr><tr><td colspan="1" class="confluenceTd">** Source Code Management** </td><td colspan="1" class="confluenceTd">Git</td></tr><tr><td colspan="1" class="confluenceTd">** Project Repository** </td><td colspan="1" class="confluenceTd"><a href="https://github.com/project-sunbird/sunbird-devops.git" rel="nofollow" class="external-link">https://github.com/project-sunbird/sunbird-devops.git</a></td></tr></tbody></table></div><p>


23. Click on Save and go to Manage Jenkins -&gt; Configure global security 

24. Choose the “Markup Formatter” as “Safe HTML” 

25. Go to Manage Jenkins -&gt; Manager Nodes -&gt; Click master -&gt; Click Configure -&gt; Provide labels as “** build-slave** ” 26. Set the number of executors to a number like 15 if your system configuration is 16 GB RAM and 4 core CPU. Adjust this number accordingly based on your system configuration 27. Restart jenkins by running ** sudo service jenkins restart**  28. Switch back to the terminal session on Jenkins server</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd">** sudo su jenkins**  ** mkdir -p /var/lib/jenkins/secrets &amp;&amp; cd /var/lib/jenkins/secrets**  ** touch deployer_ssh_key ops_ssh_key vault-pass**  ** chmod 400 deployer_ssh_key ops_ssh_key vault-pass** </td></tr></tbody></table></div><p>

29. The key which you used to login to the Jenkins server will be called as ** ops_ssh_key**from now on wards. Example:</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd">** ssh -i somekey.pem ubuntu@jenkins-server-ip**  Here <em>** somekey.pem** </em> is the key you used to login to the Jenkins server which will be called as ** ops_ssh_key** </td></tr></tbody></table></div><p>

30. Copy the contents of the key you used to connect to VM into ** ops_ssh_key**file 

31. Create a new ssh key on your local machine or any server. We will use this for a user named ** deployer**(or any name you like) 

32. ** ssh-keygen -f deployer_ssh_key**(passphrase should be empty) 

33. Copy the contents of the ** deployer_ssh_key**into** /var/lib/jenkins/secrets/deployer_ssh_key**  

34. If your github private repo consists of ansible encrypted files, then enter the decryption password in **/var/lib/jenkins/secrets/vault-pass** . If there are no encrypted files, then enter some random value like ** 12345**into the** vault-pass file. This file cannot be empty. 

35. Restart Jenkins server

36. **IMPORTANT: OPEN any one of the config file from Deploy directory and save it. Without this some of the parameters will not be visible.** 

37. Follow the next set of steps to create inventory, secrets and ansible hosts in the private repo.