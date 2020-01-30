---
title: Load Balancer Setup
page_title: Load Balancer Setup
description: Information about how to set up the Load Balancers
keywords: Load Balancers, load, Agent Swarm, Keycloak swarm, Swarm, services, KP-LB Services, DP-LB Services, setup
allowSearch: true
---

## Overview

Load Balancers are required to scale your applications and create a high availability for your services. Balancing the load provides
low latency and high throughput, and scales up to millions of flows for all TCP and UDP applications.

The Load Balancer distributes new inbound flows that arrive on its frontend to backend pool instances, as per rules and health probes that are set. This page provides details to set up the Agent Swarm, Keycloak Swarm, KP-LB services and the DP-LB services.

**Note:** The load balancers can be layer 4 or layer 7.

## Swarm Nodes

To setup Agent Swarm, execute the following instructions for each of the mentioned fields: 

- Frontend IP configuration - attach public IP
- Backend pools - attach agent VM's or availability set of agent group
- Health Probes/check - Configure path and port - 80 and 443 (both)  
EX: name: http 
- Protocol: TCP   
- Port: 80  
- Interval: 5  
- Unhealthy threshold: 2  
- Load Balancing rules - Frontend-ip-config, Frontend-port,backend-port, Backend-pool and health-probe    
Ex: Frontend-port: 80
- Backend-port: 80


> **Note:** Follow similar steps for port 443

## Swarm Managers
(Optional - Refer the variable sunbird_swarm_manager_lb_ip in inventory for comments)


To setup LB for Swarm managers, execute the following instructions for each of the mentioned fields: 
- Frontend IP configuration - Internal IP (default)
- Backend pools - attach swarm manager VM or availability set of swarm manager group
- Health Probes/check - Configure path and port   
       ->   api-manager-kong    - 8001 - /status    
       ->   content-service     - 5000 - /health  
       ->   learner-service     - 9000 - /health  
       ->   content-service-kp  - 9002 - /health  
       ->   cert-service        - 9011 - /health   
       
- Protocol: HTTP
- Port:    
       ->   api-manager-kong   - 8000   
       ->   content-service    - 5000   
       ->   learner-service    - 9000    
       ->   content-service-kp - 9002  
       ->   cert-service       - 9011
       
- Interval: 5 
- Unhealthy threshold: 2  
- Load Balancing rules - Frontend-ip-config, Frontend-port, backend-port, Backend-pool and health-probe   
       ->   api-manager-kong   - Frontend-port:8000 - Backend-port: 8000    
       ->   content-service    - Frontend-port:5000 - Backend-port: 5000    
       ->   learner-service    - Frontend-port:9000 - Backend-port: 9000  
       ->   content-service-kp - Frontend-port:9002 - Backend-port: 9002  
       ->   cert-service       - Frontend-port:9011 - Backend-port: 9011 
       

## Keycloak

To setup Keycloak Swarm, execute the following instructions for each of the mentioned fields:  
- Frontend IP configuration - Internal IP (default)
- Backend pools - attach keycloak vm or availability set of keycloak group
- Health Probes/check - Configure path and port - 8080  
    Example: name: keycloakhealth 
- Protocol: TCP 
- Port: 8080 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config, Frontend-port, backend-port, Backend-pool and health-probe  
    Example: Frontend-port: 80, Backend-port: 8080


## Knowledge Platform 

**Learning:**

To setup KP-LB services, execute the following instructions for each of the mentioned fields: 
- Frontend IP configuration - Internal IP (default)
- Backend pools - attach vm's of learning and search or availability set for learning and search
- Health Probes/check - Configure path and port - 8080 (for learning) and 9000 (for search)  
    Example: name: learninghealth 
- Protocol: http 
- Port: 8080 
- Path: /learning-service/health
- Interval: 5 
- Unhealthy threshold: 2
- Frontend-port: 8080
- Backend-port: 8080


**Search:**

- Name: searchhealth 
- Protocol: http 
- Port: 9000 
- Path: /health 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config, Frontend-port, Backend-port, Backend-pool and health-probe  
    Example: Frontend-port: 9000, Backend-port: 9000


## Data Pipeline

To setup DP-LB services, execute the following instructions for each of the mentioned fields: 

- Frontend IP configuration - Internal IP (default)
- Backend pools - attach VM's of analytics-api or availability set for analytics-api group
- Health Probes/check - Configure path and port - 9000  
    Example: name: analyticshealth 
- Protocol: tcp 
- Port: 9000 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config,Frontend-port, backend-port, Backend-pool and health-probe  
Example: Frontend-port: 9000, Backend-port: 9000  
