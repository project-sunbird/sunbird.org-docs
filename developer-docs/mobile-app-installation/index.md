---
title: Mobile App Setup
page_title: Mobile App Setup
description: Setting Up Mobile App
keywords: Setup, Subird Mobile App, Install, Cofigure, set up,Build APK
published: true
allowSearch: true
---
## Introduction

The Sunbird Mobile app provides mobility to its feature-rich learning platform. It provides learners with the flexibility to learn anywhere, anytime.

## Prerequisites
1. To set up Sunbird mobile app, ensure you have installed the following:
  1. NPM Version - 3.5.2
  2. Node JS Version - above 6  
  3. Cordova Version - 8.0.0
  4. Ionic Version - 3.20.0
  
2. Generate the key and secret for the mobile app user using the JWT token of the mobile admin user. The JWT token for mobile admin user is printed on the application:
 *server folder /where-you-cloned-sunbird-devops-repo/sunbird-devops/deploy/logs/apis.log.*

**Generating Secret:**
Execute the listed API to generate the key and secret for the mobile app:

  curl -X POST \   <your-sunbird-base-url>/api/api-manager/v1/consumer/mobile_app/credential/register \
       -H 'authorization: Bearer <mobile_admin_jwt_token_from_apis_log_file>' \
       -H 'content-type: application/json' \
       -d '{
       "request": {
         "key": "<implementation-name>-mobile-app-<version-number>"
       }
     }'

**Response body:** 

{"result":{"key":"<implementation-name>-mobile-app-<version-number>","secret":"<secret>"}} 

Use the  key and secret from the response given for MOBILE_APP_KEY and MOBILE_APP_SECRET configuration in respective environments in gradle.properties file. Example:

**dev_mobile_app_key = "<implementation-name>-mobile-app-<version-number>"
dev_mobile_app_secret = "<secret>"**

**Producer Key**

Replace the producer id `PRODUCER_ID` for respective environments in the **sunbird.properties** file.

**Fabric credentials:**

Replace `release_fabric_api_key` in `sunbird.properties` with your fabric API Key. Create an account in [fabric.io](https://get.fabric.io/) and register in the app to get the API key.

## Build APK from Git Repository
Build the Sunbird mobile app from the main source code that is available at [project-sunbird](https://github.com/project-sunbird)/[sunbird-mobile](https://github.com/project-sunbird/sunbird-mobile).

The sample properties file is in the **buildConfig** folder. Renamed it to **sunbird.properties** and provide the appropriate values in it.

### Customizing App Configuration

The instance administrator of any Sunbird adopter can customize the Sunbird mobile app based on their organization's requirement. The administartor can configure the following aspects:

* App name
* App logo
* Login/Guest page for new users
* App Sign-in footer card 
* Onboarding cards
* Categories in the profile page 

| S No. | Variable Name | Description | Purpose | Default Value|
|-------|---------------|--------------|--------|--------------|
| 1 | dev_app_id/staging_app_id/production_app_id | The app ID in the **sunbird-mobile/buildConfig/sunbird.properties** file with the implementation-specific application ID | To change the app ID | appId: "org.sunbird.app"|
| 2 | app name | Navigate to the **sunbird-mobile/config.xml** file and enter the required app name. | To change the app name | 
| 3 | app logo | Navigate to **sunbird-mobile/resources/android/icon** and **sunbird-mobile/resources/android/splash**. Replace the **ic_launcher.png** image with your desired logo in all the mipmap and drawable folders. The logo name should be **drawable-ldpi-icon.png** | To change the app logo |
| 4 | app | Set the configuration variable in the **sunbird-mobile repo** file in the **buildConfig** folder | |   |
| 5|  app version code | Version code for the app release | To customize the end points in the app | Replace redirect base url REDIRECT_BASE_URL and all other base urls with your respective domain name in **sunbird.properties** |
| 6 | deep link schema | This plugin handles deeplinks on iOS and Android for both custom URL scheme links and Universal App Links. Deep link schema can be changed from sunbird.properties | Change the "dev_deeplink_base_url = dev.open-sunbird.org" to the required name|
| 7 | display_onboarding_page | Set the configuration variable in the **sunbird-mobile repo** in the **buildConfig** folder | to display the onboarding page | false|
| 8 | display_signin_footer_card_in_course_tab_for_teacher | set the <b>display_signin_footer_card_in_course_tab_for_teacher</b>variable as <b>true</b> in sunbird.properties file | to show the sign-in footer in the course tab for teachers | false|
| 9 | display_signin_footer_card_in_library_tab_for_teacher | Set the <b>display_signin_footer_card_in_library_tab_for_teacher</b> variable <b>true</b> in sunbird.properties file | to show the sign-in footer in the library tab for teachers | false|
| 10 | display_signin_footer_card_in_profile_tab_for_teacher | Set the <b>display_signin_footer_card_in_profile_tab_for_teacher</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for teachers | false|
| 11 | display_signin_footer_card_in_profile_tab_for_student | Set the <b>display_signin_footer_card_in_profile_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false|
| 12 | display_signin_footer_card_in_library_tab_for_student | Set the <b>display_signin_footer_card_in_library_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false|
| 13 | display_onboarding_card | set the display__onboarding_cards as true in sunbird.properties file | to display the guest/login page | false|
| 14 | display_framework_categories_in_profile | set the display_framework_categories_in_profile variable as true in sunbird.properties file | to display categories in the guest/login page | false|
| 15 | track_user_telemetry | Variable used to track user telemetry.| Used to track telemetry that is missing at the device level so as to generate greater usage context within the instance. Set the variable as *true* in the **sunbird.properties** file to enable tracking.  | false|

<b>Packaging Framework and Form Data</b>
Sunbird mobile app supports configuration of the app framework to enable offline usage of the app. To configure the app framework, adopter needs to package the channel for the respective framework. Details of the file naming convention and folder location are given below:

| S No. | Folder | File Name |  Purpose |
|-------|--------|-----------|-------------|
| 1 | buildConfig/data/framework | framework-<FRAMEWORK_IDENTIFIER>.json | To package the channel for the respective framework. Same framework must be listed in the onboarding form API|
| 2 | buildConfig/data/channel | channel-<CHANNEL_IDENTIFIER>.json | To package the channel. Default framework must be same as the packaged framework for respective channel|
| 3 | buildConfig/data/form | syllabus.json | To onboard form API|
| 4 | buildConfig/data/form | pageassemble_course_filter.json | Page assemble filter for course|
| 5 | buildConfig/data/form | pageassemble_library_filter.json | Page assemble filter for library

## Installing Individual Plugins
Sunbird is an open source, configurable, extendable, modular learning management platform architected for scale and designed to support multiple teaching and learning solutions supporting multiple languages and available for online and offline use. Various plugins are utilized to meet this objective. Adopters can choose and intall plugins to customize the application to suit their business needs. This ection details the procedure for installing inidividual plugins for the mobile application.

- Clone the sunbird-mobile repo using the following commands: 
```
git clone [https://github.com/project-sunbird/sunbird-mobile.git](https://github.com/project-sunbird/sunbird-mobile.git).
go to project folder and run **npm i**
**run** ionic cordova platform add android
```

### Genie-SDK-Wrapper
This repository contains common services, and global UI pages required in an app. The services internally call to the cordova plugins. All the http and database related API goes through this npm module.

To generate local node module:

- Clone the sunbird-genie sdk wrapper repo using the following commands: 
```
	git clone [https://github.com/project-sunbird/genie-sdk-wrapper.gi*t](https://github.com/project-sunbird/genie-sdk-wrapper.git)
	npm i
	npm run build
	npm pack path to this folder
```

### Cordova-Plugin-Genie-SDK
This is a cordova plugin for android. It exposes some API’s that internally call the genie services.

- Run the following command to install this plugin in Sunbird-mobile:
```
ionic cordova plugin add [https://github.com/project-sunbird/cordova-plugin-genie-sdk.git](https://github.com/project-sunbird/cordova-plugin-genie-sdk.git)
```

### Cordova-plugin-sunbirdsplash
This plugin displays and hides a splash screen during application launch. To change the splash screen and splash image, go to sunbird-mobile/resources/android/splash and update the **drawable-ldpi-splash.png**

To update your required splash.png file and sunbird-mobile/resources/android/icon update **drawable-ldpi-icon.png** to your required **icon.png file** in the resource folder and  run **ionic cordova run android**. This generates the resource files for this platform and splash image and splash screen automatically changes and is added in config.xml file.

**App Name** is in **sunbird.properties**, change the app name to required name

- Run the following command to install this plugin in Sunbird-mobile:

```
ionic Cordova plugin add [https://github.com/project-sunbird/cordova-plugin-sunbirdsplash.git](https://github.com/project-sunbird/cordova-plugin-sunbirdsplash.git)
```

This is installed with other npm packages.

### Cordova-plugin-geniecanvas
On clicking course material links, the course content is displayed in the in-built content player. The genie canvas renders the display of course materials in the inbuilt player.

- Run the following command to install this plugin in Sunbird-mobile:
```
ionic cordova plugin add [https://github.com/project-sunbird/cordova-plugin-geniecanvas.git](https://github.com/project-sunbird/cordova-plugin-geniecanvas.git)
```

### Cordova-plugin-qr-scanner
This is a custom cordova plugin for the QR scanner.

- Run the following command to install this plugin in Sunbird-mobile:
```
ionic cordova plugin add [https://github.com/project-sunbird/cordova-plugin-qr-scanner.git](https://github.com/project-sunbird/cordova-plugin-qr-scanner.git)
```
This is installed with other npm packages.

### Installing the Mobile Application

  1.Create a workspace  (i.e Folder Hierarchy ) and clone the Git repositories into this folder

  2.Execute the instructions mentioned for each cloned repository

  3.Open terminal and change the directory to "sunbird-mobile" 

  4.Add one device to the system

  5.Run the command- **$ ionic cordova run android**
  
### Generate Multiple Sunbird Apps
As a Sunbird instance owner, owner  should be able to generate multiple apps for multiple environments(dev/qa/production)
so that user can use all the apps simultaneously.
For each app, user should be able to have different content stores (on the local device), fire telemetry from separate app identifiers and upload to playstore (if need be).

#### Configuration
Instance admin of Sunbird adopters can configure the appId in the following way to acheive the functionality
* dev_app_id = org.sample.app.dev
* staging_app_id = org.sample.app.staging
* production_app_id = org.sample.app
