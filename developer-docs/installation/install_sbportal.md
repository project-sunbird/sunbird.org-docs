---
title: Installing Sunbird Portal
page_title: Installing Sunbird Portal
description: Installing Sunbird requires two primary software components, the Sunbird portal or web application, and the Sunbird services stack or the backend API interface.
published: true
allowSearch: true
---

## Sunbird Portal Setup

To set up the Sunbird portal successfully, follow these steps sequentially:

1. Pre-requisites 
2. Setup 
3. Configure Sunbird Backend
4. Edit the Application Config
5. Run the Application

### Pre-requisites

Check the following pre-requisites before installing and running the Sunbird-player application:

1. **Software dependencies**
	* [Node](https://nodejs.org/en/download/){:target="_blank"} - install the latest release of 8.x.x LTS series

2. **API Keys** 

This installation guide will use a cloud hosted Sunbird APIs for which an API key is needed.

- For getting an API key, send an email to: info@sunbird.org

### Setup 
For setting up the application, check out the [code](https://github.com/project-sunbird/sunbird-portal.git){:target="_blank"}. The code can be checked out via the command:
    
    git clone https://github.com/project-sunbird/sunbird-portal.git

> ***Note***: Stable versions of the sunbird portal are available via tags for each release, and the master branch contains latest stable release. For latest stable release [refer](https://github.com/project-sunbird/sunbird-portal/){:target="_blank"}

Once the git clone command is over, run the following set of commands:
   
    $ cd {PROJECT-FOLDER}/src/app
    $ npm install

Set the following environment variables:

<pre>
sunbird_environment=local 
sunbird_instance=sunbird
sunbird_default_channel=sunbird
</pre>

### Configure Backend Service Stack

The Sunbird portal application is powered by a set of Service APIs. These Service API(s) run in a distributed environment. For instance, deploying the Sunbird to production; but for the sake of simplicity and ease of debugging, you can also run these service API(s) locally on a single server.

For now, let us configure the Sunbird portal to use a cloud instance of the Sunbird Service API(s). These APIs are hosted by project Sunbird and are used for testing and demonstration purposes. 

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

Run the following commands in your console (CLI):

<pre>
$ cd {PROJECT-FOLDER}/src/app
$ node server.js
</pre>

After executing the commands, open `http://localhost:3000` in browser.

## Use the Application  

After successfully installing Sunbird, use demo user IDs to explore and test different workflows.

* For each user role, you require a separate demo user ID and its respective password

* Any user can be assigned one or more user role. The role rules that apply depend on the demo user ID and password that is used to sign in 
 
The following is the list of the demo user IDs per user role:

User Role |	User ID
----------|----------
Org Admin | adopterorgadmin@adopter
Content Creator | adoptercreator@adopter 
Content Reviewer | adopterreviewer@adopter
Book Creator | adopterbookcreator@adopter 
Book Reviewer | adopterbookreviewer@adopter
Flag Reviewer | adopterflagreviewer@adopter
Course Mentor | adoptercoursementor@adopter

**Note:** 

* To get the password for each demo user ID, send an email to info@sunbird.org

* For information on user roles, refer to [Types of Users](features-documentation/userrole){:target="_blank"}
