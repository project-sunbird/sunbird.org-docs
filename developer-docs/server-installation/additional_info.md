---
title: Additional variables for Core service only
page_title: Additional variables for Core service only
description: Additional variables for Core service only
keywords: infrastructure, design, infrastructure components
allowSearch: true
---

< # qa or dev or prod env of ekstep which you want ot connect<br/>sunbird_content_repo_api_base_url: &quot;<a href="https://qa.ekstep.in/api" class="external-link" rel="nofollow">https://qa.ekstep.in/api</a>&quot;                                    
# qa or dev or prod env url of ekstep which you want ot connect<br/>
sunbird_analytics_api_base_url: <a href="https://qa.ekstep.in/api" class="external-link" rel="nofollow">https://qa.ekstep.in/api</a>                                              
# qa or dev or prod env url of ekstep which you want ot connect<br/>
sunbird_search_service_api_base_url: <a href="https://qa.ekstep.in/api/search" class="external-link" rel="nofollow">https://qa.ekstep.in/api/search</a>                        
# qa or dev or prod env url of ekstep which you want ot connect<br/>
sunbird_cloud_storage_urls: '<a rel="nofollow">https://s3.ap-south-1.amazonaws.com/ekstep-public-{{ekstep_s3_env}}/,https://ekstep-public-{{ekstep_s3_env}}.s3-ap-south-1.amazonaws.com/</a>'                                
# This value can be same as this line<br/>
sunbird_ekstep_proxy_base_url: <a href="https://qa.ekstep.in/" class="external-link" rel="nofollow">https://qa.ekstep.in/</a>                                                 
# qa or dev or prod env url of ekstep which you want ot connect<br/>
upstream_url: &quot;ekstep-public-{{ekstep_s3_env}}.<a href="http://s3-ap-south-1.amazonaws.com" class="external-link" rel="nofollow">s3-ap-south-1.amazonaws.com</a>&quot;     

# This value can be same as this line<br/>
learningservice_ip:                                                                                                        # Dummy IP or provide IP of swarm manager<br/>

keycloak_auth_server_url: &quot;{{proto}}://{{ proxy_server_name }}:8080/auth&quot;                
    # This value can be same as this line. If using a LB for keycloak, remove port :8080</p><p><strong>In secrets.yml</strong></p><p>core_vault_sunbird_ekstep_api_key:                                                                            
    # ekstep key</p><p><strong>(After onboarding consumer take the value of api-management-test-user update the below variables)</strong></p><p>core_vault_sunbird_api_auth_token:                                                                            
    # sunbird key after onboarding consumers</p><p>core_vault_kong__test_jwt:                                                                                           

    # sunbird key after onboarding consumers</p><p><br/></p><p><br/></p>
        