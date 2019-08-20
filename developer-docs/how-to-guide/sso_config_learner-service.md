---
title: SSO Configuration for learner-service 
page_title: SSO Configuration
description: SSO Configuration
keywords: SSO, learner-service , user auth, keycloak
published: true
allowSearch: true
---

## Scenario
  As an adopter, i want to use sunbird.Sunbird is using SSO as auth system , so to integrate SSO with learner service we have to set following env variable inside learner-service.

**Env list**

|  env                  | Description    | Sample |
|-----------------------|----------------|-----------|
| sunbird_sso_url       | url of keycloak| http://localhost:8080/auth/ |
| sunbird_sso_realm     | keycloak realm name | master |
| sunbird_sso_username  | keycloak realm admin user | admin
| sunbird_sso_password  | keycloak realm admin password | admin
| sunbird_sso_client_id | keycloak client under selected realm | admin-cli
|sunbird_keycloak_user_federation_provider_id | required if we are using federated db inside keycloak | 872382fa-9161-48f0-99ad-7148abb34
|sunbird_subdomain_keycloak_base_url | required if we want to merge two user account from custodian to state account 

 
  
## Concept Covered

- Keycloak configuration with learner-service
