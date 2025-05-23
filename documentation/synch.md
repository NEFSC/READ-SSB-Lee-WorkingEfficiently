# Setup
I have an **upstream** repository here: https://github.com/NEFSC/READ-SSB-Lee-WorkingEfficiently

I have a **target** repository here: https://github.com/mle2718/Lee-WorkingEfficiently 

The **target** is a fork of the upstream. I do not plan to develop in the "main" branch of the target repository.  I might develop in a "dev" branch. I might just want to have my own up-to-date fork.

The upstream repository must be a public repository. You might be able to get it to work on a private one, but I don't know how to do that yet.

# Instructions

1. In your github account,  create a token called "MY_WORKFLOW_TOKEN".  
	* Click your profile pic in the top right, on the left, click developer settings, then personal access tokens, then fine-grained tokens.  Then Generate new token.
	* Give this token at least Read and write access to actions and code.  I also gave it Read access to commit statuses and metadata
	* Make note of this token (put it in KeePass?)


2. Store the token from step 1 in your **target** repository.
	  * Open the repo, click  Settings, Secrets and variables dropdown on the left, "Actions".  Then click the "New repository secret"  
    Name = "MY_WORKFLOW_TOKEN" 
    Secret = token from step 1


3. Download this file https://github.com/NEFSC/READ-SSB-Lee-WorkingEfficiently/blob/main/.github/workflows/wf-fork-sync.yaml.  Modify the lines of code that pass in the upstream branch to checkout/sync (2 places), the target branch name, and the upstream repo name.  


```
    steps:
    - name: Checkout main
      uses: actions/checkout@v2
      with:
        ref: main # or master


      with:
        target_sync_branch: main    # or master
        upstream_sync_branch: main  # or master
        upstream_sync_repo: NEFSC/READ-SSB-Lee-WorkingEfficiently # the location of the upstream repo
```

Step 4. Upload the modified file to the /.github/workflows folder in your **target** repository.

Step 5. Test by going to your **target** repository, actions, and then try to run the workflow manually.  It can take a few seconds for the workflow to complete.

To do this in other repositories, repeat steps 2-5.

# References

1. https://github.com/marketplace/actions/upstream-sync, which is on github here: https://github.com/aormsby/Fork-Sync-With-Upstream-action
   
2. https://github.com/marketplace/actions/sync-fork-action, which is on githbu here: https://github.com/XueMoMo/Sync-Fork-action

