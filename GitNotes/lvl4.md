The Nautilus application development team was working on a git repository /opt/apps.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details:



Merge the feature branch into the master branch`, but before pushing your changes complete below point.

Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.



[natasha@ststor01 ~]$sudo /opt/games.git/hooks/post-update
#!/bin/bash
cd /opt/beta.git
tag=release-$(date "+%Y-%m-%d")
git tag $tag



perform git merge 
and git push


git tag

verify

cd /opt/demo.git
git show-ref --tags






5. Some new developers have joined xFusionCorp Industries and have been assigned Nautilus project. They are going to start development on a new application, and some pre-requisites have been shared with the DevOps team to proceed with. Please note that all tasks need to be performed on storage server in Stratos DC.



a. Install git, set up any values for user.email and user.name globally and create a bare repository /opt/official.git.


b. There is an update hook (to block direct pushes to the master branch) under /tmp on storage server itself; use the same to block direct pushes to the master branch in /opt/official.git repo.


c. Clone /opt/official.git repo in /usr/src/kodekloudrepos/official directory.


d. Create a new branch named xfusioncorp_official in repo that you cloned under /usr/src/kodekloudrepos directory.


e. There is a readme.md file in /tmp directory on storage server itself; copy that to the repo, add/commit in the new branch you just created, and finally push your branch to the origin.


f. Also create master branch from your branch and remember you should not be able to push to the master directly as per the hook you have set up.


---------------
sudo git config --global user.name "Josip"
sudo git config --global user.email "Josip@example.com"

sudo git init --bare /opt/blog.git

sudo cp /tmp/update /opt/blog.git/hooks/
```bash
[natasha@ststor01 ~]$ cat /tmp/update
#!/bin/sh
if [ "$1" == refs/heads/master ];
then
  echo "Manual pushes to the master branch is restricted!!"
  exit 1
fi
```

cd /usr/src/kodekloudrepos/


git clone /opt/blog.git

cd blogs 
git status

git branch 

git checkout -b xfusioncorp_blog

git branch

git status

cp /tmp/readme.md .

git add readme.md
git commit -m " add readme"

git push --set-upstream origin xf...

create branch:

git checkout -b master