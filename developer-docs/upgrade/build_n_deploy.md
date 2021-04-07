---
title: Build and Deploy
page_title: Build and Deploy
description: Build and Deploy
published: true
allowSearch: true
keywords: Upgrade, Sunbird 3.8.0
---

## Overview

This page details out the jobs required to be run as part of the upgrade from Sunbird release 3.7.0 to release 3.8.0. Use the following table to understand the jobs that need to be executed in order to successfully complete the upgrade. 

## Running the Builds 

**IMPORTANT**: 

1. Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider.

2. Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.

| Variable Name| Service Name| Default Public Value |Private Value Override  | Comments              |
|--------------|-------------|----------------------|------------------------|-----------------------|
| sunbird_portal_offline_supported_languages | player service| Default Public Value |Private Value Override  | player service |
| adminutil_refresh_token_secret_key | Adminutils | NA |NA  | Go to http://{{KEYCLOAK_IP}}/auth/admin/master/console/#/realms/sunbird/keys  Get this secret value from DB, login to postgres keycloak 7 DB and run the below query:                                                  SELECT value FROM component_config CC INNER JOIN component C ON(CC.component_id = C.id) WHERE C.realm_id = 'sunbird' and provider_id = 'hmac-generated' AND CC.name = 'secret';                                                                                              More details with pictures are updated in this link - https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/2281734145/Keycloak+Upgrade+from+3.2.0+to+7.0.1                                                                                                     Done as part of release-3.7.0 hotfix|

3. Build and Deploy all the services mentioned in the table below.

The following is the list of jobs required to be built and deployed :

Order: Top down per column


| Service to be Build| Build Tag   | Service to Deploy |Deploy Tag  | Comments |
|--------------------|-------------|-------------------|------------|----------|
| KP-FlinkJobs       |release-3.8.0_RC4|KP-flink       |release-3.8.0||
| KafkaSetup         |                 | KafkaSetup    |release-3.8.0_RC2||
| Learning           |release-3.8.0_RC9| Learning      |release-3.8.0|
| LoggingFileBeatsVM |                 | LoggingFileBeatsVM|release-3.8.0||
| Yarn               |release-3.8.0_RC9| Yarn          |release-3.8.0||
|                    |                 | analytics spark provision  |||
| AnalyticsCore      | release-3.8.0_RC1| AnalyticsCore|release-3.8.0||
| AnalyticsFetchLogs |                 |AnalyticsFetchLogs|release-3.8.0||
| CoreDataProducts   | release-3.8.0_RC1|CoreDataProducts |release-3.8.0||
| ETLJobs            | release-3.8.0_RC4| ETLJobs      | release-3.8.0||
| ETLUserCacheIndexer| release-3.8.0_RC4| ETLUserCacheIndexer|release-3.8.0_RC4||
| EdDataProducts | release-3.8.0_RC5 | EdDataProducts |release-3.8.0||
| FlinkPipelineJobs | release-3.8.0_RC4 | FlinkPipelineJobs |release-3.8.0||
| OfflineInstaller | release-3.8.0| OfflineInstaller |release-3.5.0||
| AdminUtils | release-3.7.0_RC1 | AdminUtils | release-3.8.0||
| Assessment | release-3.8.0_RC2 | Assessment | release-3.8.0||
| Bot | release-3.8.0_RC1 |  Bot |release-3.8.0||
| Content | release-3.8.0_RC3 | Content | release-3.8.0_RC7||
| DiscussionsMW | release-3.8.0_RC2 | DiscussionsMW |release-3.8.0||
| Groups | release-3.7.0_RC5 | Groups| release-3.8.0||
| Keycloak | keycloak7 | Keycloak |release-3.8.0| private branch: keycloak7||
| KnowledgeMW | release-3.8.0_RC3 | KnowledgeMW | release-3.8.0||
| Learner | release-3.8.0_RC9 | Learner | release-3.8.0||
| Lms | release-3.8.0_RC5 | Lms| release-3.8.0||
| LoggingFileBeatsVM |  | LoggingFileBeatsVM | release-3.8.0||
| Monitoring |  | Monitoring |release-3.8.0||
| Nodebb | release-3.7.0_RC6 | Nodebb| release-3.8.0||
| OnboardAPIs |  | OnboardAPIs| release-3.8.0_RC1||
| Player | release-3.8.0_RC9 | Player| release-3.8.0||
| Router | release-3.8.0_RC1 | Router | release-3.8.0||
| Taxonomy | release-3.6.0_RC3 | Taxonomy| release-3.8.0||
| UploadSchemas | knowledge-platform : release-3.8.0_RC2 | UploadSchemas | release-3.8.0||
| cassandra-migration | sunbird-utils : release-3.8.0_RC1| | release-3.8.0_RC1||

Any Configurations OR Manual Steps OR Instructions - Please add here

| |          | |  |  |
|--------------------|--------------------|-------------------|------------|----------|
| enable aks autoscaling for aks cluster from azure portal| current staging nodes was4.updated 4 as min nodes and 8 max   |  | | |
| Delete old user index from dev and stage env| Delete old user index from dev and stage env  | To delete user index, run the below curl: curl --location --request DELETE 'localhost:9200/user?pretty' |  |  |
| Form configuration | Manual task|  |  | Check below the curl command |
| Updated jenkins job| Deploy/KnowledgePlatform/FlinkJobs| https://github.com/project-sunbird/sunbird-devops/pull/2322 |  |  |
| ES Re-indexing| ES Re-indexing          |  |  | https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2346156058/SC-2190+ES+scaling+-+reindexing+Org+index Please follow the steps in above link for re-indexing and after this only deploy the lerner tag. |
| update the form as in https://project-sunbird.atlassian.net/browse/SB-23481| |  |  | |
| update the form as in https://project-sunbird.atlassian.net/browse/SB-23627| |  |  | |
| update the form as in https://project-sunbird.atlassian.net/browse/SB-23671| |  |  | |
| adminutils_autoscaling_enabled: true analytics_autoscaling_enabled: true apimanager_autoscaling_enabled: true apimanagerecho_autoscaling_enabled: true assessment_autoscaling_enabled: true cert_autoscaling_enabled: true certregistry_autoscaling_enabled: true content_autoscaling_enabled: true enc_autoscaling_enabled: true groups_autoscaling_enabled: true knowledgemw_autoscaling_enabled: true learner_autoscaling_enabled: true lms_autoscaling_enabled: true nginx_private_ingress_autoscaling_enabled: true notification_autoscaling_enabled: true player_autoscaling_enabled: true print_autoscaling_enabled: true search_autoscaling_enabled: true taxonomy_autoscaling_enabled: true telemetry_autoscaling_enabled: true|adminutils</br> analytics</br> apimanager</br> apimanagerecho</br> assessment </br>cert </br>certregistry</br> enc</br> groups </br>knoeledgemw </br> learner </br> lms </br>nginx-private</br> notification </br>player </br>print</br> search </br>taxonomy </br>telemetry | FALSE | TRUE | not required for preprod and prod|
| ES Reindexing| ES Reindexing          |  |  | https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2346156058/SC-2190+ES+scaling+-+reindexing+Org+index Please follow the steps mentioned in the doc and delete the orgv1 index if exist |


Form configuration

```

curl 'https://preprod.ntp.net.in/api/data/v1/form/read' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Channel-Id: 01268904781886259221' \
  -H 'X-App-Id: preprod.diksha.portal' \
  -H 'ts: 2021-03-11T18:13:56+05:30' \
  -H 'X-App-Version: 3.7.0' \
  -H 'X-msgid: afb53e02-74fb-fedf-4b2e-28d2327a66ba' \
  -H 'X-Org-code: 01268904781886259221' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36' \
  -H 'X-Source: web' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'X-Session-ID: b12ff0ad-7917-85b1-06f9-adeac5f63e3b' \
  -H 'X-Device-ID: 32d664e1c6de5894205a18003eaa051f' \
  -H 'X-Request-ID: afb53e02-74fb-fedf-4b2e-28d2327a66ba' \
  -H 'Origin: https://preprod.ntp.net.in' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://preprod.ntp.net.in/explore' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  --data-raw '{"request":{"type":"content","action":"search","subType":"resourcebundle","rootOrgId":"01268904781886259221"}}' \
  --compressed

```


Form api update with the given request body(https://project-sunbird.atlassian.net/browse/SB-23859)

```

{"request":{"type":"group","subType":"supported_activities","action":"list","component":"*","framework":"*","rootOrgId":"*","data":{"templateName":"supported_activities","action":"list","fields":[{"index":0,"activityType":"Explanation Content","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Explanation Content\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Explanation Content","translations":"{\"en\": \"Explanation Content\", \"as\": \"ব্যাখ্যা কৰা বিষয়বস্তু\", \"bn\": \"বিষয়বস্তুর ব্যাখ্যা\", \"gu\":\"એક્સપ્લેનેશન કન્ટેન્ટ\", \"hi\":\"स्पष्टीकरण सामग्री\", \"kn\":\"ವಿವರಣಾತ್ಮಕ ಪಠ್ಯಾಂಶ\", \"mr\":\"स्पष्टीकरण सामग्री\", \"or\":\"ବିସ୍ତାରିତ କଣ୍ଟେଣ୍ଟ୍\", \"pa\":\"ਵਿਆਖਿਆ ਕੰਟੇਂਟ\", \"ta\":\"விளக்க உள்ளடக்கம்\", \"te\":\"అర్థము కంటెంట్\", \"ur\":\"وضاحت کا مواد\"}"},{"index":1,"activityType":"Learning Resource","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Learning Resource\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Learning Resource","translations":"{\"en\": \"Learning module\", \"as\": \"শিক্ষণৰ ম'ডিউল\", \"bn\": \"প্রশিক্ষণ মডিউল\", \"gu\":\"શીખવાનું મોડ્યુલ\", \"hi\":\"अध्ययन मॉड्यूल\", \"kn\":\"ಕಲಿಕಾ ಮಾಡ್ಯೂಲ್\", \"mr\":\"अभ्यास विभाग\", \"or\":\"ଶିକ୍ଷଣ ମଡ୍ୟୁଲ\", \"pa\":\"ਸਿਖਲਾਈ ਮੋਡੀਊਲ\", \"ta\":\"கற்றல் மாடுயூல்\", \"te\":\"మాడ్యూల్ నేర్చుకోవడం\", \"ur\":\"سیکھنے کا ماڈیول\"}"},{"index":2,"activityType":"Course","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Course\"],\"batches.status\":1,\"batches.enrollmentType\":\"open\",\"objectType\":[\"Content\"],\"status\":[\"Live\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Course","translations":"{\"en\": \"Course\", \"as\": \"পাঠ্যক্ৰমসমুহ\", \"bn\": \"পাঠ্যধারাগুলি\", \"gu\":\"કોર્સ\", \"hi\":\"कोर्स\", \"kn\":\"ಕೋರ್ಸ್ ಗಳು\", \"mr\":\"कोर्सेस\", \"or\":\"ପାଠ୍ୟକ୍ରମଗୁଡ଼ିକ\", \"pa\":\"ਕੋਰਸਿਸ\", \"ta\":\"பாடநெறிகள்\", \"te\":\"కోర్సులు\", \"ur\":\"کورسز\"}"},{"index":3,"activityType":"Practice Question Set","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Practice Question Set\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Practice Question Set","translations":"{\"en\": \"Practice question set\", \"as\": \"অনুশীলনৰ প্ৰশ্নৰ সমষ্টি\", \"bn\": \"অনুশীলনের প্রশ্ন সেট\", \"gu\":\"પ્રેક્ટિસ પ્રશ્ન સેટ\", \"hi\":\"अभ्यास प्रश्न संग्रह\", \"kn\":\"ಅಭ್ಯಾಸ ಪ್ರಶ್ನಾವಳಿ\", \"mr\":\"सराव प्रश्नसंच\", \"or\":\"ଅଭ୍ୟାସ ପ୍ରଶ୍ନପତ୍ର ସେଟ୍\", \"pa\":\"ਅਭਿਆਸ ਪ੍ਰਸ਼ਨ ਸੈੱਟ\", \"ta\":\"பயிற்சி கேள்வி தொகுப்பு\", \"te\":\"ప్రాక్టీస్ ప్రశ్న సెట్\", \"ur\":\"مشق سوال سیٹ\"}"},{"index":4,"activityType":"eTextBook","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"eTextBook\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"eTextBook","translations":"{\"en\": \"PDF TextBook\", \"as\": \"PDF পাঠ্যপুথি\", \"bn\": \"পাঠ্যপুস্তকের পিডিএফ\", \"gu\":\"PDF ટેક્સ્ટબુક\", \"hi\":\"PDF पाठ्यपुस्तकें\", \"kn\":\"ಪಿಡಿಎಫ್ ಪಠ್ಯಪುಸ್ತಕ\", \"mr\":\"PDF पाठ्यपुस्तक\", \"or\":\"PDF ପାଠ୍ୟପୁସ୍ତକ\", \"pa\":\"PDF ਪਾਠ ਪੁਸਤਕ\", \"ta\":\"பி.டீ.எப் பாடபுத்தங்கள்\", \"te\":\"PDF పాఠ్య పుస్తకం\", \"ur\":\"پی ڈی ایف درسی کتاب\"}"},{"index":5,"activityType":"Teacher Resource","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Teacher Resource\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Teacher Resource","translations":"{\"en\": \"Teaching Resource\", \"as\": \"শিক্ষাদানৰ সমলসমূহ\", \"bn\": \"শিক্ষার সংস্থান\", \"gu\":\"શિક્ષણ સંસાધનો\", \"hi\":\"शिक्षण संसाधन\", \"kn\":\"ಬೋಧನಾ ಸಂಪನ್ಮೂಲಗಳು\", \"mr\":\"शिक्षण संसाधने\", \"or\":\"ଶିକ୍ଷଣ ସଂସାଧନ\", \"pa\":\"ਅਧਿਆਪਨ ਦੇ ਸਰੋਤ\", \"ta\":\"கற்பித்தல் பொருள்\", \"te\":\"బోధనా వనరులు\", \"ur\":\" تدریسی وسائل \"}"},{"index":6,"activityType":"Digital Textbook","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Digital Textbook\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Digital Textbook","translations":"{\"en\": \"Digital textbooks\", \"as\": \"ডিজিটেল পাঠ্যপুথিসমূহ\", \"bn\": \"ডিজিটাল পাঠ্যবই\", \"gu\":\"ડિજિટલ પાઠયપુસ્તકો\", \"hi\":\"डिजिटल पाठ्यपुस्तकें\", \"kn\":\"ಡಿಜಿಟಲ್ ಪಠ್ಯಪುಸ್ತಕಗಳು\", \"mr\":\"डिजिटल पाठ्यपुस्तके\", \"or\":\"ଡିଜିଟାଲ୍ ପାଠ୍ୟପୁସ୍ତକ\", \"pa\":\"ਡਿਜੀਟਲ ਪਾਠ ਪੁਸਤਕਾਂ\", \"ta\":\"டிஜிட்டல் பாடப்புத்தகங்கள்\", \"te\":\"పాఠ్యపుస్తకాలు\", \"ur\":\" ڈیجیٹل درسی کتابیں \"}"},{"index":7,"activityType":"Content Playlist","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Content Playlist\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Content Playlist","translations":"{\"en\": \"Content Playlist\", \"as\": \"বিষয়বস্তুৰ প্লে'লিষ্ট\", \"bn\": \"কন্টেন্ট প্লেলিস্ট\", \"gu\":\"કન્ટેન્ટ જોવાનું લિસ્ટ\", \"hi\":\"कंटेन्ट प्लेलिस्ट\", \"kn\":\" ಪಠ್ಯಾಂಶ ಪ್ಲೇಲಿಸ್ಟ್\", \"mr\":\"सामग्री प्लेलिस्ट \", \"or\":\" କଣ୍ଟେଣ୍ଟ ପ୍ଲେଲିଷ୍ଟ\", \"pa\":\"ਕੰਟੇੇਂਟ ਪਲੇਲਿਸਟ\", \"ta\":\"உள்ளடக்க பிளேலிஸ்ட்\", \"te\":\"కంటెంట్ ప్లేజాబితా\", \"ur\":\" مواد پلے لسٹ \"}"},{"index":8,"activityType":"TV Lesson","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Explanation Content\"],\"additionalCategories\":[\"TV Lesson\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"TV Lesson","translations":"{\"en\": \"TV Class\", \"as\": \"টিভি শ্ৰেণীসমূহ\", \"bn\": \"টিভিতে সম্প্রচারিত শিক্ষাদানের অনুষ্ঠানগুলি\", \"gu\":\"TV વર્ગો\", \"hi\":\"टीवी कक्षाएँ\", \"kn\":\"ಟಿವಿ ತರಗತಿಗಳು\", \"mr\":\"टीव्ही वर्ग \", \"or\":\"TV କ୍ଲାସଗୁଡ଼ିକ\", \"pa\":\"ਟੀਵੀ ਕਲਾਸਾਂ\", \"ta\":\"தொலைக்காட்சி வகுப்புகள்\", \"te\":\"టీవీ క్లాసులు\", \"ur\":\" ٹی وی کلاسز\"}"},{"index":9,"activityType":"Previous Board Exam Papers","objectType":"Content","isEnabled":true,"sortBy":[{"name":"asc"}],"searchQuery":"{\"request\":{\"filters\":{\"primaryCategory\":[\"Learning Resource\"],\"additionalCategories\":[\"Previous Board Exam Papers\"],\"status\":[\"Live\"],\"objectType\":[\"Content\"]},\"fields\":[\"name\",\"appIcon\",\"contentType\",\"identifier\",\"objectType\",\"createdBy\"]}}","title":"Previous Board Exam Papers","translations":"{\"en\": \"Earlier Year's Board Exam Papers\", \"as\": \"আগৰ বছৰৰ ব'ৰ্ডৰ পৰীক্ষাৰ প্ৰশ্নসমূহ\", \"bn\": \"আগের বছরের বোর্ড পরীক্ষার প্রশ্নপত্র\", \"gu\":\"ગત બોર્ડ પરીક્ષાના પેપર્સ\", \"hi\":\"पिछले वर्षों की बोर्ड परीक्षा पेपर\", \"kn\":\"ಹಿಂದಿನ ವರ್ಷಗಳ ಮಂಡಳಿ ಪರೀಕ್ಷೆ ಪ್ರಶ್ನೆಪತ್ರಿಕೆಗಳು\", \"mr\":\"मागील वर्षाचे बोर्ड परीक्षेचे पेपर \", \"or\":\"ପୂର୍ବ ବର୍ଷର ବୋର୍ଡ ପରୀକ୍ଷା ପ୍ରଶ୍ନପତ୍ର\", \"pa\":\"ਸ਼ੁਰੂਆਤੀ ਸਾਲ ਬੋਰਡ ਪ੍ਰੀਖਿਆ ਪੇਪਰ\", \"ta\":\"முந்தைய ஆண்டுகளில் போர்டு தேர்வுத் தாள்கள்\", \"te\":\"అంతకుముందు సంవత్సరం బోర్డు పరీక్షా పత్రాలు\", \"ur\":\"ابتدائی سالوں کے بورڈ کے امتحانی پرچے\"}"}]}}}


```




