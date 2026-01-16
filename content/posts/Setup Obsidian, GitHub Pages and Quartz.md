---
title: How to Setup Quartz with Obsidian to deploy on GitHub Pages
description: How to setup the website with Obsidian, GitHub and Quartz 4
date: 2026-01-16
tags:
  - how-setup-blogging-site
  - utility
toc: false
---
# Introduction
How to deploy a website with a sync with GitHub Repository using Quartz. 

## What we need (for Windows)?
We need:
1. Official documentation: https://quartz.jzhao.xyz/
2. [Node.js](https://nodejs.org/en) v22

~~LET US BEGIN...~~
## Step 1: Cloning Repository

***Run PowerShell / Terminal in admin mode only***

Clone the Quartz Repository (at your location where you want to save your website):
`git clone https://github.com/jackyzha0/quartz.git`

## Step 2: Move into Cloned Repo

command: `cd quartz`

## Step 3: Run Node Command to Create Quartz Instance

***Do not run `npm audit fix`. This will break stuff.***
### Step 3.1 Create Instance
command: `npm i`
### Step 3.2 Create Quartz
command: `npx quartz create`

#### Step 3.2.1 Select initialize content
***I would strongly suggest to use symlink, which is going to link your files in different directory to the content.*** You just need to add path to that directory. Remember `index.md` file need to be accessible in the folder.
#### Step 3.2.2 Treat link `as shortest path`

***You are all set!***

## Step 4: Sync With GitHub
1. Open GitHub Account and Create a new Repository of any name. **Remember not to initialize the new repository with `README`, license, or `gitignore` files.
2. Once create, you will see HTTPS selected, and a link like `https://github.com/username/reponame.git`. COPY IT.
3. RUN THE FOLLOWING COMMAND:
	1. list all the repositories that are tracked
		 `git remote -v`
	2. if the origin doesn't match your own repository, set your repository as the origin 
		 `git remote set-url origin COPIED-URL`
	3. `npx quartz sync --no-pull` ***This will init push the initial code***
## Step 5: Writing Content in Quartz

1. First file that will render is `index.md`
2. Template to follow:
``` markdown
---
title: Example Title
draft: false
tags: 
	- example-tag	  
--- 

The rest of your content lives here. You can use **Markdown** here :)
```

3. Some common frontmatter fields that are natively supported by Quartz:
	- `title`: Title of the page. If it isn’t provided, Quartz will use the name of the file as the title.
	- `description`: Description of the page used for link previews.
	- `permalink`: A custom URL for the page that will remain constant even if the path to the file changes.
	- `aliases`: Other names for this note. This is a list of strings.
	- `tags`: Tags for this note.
	- `draft`: Whether to publish the page or not. This is one way to make [pages private](https://quartz.jzhao.xyz/features/private-pages) in Quartz.
	- `date`: A string representing the day the note was published. Normally uses `YYYY-MM-DD` format.

***Write `index.md` and use that file to link rest of the `.md` files.***

4. You wrote `index.md` and more files? nice!
5. RUN: `npx quartz sync` to sync with GitHub.
## Step 6: Configure
Docs: https://quartz.jzhao.xyz/configuration

**Quartz is meant to be extremely configurable, even if you don’t know any coding. Most of the configuration you should need can be done by just editing `quartz.config.ts` or changing [the layout](https://quartz.jzhao.xyz/layout) in `quartz.layout.ts`.**

**Its on you to research your need and find the best config for you**.

## Step 7: Layout Config
Docs: https://quartz.jzhao.xyz/layout

**Again on you**

## Step 8: Building your Quartz locally
RUN: `npx quartz build --serve`

## Step 9: Sync your changes to GitHub
Docs: https://quartz.jzhao.xyz/setting-up-your-GitHub-repository

RUN: `npx quartz sync --no-pull`


## Step 10: Deploy to GitHub Pages?
1. Head to “Settings” tab of your forked repository and in the sidebar, click “Pages”. Under “Source”, select “GitHub Actions”.
2. Commit these changes by doing `npx quartz sync`. This should deploy your site to `<github-username>.github.io/<repository-name>`.

***Thanks and all hail open source,***
Mrunal Nirajkumar Shah.