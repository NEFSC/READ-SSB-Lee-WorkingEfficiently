# Introduction
This repository is simply a collection of other repositories that are designed to help you work more efficiently, plus a "how to help" section.  I used [my project template](https://github.com/NEFSC/READ-SSB-Lee-project-template) to start this up, so there are probably a bunch of extraneous bits.  Consider this a table of contents.

# Other repositories 
1. All sorts of information about the data in the [NEFSC Oracle databases](https://github.com/NEFSC/READ-SSB-Lee-metadata).
2. [A project template](https://github.com/NEFSC/READ-SSB-Lee-project-template), full of fun stuff to get your project started on the right foot.
4. Information about setting up github and extracting oracle data on the [servers](https://github.com/NEFSC/READ-SSB-LEE-On-the-servers)
5. Some code to run [R on the NEFSC Servers](https://github.com/NEFSC/READ-SSB-Lee-Ronthenetwork).  
6. A scraper for the  [NMFS foreign trade website](https://github.com/cameronspeir/NOAA-Foreign-Fishery-Trade-Data-API).  
7. [Code to extract external data](https://github.com/NEFSC/READ-SSB-Lee-external-data) from BLS, St. Louis Federal Reserve, and NMFS FOSS.  
8. Code to construct Affiliated Firms for the [Regulatory Flexibility Act Analyses](https://github.com/NEFSC/READ-SSB-Lee-RFAdataset).
9. Some code to run [Call Stata from R](https://github.com/NEFSC/READ-SSB-LEE-R_calling_stata).  
10. A semi-random jumble of [code scraps](https://github.com/NEFSC/READ-SSB-Lee_code_scraps).  
11. Code to assemble [custom rasters](https://github.com/NEFSC/READ-SSB-Lee-Raster_requests).  
12. Code to work with the [NCEP  NARR reanalysis data ](https://github.com/NEFSC/READ-SSB-Lee-reanalysis).  
13. The [offshoreWind](https://github.com/dcorvi/offshoreWind) package.



# How to help 

To just keep tabs on a repository for changes, you can watch it using the watch button on the top right. ![Here's a picture](/images/watch.png)

Please help make these more valuable and keep them up-to-date.  To add your knowledge:

## For quick additions and changes, use the github web editor
1.   Make your changes  - click the file you want to edit and then the little pencil on the right side. ![Here's a picture](/images/straight_edit.jpg)
   
   This will create your own fork and you will see something that looks like this:  ![Here's a picture](/images/auto_fork.png)
  
2.   Make your changes, and use the preview button to make sure it looks nice. ![Here's a picture](/images/editor_preview.jpg)
3.   Issue a [Pull Request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork) so the changes get into the document.  It's a good idea to request a review so the maintainer knows that they need to review and commit.

## For more involved changes
1.  [Fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) - It's in the top right of github.  ![Here's a picture](/images/fork_edit.jpg)
2.  Make a local copy of your fork.  
3.  Commit your changes to your fork.  Push the changes up to github
4.  Submit a Pull Request to bring your changes in to the main one.


# Lagniappe

Who doesn't like a little extra? Here are some resources on Git and Github:
1. https://sethrobertson.github.io/GitFixUm/fixup.html : how to undo things in git
2. https://rewind.com/blog/recovering-deleted-files-in-github): how to recover deleted files.
3. [Why bother with git](https://www.youtube.com/watch?v=eWxxfttcMts)
4. [Using Git with Rstudio](https://cfss.uchicago.edu/setup/git-with-rstudio/) 
5. [Even more on Github with Rstudio](https://rfortherestofus.com/2021/02/how-to-use-git-github-with-r/)

## Dealing with Merge Conflicts
When merging Branch B <- Branch new_feature, there are sometimes merge conflicts. This happens when code has changed in both-- git cannot possibly know which to keep.  I recommend using Github Desktop or the command line to deal with merge conflicts. The reason not to use Github's web interface is because github merges Branch new_feature <-Branch B when it resolves the conflicts. You may or may not want to do this. Resolving merge conflicts is probably the scariest part of using git, so ask for help if you are unsure of what to do.

To deal with merge conflicts in the command line from within Rstudio, click on the "Terminal" tab:
```
git pull
git checkout B 
git merge new_feature
```
You will get a "merge conflict" message. Open all the files that are marked with a "U" and resolve the conflicts. Then save, commit, and push as usual.


When there's a merge conflict, git will create a combined file that has code from both. Code from one branch will show up between: 

`<<<<<<< HEAD`

and 
`======`

Code from the other branch shows up between 
`======`

`>>>>>>>`

You have to figure out which you want and then delete these parts:
```
<<<<<<< HEAD
======
>>>>>>> 
```

[More reading](https://stackoverflow.com/questions/7901864/git-conflict-markers)

## How to Revert a Single File  

This is a way to go back to an earlier version of a file and remove any changes to the file from a specific commit ID. You'll want to do this in the Terminal if working in RStudio. More info can be found [here](https://dev.to/lofiandcode/git-and-github-how-to-revert-a-single-file-dha).  

1. Find the Commit ID  
2. Find the File Path  
3. Revert the file using the following code: 
```
git checkout [commit ID] -- path/to/file 
```
4. Commit the change:
```
git commit -m 'commit message'  
```

## Tidying up local branches

You might want to delete local branches. Perhaps they no longer exist on github after they were pulled into main?  To do this open a terminal. In the working directory type:
```
git branch
```
to list the names of your branches and then 
```
git branch -d <branch_to_delete>
```
You will need to use the -D option if you are deleting a branch that has not been fully merged. Like if some of your new code is  bad.

## Tidying up remote branches

After you merge a branch in github, you should also delete it on your local machine. Although nothing bad will happen if you don't. To do so type:
```
git remote show origin
```
It will show how your local branches correspond to the remote branches on github. It will also tell you about stale branches (that your computer think exist, but are no longer on github). Stale branches can be deleted with

```
git remote prune origin
```

## Suggesting in github

If you want to make a suggestion on a pull request, enclose your new code with
````
```[suggestion]
change
```
````
https://stackoverflow.com/questions/60311158/how-can-i-suggest-multiple-lines-be-changed-in-markdown



# NOAA Requirements
This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.”


1. who worked on this project:  Min-Yang Lee
1. when this project was created: October, 2021 
1. what the project does: Brief directory of various bits of code that will help Social Science folks at NEFSC work more efficiently.
1. why the project is useful:  Helps people be a little more efficient
1. how users can get started with the project: Just GoGoGo.
1. where users can get help with your project:  email me or open an issue
1. who maintains and contributes to the project. Min-Yang

# License file
See here for the [license file](License.txt)
