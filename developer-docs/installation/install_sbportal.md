---
title: Installing Sunbird Portal
page_title: Installing Sunbird Portal
description: Installing Sunbird requires two primary software components, the Sunbird portal or web application, and the Sunbird services stack or the backend API interface.
published: true
allowSearch: true
---

## Pre-requisites

Before you install Sunbird on your laptop, examine your environment and gather data to ensure an optimal installation experience.
Review the following to determine that the environment has the necessary resources and compliant target systems to successfully install and run Sunbird.

### System Requirements

To install Sunbird, your laptop/PC should have at least the following minimum system requirements:

- Operating System: Windows 7 and above/4.2 Mac OS X 10.0 and above/Linux  
- RAM: >1.5GB
- CPU: 2 cores, >2 GHz

Installing Sunbird requires two primary software components:

- Sunbird portal or web application
- Sunbird services stack or the backend API interface. 

## Sunbird Portal Setup

To set up the Sunbird portal successfully, follow these steps sequentially:

1. Check for the prerequisites 
2. Setup 
3. Configure Backend Service Stack
4. Edit the Application Config
5. Run the Application

### Pre-requisites
Check the following pre-requisites before installing and running the Sunbird-player application:

1. **Software dependencies**
	* [Node](https://nodejs.org/en/download/){:target="_blank"} - install the latest release of 6.x.x LTS series
	* [Gulp](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md){:target="_blank"}- 
	  latest version of gulp: `npm install -g gulp-cli`
	* [nodemon](https://www.npmjs.com/package/nodemon){:target="_blank"} - Latest version  of nodemon: `npm install -g nodemon`

2. **API Keys** 

This installation guide will use a cloud hosted Sunbird APIs for which an API key is needed.

- For getting an API key,send an email to: info@sunbird.org

### Setup 
For setting up the application, check out the [code](https://github.com/Sunbird-Ed/SunbirdEd-portal){:target="_blank"}. The code can be checked out via the command:
    
    git clone https://github.com/Sunbird-Ed/SunbirdEd-portal

> ***Note***: Stable versions of the sunbird portal are available via tags for each release, and the master branch contains latest stable release. For latest stable release [refer](https://github.com/Sunbird-Ed/SunbirdEd-portal){:target="_blank"}

Once the git clone command is over, run the following set of commands:

   
    $ cd {PROJECT-FOLDER}/src/app
    $ npm install
    $ gulp download:editors
    $ cd {PROJECT-FOLDER}/src/app/client
    $ npm install

## Configuring the Environment and Services Stack

1. Configure the following system environment variables in the terminal which you have opened

| Environment Variable      |  Value  | Data Type |
|---------------------------|---------|-----------|
|  sunbird_environment      | local   |   string  |
|  sunbird_instance         | sunbird |   string  |
|  sunbird_default_channel  | sunbird |   string  |
|  sunbird_default_tenant   | sunbird |   string  |

> The initialization of these environmental variables can take place in a common place like in your **.bashrc** or **.bash_profile**


### Configure Backend Service Stack

The Sunbird portal application is powered by a set of Service APIs. These Service API(s) run in a distributed environment.For instance, deploying the Sunbird to production; but for the sake of simplicity and ease of debugging, you can also run these service API(s) locally on a single server.

For now, let us configure the Sunbird portal to use a cloud instance of the Sunbird Service API(s).These APIs are hosted by project Sunbird and are used for testing and demonstration purposes. 

> ***Note***: The cloud instance of the API(s) hosted by Project Sunbird are not for production usage.

### Edit the Application Config

Open `<PROJECT-FOLDER>/src/app/helpers/environmentVariablesHelper.js` in any available text editor. 

Once the file opens, update the contents of the file so that it contains exactly the following values:

    module.exports = {
        // 1. LEARNER_URL   
        LEARNER_URL: env.sunbird_learner_player_url || 'https://staging.open-sunbird.org/api/',                    
        // 2. CONTENT_URL
        CONTENT_URL: env.sunbird_content_player_url || 'https://staging.open-sunbird.org/api/',                   
        // 3. CONTENT_PROXY  
        CONTENT_PROXY_URL: env.sunbird_content_proxy_url || 'https://staging.open-sunbird.org',                    
        PORTAL_REALM: env.sunbird_portal_realm || 'sunbird',
        // 4. PORTAL_AUTH_SERVER_URL
        PORTAL_AUTH_SERVER_URL: env.sunbird_portal_auth_server_url || 'https://staging.open-sunbird.org/auth',     
        PORTAL_AUTH_SERVER_CLIENT: env.sunbird_portal_auth_server_client || "portal",
        ...
        PORTAL_PORT: env.sunbird_port || 3000,
         	
        // 5. PORTAL_API_AUTH_TOKEN     
        PORTAL_API_AUTH_TOKEN: env.sunbird_api_auth_token || 'E-mail to: info@sunbird.org' for getting Auth-Token 
        ...
        
        // 6. PORTAL_ECHO_API_URL
        PORTAL_ECHO_API_URL: env.sunbird_echo_api_url || '',                                                       
        ...
    }

Once the file is updated with appropriate values, then you can proceed with running the application.           
 
## Run the Application

1. Update the Sunbird application with the modified configuration file values. Run the following command in the **{PROJECT-FOLDER}/src/app/client** folder:

    ```
    nodemon
    ```
    
2. Wait for the following message before proceeding to the next step 

    ```
    [nodemon] clean exit - waiting for changes before restart
    ```

3. Run the following commands in your console (CLI):
    $ cd {PROJECT-FOLDER}/src/app
    $ node server.js

4. After executing the commands, open `http://localhost:3000` in browser.
