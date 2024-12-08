## The Zero Scripts Setup

*This folder contains a simple set of Slackware auxiliary scripts, so called zero ("0") scripts, it presents, in fact, one possible setup for you to collaborate with SlackBuilds.org*


Why the "0"? Because with *bash* it's very useful when you type 0 and press TAB to see what operations you can make in this environment *and* does not interfere with any other program in your Slackware box. Nice and tidy..

---

### Setup
In order to use these environment the following setup is required:

* Install the package `sbo-maintainer-tools` available from SlackBuilds.org

* Install the package `meld` available from SlackBuilds.org

* Other useful packages are Meld and Ark

* You must setup a *wokspace* folder where your slackbuilds will be stored, where a sub-folder called "myslackbuilds" should exist. Inside it, you must follow strictly the organization of categories from SlackBuilds.org.
>For example: The **plus42.SlackBuild** and all associated files, *.info, desc, etc.. are stored at `academic/plus42`, so your folder for this SlackBuild should be:
> `/home/{username}/slackware-builds/myslackbuilds/academic/plus42`

* If you placed your *workspace* in a different folder you must make a symlink called "slackware-builds" in your home directory pointing at your *workspace*

* The zero ("0") scripts are placed in your PATH, in my case for example I add to my `.bahsrc` the line (*1):
> `export PATH=$PATH:/home/antonio/slackware-builds/myslackbuilds/0`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(**1) notice a folder also called "0" actually holding the scripts is placed inside myslackbuilds*

* Create a github repository called 'myslackbuilds'. Check github policy (account key, etc..) so you are able to commit to your own repository. Now push all your own scripts to it, including (eventually) also the myslackbuilds/0 directory. Your 'myslackbuilds' should have a similar structure to 'slackbuilds' but naturally with much less SlackBuilds, or none at all if you are just starting.

* Next you must fork https://github.com/SlackBuildsOrg/slackbuilds you can do it directly from github site with the click of a button.

* Now clone your fork of SlackBuilds.org with the commands:
> `cd ~/slackware-builds`

> `git clone https://github.com/{your account}/slackbuilds`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
so you end-up with all published slackbuilds in the following structure:
> `/home/{username}/slackware-builds/slackbuilds/(...)`


In the end your work environment should look like this:

        ~/slackware-builds/
        
            /myslackbuilds/
                .git
                /0/                     <- your auxiliary scripts go here
                /academic/plus42/       <- your plus42 scripts go here
                /academic/plus42/0/     <- place whatever you want here
                (...etc...)
                /desktop/my_great_new_slackbuild  <- in "desktop", for ex.
                
            /slackbuilds                <- your fork of slackbuilds
                .git
                /academic/3D-ICE/
                (...etc...)
                /academic/celestia/
                /academic/plus42/
                (...etc...)
                /desktop/thunar-sendto-clamtk
                (...etc...)
        
            /otherbuilds
                /some_test_or_scripts_from_others/
                (...etc...)
    


... and you are ready to go!

### The scripts
The zero ("0") scripts are meant to be started from the slackbuild directory **and only from there**! Inside the slackbuild directory a folder called "0" also exists where you can store any additional files or notes you need to help you maintain your slackbuild. Have a look at my own setup.

Example:
> `cd ~/slackware-builds/myslackbuilds/academic/plus42`

> `0pull-request.sh`

will create a branch and issue a PR on `github.com/SlackBuildsOrg/slackbuilds` 

#### Current scripts

    Script: 0download-source-tarballs.sh
    Effect: Downloads the sources referred in the *.info file. It also
            checks if MD5SUM(s) are correct in the infor file, use together
            with 0print-tarball-md5sums.sh to prepare a new *.info file.

    Script: 0update-info.sh
    Effect: Reads the source(s) in *.info file, calculates new MD5SUM(s) and   
            produces a new *.info file.
            
    Script: 0meld.sh
    Effect: Compares what is currently published in slackbuilds.org (your local folder!)
            with your current script. You need the meld program.

    Script: 0build.sh
    Effect: Starts the build process.

    Script: 0tar.sh
    Effect: creates a "slackbuild".tar.gz pack ready to be submitted on the
            folder 0/slackbuild under the SlackBuild you are working.
    
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



### Workflows

If you are in Europe SlackBuilds.org commits occur during the morning of each Saturday. So your workflow would be something like the one described here.

##### "During the week":
1. Check if new sources are available upstream for each of your packages.
    * Better still: subscribe to be notified when this occurs!

2. Check if any slackbuild maintainer has modified your script. Sometimes they do! Use **0meld.sh** to compare your current script with the published one.

3. Once a new source is available update the *.info file and point DOWNLOAD and DOWNLOAD_x86_64 to the new source tarballs on the web.
   * Afterwards **0download-source-tarballs.sh** and **0update-info.sh** are your friends.

4. Update your *.SlackBuild script
    * Sometimes is just a matter of upgrading the version number, but upstream developers sometimes change formats.
    * If you patched the original sources make sure these mods are still applicable.

5. Build the source with **0build.sh** saying 'yes' to all the steps.
    * The build package will be in /tmp as usual.
    * A new compressed `'package'.tar.gz` will be created in 0/slackbuild sub-folders of your SlackBuild. You can also use **0tar.sh** for this.

6. Test you new build.
    * It is a good idea to install your new software in a "clean" setup. If possible use a virtual machine.
    * If your tests are successful then you are ready to publish your work.

7. If this is a second submission of an existing SlackBuild you can create a Pull Request (PR) with **0pull-request.sh**
    * Go to the github.com/SlackBuildsOrg/slackbuilds and confirm the PR.

    Otherwise, for first submissions, (totally new SlackBuild scripts) you have to use the SlackBuilds.org site and manually upload your work.

8. Periodically check github.com/SlackBuildsOrg/slackbuilds to see if you work has been approved, or rejected by some reason.
    * Its is a very good idea to subscribe to the `slackbuilds-users` and `slackbuilds-devel` mailling lists so you are aware of what other people are doing. You can also ask for specific help regarding your scripts or get the "maintainer" status for new ones.

##### "Saturday afternoon":
1. Once your scripts are released to the public go to `https://github.com/{your account}/slackbuilds` and synchronize your fork with the upstream master.

2. Run `git pull --rebase` on your ~/slackware-builds/slackbuilds folder

3. Delete all accessory branches by running **0delete-branches.sh**

4. Run **0clean-tree.sh** to get rid of unneeded tarballs.

5. That's it. Now you are ready to restart the workflow.

### Last but not least
A simple menu describing the complete workflow and helping with the build sequence is provided in the **0.sh** script.

#### Happy Slacking!
António Leal
