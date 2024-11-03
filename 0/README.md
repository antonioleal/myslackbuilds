## The Zero Scripts Setup

*This folder contains a simple set of Slackware auxiliary scripts, so called zero ("0") scripts, it presents, in fact, one possible setup for you to collaborate with SlackBuilds.org*


Why the "0"? Because it is very useful when you type 0 and press TAB to see what operations you can make in this environment *and* does not interfere with any other program in your Slackware box. Nice and tidy..

---

### Setup
In order to use these environment the following setup is required:

* Install the package `sbo-maintainer-tools` available from SlackBuilds.org

* Install the package `meld` available from SlackBuilds.org

* You must setup a *wokspace* folder where your slackbuilds will be stored, where a sub-folder called "myslackbuilds" should exist. Inside it, you must follow strictly the organization of categories from SlackBuilds.org.
>For example: The **plus42.SlackBuild** and all associated files, *.info, desc, etc.. are stored at `academic/plus42`, so your folder for this SlackBuild should be:
> `/home/{username}/slackware-builds/myslackbuilds/academic/plus42`

* If you placed your *worspace* in a different folder you must make a symlink called "slackware-builds" in your home dir pointing at your *workspace*

* The zero ("0") scripts are placed in your PATH, in my case for example I add to my .bahsrc the line (*1):
> `export PATH=$PATH:/home/antonio/slackware-builds/myslackbuilds/0`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(**1) notice a folder also called "0" actually holding the scripts is placed inside myslackbuilds*

* You must clone SlackBuilds.org with the commands:
> `cd ~/slackware-builds`

> `git clone https://github.com/SlackBuildsOrg/slackbuilds`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
so you end-up with all published slackbuilds in the following structure:
> `/home/{username}/slackware-builds/slackbuilds/(...)`

... and you are ready to go!

### The scripts
The zero ("0") scripts are meant to be started from the slackbuild directory **and only from there**! Inside the slackbuild directory a folder called "0" also exists where you can store any additional files or notes you need to help you maintain your slackbuild. Have a look at my own setup.

Example:
> `cd ~/slackware-builds/myslackbuilds/academic/plus42`

> `0pull-request.sh`

will create a branch and issue a PR on `github.com/SlackBuildsOrg/slackbuilds` 

#### Current scripts

    Script: 0download-source-tarballs.sh
    Effect: Downloads the sources referred in the *.info file.

    Script: 0meld.sh
    Effect: Compares what is currently published in slackbuilds.org (your local folder!)
            with your current script. You need the meld program.

    Script: 0build.sh
    Effect: Starts the build process.

    Script: 0tar.sh
    Effect: creates a "slackbuild".tar.gz ready to be submitted.
    
    Script: 0pull-request.sh
    Effect: Makes a PR to github.com/SlackBuildsOrg/slackbuilds. Please visit
            the github site in order to conclude the PR. Normally a link is 
            displayed for you to copy-paste in your browser.

    Script: 0delete-branches.sh
    Effect: Each Saturday afternoon, you can run this to delete all braches you
            created with the script 0pull-request.sh.

    Script: 0clean-tree.sh
    Effect: if you also placed myslackbuilds directory in github (like me!)
            then this deletes all non-git controlled files.

    Script: 0make_readme.sh
    Effect: if you also placed myslackbuilds directory in github (like me!)
            then this automatically generates a README.md for github.

    Script: 0lspkg.sh
    Effect: A Slackware tool which simply lists the currently installed
            packages.
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

    Script: 0pkginfo.sh
    Effect: A Slackware tool to find the inforamtion about any installed 
            package
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

    Script: 0whichpkg.sh
    Effect: A Slackware tool to find which package a file comes from.
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

    Script: 0slackware-package-dependencies.sh
    Effect: Inspect a binary file and check discover its package dependencies.