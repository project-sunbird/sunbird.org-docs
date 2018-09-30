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

This page provides information for you to install & run a Sunbird instance on your laptop or desktop. The intent is to give you a look and feel of some of the features of Sunbird, be able to tweak around with the front-end code. This developer installation of Sunbird application and the cloud APIs used therein, are not for intended for production purposes.

>The Sunbird developer installation can be best viewed via the Google Chrome browser. Although, other browsers may be used, but some pages might not render correctly.

Before installing Sunbird on your laptop or desktop, ensure that the you have the necessary resources and compliant target systems.

## Intended Audience

The intended audience of this document is a person who is familiar with installing, configuring & deploying open-source software and has some systems administration experience.

## Prerequisites

1. **Software dependencies**
   * [node](https://nodejs.org/en/download/) - install the latest release of 8.11.2 LTS series
   * [nodemon](https://www.npmjs.com/package/nodemon)
   * [git](https://git-scm.com/downloads)
   * gulp - This needs to be installed via npm which gets installed when nodejs is installed.


1. **API Keys**
   * The Sunbird developer instance is powered by cloud hosted Sunbird APIs, which require an API key. To get this key, send an email to info@sunbird.org . In the subject mention "Request for SUNBIRD STAGING API Key". In the body of the email, mention a few words about yourself and for what purpose are you interested in Sunbird - like whether it's for evaluation or you just want to tinker around with it etc. The typical response time will be 2-3 business days (India Time).


## System Requirements

To install Sunbird, ensure that your laptop or desktop has the following minimum system requirements:

- Operating System: Windows 7 and above, or 4.2 Mac OS X 10.0 and above or Linux
- RAM: > 1.5GB
- CPU: 2 cores (> 2 GHz/core)

## Sunbird Components
Installing Sunbird requires two primary software components:
- Sunbird portal or web application
- Sunbird services stack or the back-end API interface

## Set Up the Sunbird Application

These instructions will install the v1.9 version of the Sunbird application. Code examples, shown here are Linux based and should not differ when executed on WINDOWS(r). If there is any impediment using WINDOWS(r) commandline shell or PowerShell, then you might want to try using Cygwin(r) to perform the Sunbird developer install.

1. Launch a commandline terminal.

1. Ensure that the system PATH variable points to the folders where git, node, nodemon and gulp are located. If for some reason you are unable to find an executable by the name of node, then try nodejs instead.

1. Change directory into the folder which you've designated as the top level folder of the Sunbird application.

1. Clone the Sunbird portal github repository

        git clone https://github.com/project-sunbird/sunbird-portal.git

1. Checkout the files tagged with v1.9

        cd sunbird-portal
        git checkout tags/v1.9 -b 1.9


1. Build the nodejs packages that are required by the Sunbird application.

        cd sunbird-portal/src/app
        npm install
        cd sunbird-portal/src/app/client
        npm install
        cd ..


1. Populate these environment variables

        +---------------------------+---------+-----------+
        | Environment Variable Name |  Value  | Data Type |
        |---------------------------|---------|-----------|
        |  sunbird_environment      | local   |   string  |
        |  sunbird_instance         | sunbird |   string  |
        |  sunbird_default_channel  | sunbird |   string  |
        |  sunbird_default_tenant   | sunbird |   string  |
        +---------------------------+---------+-----------+


## Configure the Service Stack

Edit the file sunbird-portal/src/helpers/environmentVariablesHelper.js and ensure that the following tokens are set to the values as indicated. Enclose all string values within double quotation marks.

|            Token            |                   Value                          | Data Type |
|-----------------------------|--------------------------------------------------|-----------|
| DEFAULT_CHANNEL             | sunbird                                          | string    |
| LEARNER_URL                 | https://staging.open-sunbird.org/api/            |  string   |
| CONTENT_URL                 | https://staging.open-sunbird.org/api/            |  string   |
| CONTENT_PROXY_URL           | https://staging.open-sunbird.org                 |  string   |
| PORTAL_REALM                | sunbird                                          |  string   |
| PORTAL_AUTH_SERVER_URL      | https://staging.open-sunbird.org/auth            |  string   |
| PORTAL_AUTH_SERVER_CLIENT   | portal                                           |  string   |
| PORTAL_PORT                 | 3000                                             |  number   |
| PORTAL_API_AUTH_TOKEN       | (The API key you received from info@sunbird.org) |  string   |
| PORTAL_ECHO_API_URL         | (empty string)                                   |  string   |
| ANDROID_APP_URL             | http://www.sunbird.org                           |  string   |
| CONTENT_CHANNEL_FILTER_TYPE | all &#124; self                                  |  string   |
| LEARNER_URL                 | https://staging.open-sunbird.org/api/            |  string   |
| TELEMETRY_SERVICE_LOCAL_URL | https://staging.open-sunbird.org/api/data/       |  string   |


## Run the Application

1. Download the content editors
        gulp download:editors

1. Update the Sunbird application with the modified config file values.

        cd sunbird-portal/src/app/client
        nodemon

Wait till you see something like this, before going to the next step.

        [nodemon] clean exit - waiting for changes before restart

1. Open another commmandline window and run the application server.

    Populate these environment variables (again)

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


    The initialization of these environmental variables can take place in a common place - like in the .bashrc file on Linux.

1. Launch the Google Chrome browser and navigate to

        http://localhost:3000

## Login into the Sunbird portal

After successfully installing Sunbird, use any of the following user IDs to explore Sunbird's workflows. Each user ID corresponds to a specific role.

| User ID | Role | Password |
|---|---|---|
| adopterorgadmin@adopter | Org administrator | password |
| adoptercreator@adopter | Content creator  | password |
| adopterreviewer@adopter | Content reviewer | password |
| adopterbookcreator@adopter | Boook creator | password |
| adopterbookreviewer@adopter | Book reviewer | password |
| adopterflagreviewer@adopter | Flag reviewer | password |
| adoptercoursementor@adopter | Course mentor | password |

* For information on user roles, refer to [Types of Users](pages/features-documentation/userrole)
