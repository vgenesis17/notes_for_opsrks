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
