---
type: landing
directory: developer-docs/installation
title: Developer Installation
page_title: Developer Installation
description: Installing the Sunbird portal or web application
published: true
allowSearch: true
---

## Overview

This page provides information for you to install and run a Sunbird instance on your laptop or desktop. The intent is to give you a look and feel of some of the features of Sunbird, be able to tweak around with the front-end code. This developer installation of Sunbird application and the cloud APIs used therein, are not for intended for production purposes.

>The Sunbird developer installation can be best viewed via the Google Chrome browser. Although, other browsers may be used, but some pages might not render correctly.
>Sunbird developer installation is intended for the web. It cannot be used on mobile devices and Single Sign On (SSO).  

## Intended Audience

The intended audience of this document is a person who is familiar with installing, configuring, and deploying nodejs based open-source software.

## Prerequisites

1. **Software**: Install the following software: 
   * [node](https://nodejs.org/en/download/) - install the latest release version 8.11.2 LTS series
   * [nodemon](https://www.npmjs.com/package/nodemon) - Latest version  
   * [git](https://git-scm.com/downloads) - Latest version  
   * [gulp](https://gulpjs.com/) - Install gulp via npm, which gets installed when nodejs is installed

1. **API Keys**
   * The Sunbird developer instance is powered by cloud hosted Sunbird APIs, which require an API key. To get an API key, please submit an [API Key Request](https://goo.gl/forms/2tRDfLlbJ2IgjWgA2). In the form, give some information about your team and what brings you to Sunbird. It may occasionally take up to a couple of business days (India time) to send you the API key. We regret the inconvenience caused due to such delays. 

## System Requirements

To install Sunbird, ensure that your laptop or desktop has the following minimum system requirements:

- Operating System: Ubuntu Linux 16.04 or later, Mac OS X 10.0 and above, or Windows 7 and above
- RAM: > 1.5GB
- CPU: 2 cores (> 2 GHz/core)

## Components Installed

Sunbird installation has two primary software components:
- Portal or web application
- Services stack or the backend API interface

This version installs the portal web application and uses the cloud-hosted services stack

## Set up the Application

These instructions install Sunbird version 1.9. Code examples, provided are Linux based. However, they should not differ when executed on Windows<sup>(R)</sup>. If you face any problems using the Windows<sup>(R)</sup> commandline shell or PowerShell then try using Cygwin<sup>(R)</sup> to install Sunbird on your desktop or laptop.

1. Launch a commandline terminal.

1. Ensure that the system PATH variable points to paths where `git`, `node`, `nodemon` and `gulp` are located. 
>If you are unable to find an executable by the name of **node**, then try **nodejs**

1. Change directory into the folder which you have designated as the top level folder of the Sunbird application.

1. Clone the Sunbird portal github repository

        git clone https://github.com/project-sunbird/sunbird-portal.git

1. Checkout the files tagged with version 1.9

        cd sunbird-portal
        git checkout tags/v1.9 -b 1.9

1. Build the nodejs packages that are required by the Sunbird application

        cd src/app
        gulp download:editors
        npm install
        cd client
        npm install
        
1. Configure the following system environment variables

        +---------------------------+---------+-----------+
        | Environment Variable Name |  Value  | Data Type |
        |---------------------------|---------|-----------|
        |  sunbird_environment      | local   |   string  |
        |  sunbird_instance         | sunbird |   string  |
        |  sunbird_default_channel  | sunbird |   string  |
        |  sunbird_default_tenant   | sunbird |   string  |
        +---------------------------+---------+-----------+


## Configuring the Services Stack

Edit the file `sunbird-portal/src/helpers/environmentVariablesHelper.js` and ensure that the following tokens are set to the values as indicated. Enclose all string values within double quotation marks.

|            Token            |                   Value                              | Data Type |
|-----------------------------|------------------------------------------------------|-----------|
| DEFAULT_CHANNEL             | sunbird                                              | string    |
| LEARNER_URL                 | https://staging.open-sunbird.org/api/                |  string   |
| CONTENT_URL                 | https://staging.open-sunbird.org/api/                |  string   |
| CONTENT_PROXY_URL           | https://staging.open-sunbird.org                     |  string   |
| PORTAL_REALM                | sunbird                                              |  string   |
| PORTAL_AUTH_SERVER_URL      | https://staging.open-sunbird.org/auth                |  string   |
| PORTAL_AUTH_SERVER_CLIENT   | portal                                               |  string   |
| PORTAL_PORT                 | 3000                                                 |  number   |
| PORTAL_API_AUTH_TOKEN       | (The API key you received from your API key request) |  string   |
| PORTAL_ECHO_API_URL         | (empty string)                                       |  string   |
| ANDROID_APP_URL             | http://www.sunbird.org                               |  string   |
| CONTENT_CHANNEL_FILTER_TYPE | all                                                  |  string   |
| LEARNER_URL                 | https://staging.open-sunbird.org/api/                |  string   |
| TELEMETRY_SERVICE_LOCAL_URL | https://staging.open-sunbird.org/api/data/           |  string   |


## Run the Application

1. Update the Sunbird application with the modified config file values. Run the following command in the `sunbird-portal/src/app/client` folder

        nodemon

Wait for the following message before proceeding to the next step 

        [nodemon] clean exit - waiting for changes before restart

1. Open another commmandline window and run the application server

    Populate these system environment variables (again)

        +---------------------------+---------+-----------+
        | Environment Variable Name |  Value  | Data Type |
        |---------------------------|---------|-----------|
        |  sunbird_environment      | local   |   string  |
        |  sunbird_instance         | sunbird |   string  |
        |  sunbird_default_channel  | sunbird |   string  |
        |  sunbird_default_tenant   | sunbird |   string  |
        +---------------------------+---------+-----------+

            cd sunbird-portal/src/app
            node server.js

>The initialization of these environmental variables can take place in a common place - like in the .bashrc file on Linux.

1. Launch the Google Chrome browser and navigate to

        http://localhost:3000

## Login into the Sunbird portal

After successfully installing Sunbird, use any of the following user IDs, the password to which you should have recieved along with the API key, to explore Sunbird's workflows. Each user ID corresponds to a specific role.

| User ID | Role |  
|---|---|
| adopterorgadmin@adopter | Org administrator | 
| adoptercreator@adopter | Content creator  |  
| adopterreviewer@adopter | Content reviewer |  
| adopterbookcreator@adopter | Boook creator |  
| adopterbookreviewer@adopter | Book reviewer |  
| adopterflagreviewer@adopter | Flag reviewer |  
| adoptercoursementor@adopter | Course mentor |  

* For information on user roles, refer to [Types of Users](features-documentation/userrole)
