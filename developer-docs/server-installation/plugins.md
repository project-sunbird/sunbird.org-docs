---
title: Plugins
page_title: Plugins
description: Explains how to build and deploy plugins
keywords: plugins, content plugins, content framework 
allowSearch: true

---

## Overview
This page explains the jobs to be run to build and deploy plugins. In order to do so, log into Jenkins and execute the instructions as per the sequence provided on this page.

## Build

Switch to the `Build/Plugins` folder and run all jobs. Ensure all ArtifactUpload jobs are sucessful after the build. For the value of the **github_release_tag**, refer to [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:

1.ContentPlugins  
2.ContentPlayer  
3.CollectionEditor  
4.ContentEditor  
5.GenericEditor  
