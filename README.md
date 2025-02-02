# ForkGitResetCommit
A little tool I made for resetting my last commit when encountering errors when pushing with Fork.
Batch file with git commands. Tested with Fork and Git-2.47.1.2 on Windows 10.


I got tired of using the console everytime I needed to undo a commit because of an error, so here it is.

If you don't know what Fork or Git is, or you haven't had any issues with them, this script is not for you.

You NEED to edit line 17 of the batch file for it to work. Just put in the full path to the repo you're using:

  :: REPLACE with path to your local copy of the repo
  cd /d "C:\...\.. ..\YourRepo"
  

## How it works:
On start, executes and reads Git Status.
  If your working tree is dirty, the tool will close. This means you have unstaged and/or staged files.
  You can stash or copy them somewhere else if you need to undo a commit that hasn't been pushed.
  
If git status outputs "working tree clean", it will ask if you want to undo your last commit [Y/N].
  [Y] Continue with undo
  [N] Exit without changes

On continuing, your last committed files will be moved to the Staged state. It will then ask if you want to save them to a new stash[Y/N].
  [Y] Continue saving to stash. Creates a new stash named "[COMMITSUBJECT] // [DATE]". Will exit on saved.
  [N] Exit, files left in Staged state.
