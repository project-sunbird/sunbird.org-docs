---
title: Initializing Sunbird
page_title: Initializing Sunbird
description: Initializing Sunbird instance for first use.
keywords: ansible, variables, private github repository, private repo, initialize
allowSearch: true
---

## Overview

Congratulations! You have successfully installed Sunbird. But the instance is not yet ready to be consumed. Here, you'll initialize the Sunbird instance for the basic content create-review-publish-consume workflow. Which includes creating

- Channel
- Organization
- Frameworks
- Categories
- Terms
- Users ( creator, reviewer, publisher )

Once this setup is done, you'll be able to login, create, review, publish and consume the content.

## Setup

Open Jenkins and trigger 

  Deploy -> dev -> init_sunbird
