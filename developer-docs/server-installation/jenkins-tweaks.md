<!DOCTYPE html>
<html>
    <head>
        <title>DevOps : Few Jenkins tweaks</title>
        <link rel="stylesheet" href="styles/site.css" type="text/css" />
        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>

    <body class="theme-default aui-theme-default">
        <div id="page">
            <div id="main" class="aui-page-panel">
                <div id="main-header">
                    <div id="breadcrumb-section">
                        <ol id="breadcrumbs">
                            <li class="first">
                                <span><a href="index.html">DevOps</a></span>
                            </li>
                                                    <li>
                                <span><a href="Sunbird-installation---Release-2.0.0_1058537560.html">Sunbird installation - Release 2.0.0</a></span>
                            </li>
                                                </ol>
                    </div>
                    <h1 id="title-heading" class="pagetitle">
                                                <span id="title-text">
                            DevOps : Few Jenkins tweaks
                        </span>
                    </h1>
                </div>

                <div id="content" class="view">
                    <div class="page-metadata">
                        
        
    
        
    
        
        
            Created by <span class='author'> Keshav Prasad</span>, last modified on Jun 29, 2019
                        </div>
                    <div id="main-content" class="wiki-content group">
                    <h3 id="FewJenkinstweaks-CreatingnewfoldersforJenkinsjobs"><strong>Creating new folders for Jenkins jobs</strong></h3><p>1. As an example, let us consider a scenario that your infrastructure currently consists of dev and production environment.<br/>2. In this scenario, the <strong>envOrder.txt</strong> file will have entry as</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd"><strong>dev=0</strong><br/><strong>production=1</strong></td></tr></tbody></table></div><p>3. The general jobs workflow is <strong>Build -&gt; ArtifactUpload -&gt; Deploy</strong><br/>4. The build job will auto trigger the artifact upload job. The artifact upload job will auto trigger the deploy job. This is only for the first environment. In this scenario, the dev environment<br/>5. The production directory will have deploy jobs which will take artifacts from the deploy directory of dev.<br/>6. The flow is same for any number of folders, the nth folder will take artifacts from n -1 folder. In case of the first directory (dev in this case, the deploy jobs will take artifact from ArtifactUpload job)<br/>7. Now let us consider we added a new environment called pre-production.<br/>8. If we want to create jobs for this environment, we just update the <strong>envOrder.txt</strong> and re-run the <strong>jenkins-jobs-setup.sh</strong> script.<br/>9. Now let us consider we have updated our <strong>envOrder.txt</strong> file as</p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd"><strong>dev=0</strong><br/><strong>pre-production=1</strong><br/><strong>production=2</strong></td></tr></tbody></table></div><p>10. When we run the <strong>jenkins-jobs-setup.sh</strong> script, it will first display the old structure of folders which is existing and ask for a confirmation if this is correct or not.<br/>11. Since we want to add a new environment, we need to tell the script that the old order is incorrect by specifying option as “n”.<br/>12. Now the script will ask us to update the <strong>envOrder.txt</strong>, which we already did.<br/>13. Re-run the script and it will display the updated environment order which we added in <strong>envOrder.txt</strong><br/>14. Provide confirmations to the script and restart Jenkins after executing the script.<br/>15. You will be able to see the new directory and jobs now on Jenkins.<br/>16. In this scenario, the production jobs will be configured to pick artifacts from pre-preoduction (earlier it was dev) and pre-preoduction job will be configured to pick artifacts from dev.</p><p><br/></p><h3 id="FewJenkinstweaks-RemovingfoldersforJenkinsjobs"><strong>Removing folders for Jenkins jobs</strong></h3><p>1. If you decide to purge some environment or no longer require Jenkins jobs for this environment, the process to update Jenkins jobs is quite simple.<br/>2. Follow the same steps as mentioned in Creating new folders for Jenkins jobs<br/>3. Instead of adding a new entry, just remove the environment you don’t require from the <strong>envOrder.txt</strong> file and update the order number (0,1,2 etc)<br/>4. Example:</p><p><em><u><strong>Before Purge</strong></u></em></p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd"><strong>dev=0</strong><br/><strong>pre-production=1</strong><br/><strong>production=2</strong></td></tr></tbody></table></div><p><u><em><strong>After Purge</strong></em></u></p><div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col/></colgroup><tbody><tr><td class="confluenceTd"><strong>dev=0</strong><br/><strong>production=1</strong></td></tr></tbody></table></div><p>5. Run the <strong>jenkins-jobs-setup.sh</strong> script as before and it will update the job configuration accordingly.<br/>6. Manually go and remove the pre-production directory from Jenkins UI if required.</p>
                    </div>

                    
                                                      
                </div>             </div> 
            <div id="footer" role="contentinfo">
                <section class="footer-body">
                    <p>Document generated by Confluence on Jul 16, 2019 18:44</p>
                    <div id="footer-logo"><a href="http://www.atlassian.com/">Atlassian</a></div>
                </section>
            </div>
        </div>     </body>
</html>
