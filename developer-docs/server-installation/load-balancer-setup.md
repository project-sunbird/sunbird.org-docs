---
title: Load Balancer Setup
page_title: Load Balancer Setup
description: Information about how to set up the Load Balancers
keywords: Load Balancers, load, Agent Swarm, Keycloak swarm, Swarm, services, KP-LB Services, DP-LB Services, setup
allowSearch: true
---

## Overview

- Load Balancers are required when you want to scale your applications and have high availability 
- The LB can distribute traffic to your VMs evenly
- The LB can be of type Layer 4 or Layer 7
- We recommend the Layer 4 LB also know as the basic LB

### Keycloak

Below are the details to setup a LB for Keycloak on Azure

```bash
Frontend IP configuration
  - Type: Private
  - Assignment: Static
Backend pools
  - Name: keycloak
  - Attach Keycloak VMs or Availability Set
Health Probes
  - Name: keycloak
  - Protocol: HTTP
  - Port: 8080
  - Path: /auth/
  - Interval: 5
  - Unhealthy threshold: 2
Load Balancing rules
  - Frontend IP address: LB IP
  - Frontend Port: 80
  - Protocol: TCP
  - Backend Port: 8080
  - Backend Pool: keycloak
  - Health Probe: keycloak (HTTP:8080/auth/)

```

### Knowledge Platform

**Learning:**

Below are the details to setup a LB for Learning service on Azure

```bash
Frontend IP configuration
  - Type: Private
  - Assignment: Static
Backend pools
  - Name: learning
  - Attach Learning VMs or Availability Set
Health Probes
  - Name: learning
  - Protocol: HTTP
  - Port: 8080
  - Path: learning-service/health
  - Interval: 5
  - Unhealthy threshold: 2
Load Balancing rules
  - Frontend IP address: LB IP
  - Frontend Port: 8080
  - Protocol: TCP
  - Backend Port: 8080
  - Backend Pool: keycloak
  - Health Probe: learning (HTTP:8080/learning-service/health)
```
