---
title: Algorithm's Digital Garden and its Setup
description: How to Setup Quartz 4 Website with Obsidian to deploy on GitHub Pages
date: 2026-01-16
tags:
  - how-setup-blogging-site
  - utility
toc: false
---
# Introduction
How to deploy a website with a sync with GitHub Repository using Quartz 4. 

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

## Bonus Step: How to apply themes?
1. go to website: https://github.com/saberzero1/quartz-themes
2. Select a theme from `supported-themes` 
3. once you select your theme, remember `Obsidian Theme Name`
4. go to `.github\workflows` and open `deploy.yml`
5. Add the following lines to your `deploy.yml` before the `permissions` section: (Change `<THEME-NAME>` to `latex` or Your selected theme.)
``` yaml
env:
  THEME_NAME: <THEME-NAME>
```
6. And add the following lines to your `deploy.yml` before the `build` step: (No Need to change anything, not even `$THEME_NAME`)
```yaml
- name: Fetch Quartz Theme
  run: curl -s -S https://raw.githubusercontent.com/saberzero1/quartz-themes/master/action.sh | bash -s -- $THEME_NAME
```

***FULL `deploy.yml` CODE with `latex` theme***
``` yaml
name: Algorithms by mrunalnshah to GitHub Pages
 
on:
  push:
    branches:
      - v4
      
env:
  THEME_NAME: latex
 
permissions:
  contents: read
  pages: write
  id-token: write
 
concurrency:
  group: "pages"
  cancel-in-progress: false
 
jobs:
  build:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Fetch all history for git info
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - name: Install Dependencies
        run: npm ci
      - name: Fetch Quartz Theme
        run: curl -s -S https://raw.githubusercontent.com/saberzero1/quartz-themes/master/action.sh | bash -s -- $THEME_NAME
      - name: Build Quartz
        run: npx quartz build
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: public
 
  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```


***Thanks and all hail open source,***
Mrunal Nirajkumar Shah.