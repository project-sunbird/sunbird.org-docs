---
title: Ansible Variables
page_title: Ansible Variables
description: Ansible Variables
keywords: ansible variables, variables
allowSearch: true
---
    
**Note**: 

    - If you want to run only Core services which will connect to Ekstep backend for other dependent services like Knowledge Platform and Data Pipeline, follow the below steps for Core module only**   **  
    - Once you complete the below steps, go to this page to get details on extra variables that need to be added for Core service only to work - [Additional-variables-for-Core-service](AnsibleVariables-Updatingprivaterepowithhostsandvariables) 
    
    
## Updating private repo with hosts and variables

1. git clone <a href="https://project-sunbird/sunbird-devops">https://github.com/project-sunbird/sunbird-devops</a>
2. cd sunbird-devops &amp;&amp; git checkout tags/release-2.0.0 -b release-2.0.0
3. cp -rf sunbird-devops/private_repo .
4. cd private_repo
5. Folder Structure for the private directory which contains ansible hosts secrets and variables.


## Folder Structure

tree ansible

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

        5 directories, 9 files

6. git init
7. git add
8. git commit -m "Creating private files"
9. git remote add origin ~private repo url~
10. git branch --set-upstream-to=origin/master master && git push --set-upstream origin master
11. update the variables and push it to upstream


## Updating variables and hosts

<ol><li><p>cd private_repo/ansible/inventory/dev/&lt;module&gt;/</p></li><li><p>update hosts common.yml secrets.yml</p></li></ol><p><br/></p><div class="table-wrap"><table class="wrapped confluenceTable" cellspacing="0" cellpadding="0" border="1"><colgroup><col width="100"/><col width="100"/><col width="135"/><col width="100"/><col width="388"/><col width="100"/></colgroup><tbody><tr><td class="confluenceTd"><a class="external-link" href="http://S.NO" rel="nofollow">S.NO</a></td><td class="confluenceTd">Service</td><td class="confluenceTd">Server</td><td class="confluenceTd">IP Address of the machine</td><td class="confluenceTd">Ansible Group Name</td><td class="confluenceTd">Module</td></tr><tr><td style="text-align: right;" class="confluenceTd">1</td><td class="confluenceTd">jenkins-master</td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td style="text-align: center;" colspan="1" rowspan="9" class="confluenceTd"><div>Core</div></td></tr><tr><td style="text-align: right;" class="confluenceTd">2</td><td class="confluenceTd">manager</td><td colspan="1" rowspan="3" class="confluenceTd"><div>Server-1 (swarm)</div></td><td colspan="1" rowspan="3" class="confluenceTd"><br/></td><td class="confluenceTd">swarm-manager-1,swarm-agent-for-prometheus-1<br/>swarm-agent-for-grafana-1, swarm-agent-for-alertmanager-1,</td></tr><tr><td style="text-align: right;" class="confluenceTd">3</td><td class="confluenceTd">log-es</td><td class="confluenceTd">log-es-1</td></tr><tr><td style="text-align: right;" class="confluenceTd">4</td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">5</td><td class="confluenceTd">keycloak</td><td colspan="1" rowspan="5" class="confluenceTd"><div>Server-2 (core-db)</div></td><td colspan="1" rowspan="5" class="confluenceTd"><br/></td><td class="confluenceTd">keycloak-1</td></tr><tr><td style="text-align: right;" class="confluenceTd">6</td><td class="confluenceTd">cassandra-lms (core)</td><td class="confluenceTd">cassandra-1</td></tr><tr><td style="text-align: right;" class="confluenceTd">8</td><td class="confluenceTd">Postgress</td><td class="confluenceTd">postgresql-master-1, postgresql-slave-1</td></tr><tr><td style="text-align: right;" class="confluenceTd">9</td><td class="confluenceTd">es-lms-1</td><td class="confluenceTd">es-1</td></tr><tr><td style="text-align: right;" class="confluenceTd">10</td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">11</td><td class="confluenceTd">cassandra-lp-dp</td><td colspan="1" rowspan="4" class="confluenceTd"><div>Server-3 (lp-db)</div></td><td colspan="1" rowspan="4" class="confluenceTd"><br/></td><td class="confluenceTd">lp-cassandra, dp-cassandra</td><td style="text-align: center;" colspan="1" rowspan="7" class="confluenceTd"><div>KnowledgePlatform</div></td></tr><tr><td style="text-align: right;" class="confluenceTd">12</td><td class="confluenceTd">kp-dp-es-1</td><td class="confluenceTd">composite-search-cluster,es-ps</td></tr><tr><td style="text-align: right;" class="confluenceTd">13</td><td class="confluenceTd">Postgress</td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">14</td><td class="confluenceTd">neo4j</td><td class="confluenceTd">learning-neo4j-node1</td></tr><tr><td style="text-align: right;" class="confluenceTd">15</td><td class="confluenceTd">learning-1</td><td colspan="1" rowspan="3" class="confluenceTd"><div>Server-4 (lp-services)</div></td><td colspan="1" rowspan="3" class="confluenceTd"><br/></td><td class="confluenceTd">learning1,logstash-ps</td></tr><tr><td style="text-align: right;" class="confluenceTd">16</td><td class="confluenceTd">redis</td><td class="confluenceTd">redis1</td></tr><tr><td style="text-align: right;" class="confluenceTd">17</td><td class="confluenceTd">search</td><td class="confluenceTd">search1</td></tr><tr><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">18</td><td class="confluenceTd">spark</td><td class="confluenceTd">Server 5 (spark)</td><td class="confluenceTd"><br/></td><td class="confluenceTd">spark</td><td style="text-align: center;" colspan="1" rowspan="8" class="confluenceTd"><div>Data Pipeline</div></td></tr><tr><td style="text-align: right;" class="confluenceTd">19</td><td class="confluenceTd">yarn-rm</td><td class="confluenceTd">Server 6 (yarn-RM)</td><td class="confluenceTd"><br/></td><td class="confluenceTd">yarn-master,yarn-ps</td></tr><tr><td style="text-align: right;" class="confluenceTd">20</td><td class="confluenceTd">yarn-slave</td><td class="confluenceTd">Server 7 (yarn-slave)</td><td class="confluenceTd"><br/></td><td class="confluenceTd">yarn-slave,yarn-ps</td></tr><tr><td style="text-align: right;" class="confluenceTd">21</td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">22</td><td class="confluenceTd">analytics-api</td><td colspan="1" rowspan="4" class="confluenceTd"><div>Server 8 (dp-services)</div></td><td colspan="1" rowspan="4" class="confluenceTd"><br/></td><td class="confluenceTd">analytics-api, analytics-ps,</td></tr><tr><td style="text-align: right;" class="confluenceTd">23</td><td class="confluenceTd">kafka-indexer</td><td class="confluenceTd">kafka-indexer</td></tr><tr><td style="text-align: right;" class="confluenceTd">24</td><td class="confluenceTd">secor</td><td class="confluenceTd">secor, secor-ps</td></tr><tr><td style="text-align: right;" class="confluenceTd">25</td><td class="confluenceTd">InfluxDB</td><td class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">26</td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td class="confluenceTd"><br/></td><td style="text-align: center;" class="confluenceTd"><br/></td></tr><tr><td style="text-align: right;" class="confluenceTd">27</td><td class="confluenceTd">kafka (Kp, Dp. Core)</td><td class="confluenceTd">Server 9 (kafka)</td><td class="confluenceTd"><br/></td><td class="confluenceTd">processing-cluster-kafka, processing-cluster-zookeepers, kafka-ps<br/>kafka-1</td><td class="confluenceTd">Common</td></tr></tbody></table>