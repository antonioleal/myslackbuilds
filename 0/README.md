<p align="center">
<img src="media/zeroscripts.png"  alt="Silk" style="width:33%; height:auto;"/>
</p>

## The Zero Scripts Setup

*This folder contains a simple set of Slackware auxiliary scripts, the so called Zero Scripts ("0") , that simplify the process for you to collaborate with SlackBuilds.org*

Why the "0"? Because with *bash* it's very useful when you type 0 and press TAB twice to see what operations you can make in this environment *and* does not interfere with any other program in your Slackware box. Nice and tidy..

---

### Setup
A script called 0setup is provided to install the initial environment and the auxiliary packages described below, but the explanation is necessary for your understanding.

In order to use this environment the following setup is required:

* the package `sbo-maintainer-tools` available from SlackBuilds.org

* the package `github-cli` available from SlackBuilds.org

* the package `jq` available from SlackBuilds.org

* the package `meld` available from SlackBuilds.org

* Other useful package is KDE's `Ark`, specially if you use the **0** menu

* You must setup a *wokspace* folder where your slackbuilds will be stored, where a sub-folder called "myslackbuilds" should exist. Inside it, you must follow strictly the organization of categories from SlackBuilds.org.
>For example: The **plus42.SlackBuild** and all associated files, *.info, desc, etc.. are stored at `academic/plus42`, so your folder for this SlackBuild should be:
> `$HOME/slackware-builds/myslackbuilds/academic/plus42`

* If you placed your *workspace* in a different folder you must make a symlink called "slackware-builds" in your home directory pointing at your *workspace*

* The zero scripts location must be placed in your PATH, for example by adding this line to your .bashrc:
> `export PATH=$PATH:$HOME/slackware-builds/myslackbuilds/0`

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
        
            myslackbuilds/
                .git
                 0/                     <- the "0" main scripts live here
                 academic/plus42/       <- your plus42 scripts go here
                 academic/plus42/0/     <- place whatever you want here
                 (...etc...)
                 desktop/my_great_new_slackbuild  <- in "desktop", for ex.
                
             slackbuilds                <- your fork of slackbuilds
                .git
                 academic/3D-ICE/
                 academic/celestia/
                 academic/plus42/
                 desktop/thunar-sendto-clamtk
                 (...etc...)
        
             otherbuilds
                 some_test_or_scripts_from_others/
                 (...etc...)
    


... and you are ready to go!

### The menu
A simple menu describing the complete workflow and helping with the build sequence is provided in the **0** script (which you can invoke by just typing "**0**" also). You need to start it from the slackbuild folder as it reads the .info file.

### The scripts
With a few exceptions the zero ("0") scripts are meant to be started from the slackbuild directory. Inside the slackbuild directory a folder called "0" also exists where you can store any additional files or notes you need to help you maintain your slackbuild. Have a look at my own setup.

Example:
> `cd ~/slackware-builds/myslackbuilds/academic/plus42`

> `0pull-request`

will create a branch and issue a PR on `github.com/SlackBuildsOrg/slackbuilds` 

#### Current scripts

    Script: 0auto-updater
    Effect: Check a multitude of sites to know if new versions are available.
            But you need to provide an updater script. See my examples.
            Notice you are web-crawling so use this with care.

    Script: 0build
    Effect: Starts the build process.

    Script: 0clean-tree
    Effect: if you also placed myslackbuilds directory in github (like me!)
            then this deletes all non-git controlled files.

    Script: 0commit-push
    Effect: Runs 0make-readme, commits and pushes your changes to your github repo.

    Script: 0delete-branches
    Effect: Each Saturday afternoon, you can run this to delete all braches you
            created with the script 0pull-request.

    Script: 0download-source-tarballs
    Effect: Downloads the sources referred in the *.info file. It also
            checks if MD5SUM(s) are correct in the infor file, use together
            with 0print-tarball-md5sums to prepare a new *.info file.

    Script: 0lspkg
    Effect: A Slackware tool which simply lists the currently installed
            packages.
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

    Script: 0make-missing-readmes
    Effect: if you also placed myslackbuilds directory in github (like me!)
            then this automatically generates a README.md for github.

    Script: 0make-readme
    Effect: if you also placed myslackbuilds directory in github (like me!)
            then this automatically generates a README.md for github.

    Script: 0make-updater
    Effect: This command will create the "updater" script, as well as two templates
            based on *.info and *.SlackBuild files:
                    <you slackbuild folder>/0/updater
                    <you slackbuild folder>/0/version
                    <you slackbuild folder>/0/template/<program>.info.template
                    <you slackbuild folder>/0/template/<program>.SlackBuild.template
            You need to carefully check what the updater is doing and test if it can
            recreate your current version of SlackBuild. To do that write some string
            inside the 0/version file, for ex "1234", run the updater andheck the
            resulting new *.info and *.SlackBuild using git --diff.

    Script: 0meld
    Effect: Compares what is currently published in slackbuilds.org (your local folder!)
            with your current script. You need the meld program.

    Script: 0pkginfo
    Effect: A Slackware tool to find the inforamtion about any installed 
            package
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459

    Script: 0pull-request
    Effect: Makes a PR to github.com/SlackBuildsOrg/slackbuilds.

    Script: 0replace-string
    Effect: This uses sed to replace one string for another in your whole slackbuild scripts.
            Very useful, but use with care.

    Script: 0reset
    Effect: Resets & cleans myslackbuilds and if parameter "all" is specified also your
            slackbuilds clone folder.

    Script: 0setup
    Effect: Run once to setup your slack-builds '0' environment.

    Script: 0slackware-binary-dependencies
    Effect: Inspect a binary file and check discover its package dependencies.

    Script: 0takeover
    Effect: copies and modifies a SlackBuild from "slackbuilds" to "myslackbuilds"
            so that it is prepared for you to takeover its maintenance.
            Your need to edit YOURNAME, YOUREMAIL and YOURCOPYRIGHT variables
            in the 0takeover script, unless you want to use mine ;-)

    Script: 0tar
    Effect: creates a "slackbuild".tar.gz pack ready to be submitted on the
            folder 0/slackbuild under the SlackBuild you are working.
            This step is needed before you run 0commit-push

    Script: 0update-md5-info
    Effect: Reads the source(s) in *.info file, calculates new MD5SUM(s) and   
            produces a new *.info file.

    Script: 0whichpkg
    Effect: A Slackware tool to find which package a file comes from.
            see http://www.linuxquestions.org/questions/showthread.php?postid=899459#post899459


### Workflows

If you are in Europe SlackBuilds.org commits occur during the morning of each Saturday. So your workflow would be something like the one described here.

##### "During the week":
1. Check if new sources are available upstream for each of your packages.
    * Better still: subscribe to be notified when this occurs!

2. Check if any slackbuild maintainer has modified your script. Sometimes they do! Use **0meld** to compare your current script with the published one.

3. Once a new source is available update the *.info file and point DOWNLOAD and DOWNLOAD_x86_64 to the new source tarballs on the web.
   * Afterwards **0download-source-tarballs** and **0update-md5-info** are your friends.

4. Update your *.SlackBuild script
    * Sometimes is just a matter of upgrading the version number, but upstream developers sometimes change formats.
    * **0replace-string** is your friend.
    * If you patched the original sources make sure these mods are still applicable.

5. Build the source with **0build** saying 'yes' to all the steps.
    * The build package will be in /tmp as usual.
    * A new compressed `'package'.tar.gz` will be created in 0/slackbuild sub-folders of your SlackBuild. You can also use **0tar** for this.

6. Test you new build.
    * It is a good idea to install your new software in a "clean" setup. If possible use a virtual machine.
    * If your tests are successful then you are ready to publish your work.

7. If this is a second submission of an existing SlackBuild you can create a Pull Request (PR) with **0pull-request**
    * Go to the github.com/SlackBuildsOrg/slackbuilds and confirm the PR.

    Otherwise, for first submissions, (totally new SlackBuild scripts) you have to use the SlackBuilds.org site and manually upload your work.

8. Periodically check github.com/SlackBuildsOrg/slackbuilds to see if you work has been approved, or rejected by some reason.
    * Its is a very good idea to subscribe to the `slackbuilds-users` and `slackbuilds-devel` mailling lists so you are aware of what other people are doing. You can also ask for specific help regarding your scripts or get the "maintainer" status for new ones.

##### "Saturday afternoon":
1. Once your scripts are released to the public go to `https://github.com/{your account}/slackbuilds` and synchronize your fork with the upstream master.

2. Run `git pull --rebase` on your ~/slackware-builds/slackbuilds folder

3. Delete accessory branches by running **0delete-branches all**

4. Run **0reset all** to get rid of unneeded tarballs and other trash.

5. That's it. Now you are ready to restart the workflow.

##### "During the week":
Strictly optional, if you constructed updater scripts for your slackbuilds (see my examples), then you can run the scipt **0auto-updater** to check automatically if the upstream developers of your packages have released anything new.

#### Happy Slacking!
António Leal
