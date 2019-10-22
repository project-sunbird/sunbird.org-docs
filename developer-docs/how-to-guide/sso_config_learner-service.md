---
title: SSO Configuration for learner-service 
page_title: SSO Configuration
description: SSO Configuration
keywords: SSO, learner-service , user auth, keycloak
published: true
allowSearch: true
---

## Scenario
As an adopter, I want to use Sunbird. Sunbird uses SSO as auth system. To integrate SSO with the learner service, we have to set following environment variables in the learner-service.

### Environment Variable List

|  Environment Variable | Description    | Sample |
|-----------------------|----------------|-----------|
| sunbird_sso_url       | The URL of Keycloak| http://localhost:8080/auth/ |
| sunbird_sso_realm     | The Keycloak realm name | master |
| sunbird_sso_username  | The Keycloak realm admin user | admin
| sunbird_sso_password  | The Keycloak realm admin password | admin
| sunbird_sso_client_id | The Keycloak client for the selected realm | admin-cli
|sunbird_keycloak_user_federation_provider_id | The identifier for the provider of the federated database. This is required if we use a federated DB in Keycloak | 872382fa-9161-48f0-99ad-7148abb34
|sunbird_subdomain_keycloak_base_url | The URL of the Keycloak subdomain. This is required if we want to merge two user account from custodian to state account 

 
  
## Concept Covered

- Keycloak configuration with learner-service
