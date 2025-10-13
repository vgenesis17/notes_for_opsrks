Nautilus developers are actively working on one of the project repositories, /usr/src/kodekloudrepos/cluster. Recently, they decided to implement some new features in the application, and they want to maintain those new changes in a separate branch. Below are the requirements that have been shared with the DevOps team:



On Storage server in Stratos DC create a new branch xfusioncorp_cluster from master branch in /usr/src/kodekloudrepos/cluster git repo.


Please do not try to make any changes in the code.


```bash
cd /usr/src/kodekloudrepos/cluster

git checkout master

git pull origin master

git branch xfusioncorp_cluster

git checkout xfusioncorp_cluster

git checkout -b xfusioncorp_cluster master

```
verify: 
git branch


-------------------------------------------------------------------------------------------

The Nautilus application development team has been working on a project repository /opt/media.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:



Create a new branch devops in /usr/src/kodekloudrepos/media repo from master and copy the /tmp/index.html file (present on storage server itself) into the repo. Further, add/commit this file in the new branch and merge back that branch into master branch. Finally, push the changes to the origin for both of the branches.

cd /usr/src/kodekloudrepos/media

git status
git branch

git checkout master
git checkout -b devops
cp /tmp/index.html .
git add index.html
git commit -m "Added index.html in devops branch"
git checkout master
git merge devops


git push origin master
git push origin devops


cd /opt/games.git
ls
HEAD  branches  config  description  hooks  info  objects  refs


bare should be inititalized:
git init --bare /opt/games.git


sudo chown -R natasha:natasha /opt/games.git
chmod -R 775 /opt/games.git



3. The Nautilus application development team has been working on a project repository /opt/media.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team: Create a new branch devops in /usr/src/kodekloudrepos/media repo from master and copy the /tmp/index.html file (present on storage server itself) into the repo. Further, add/commit this file in the new branch and merge back that branch into master branch. Finally, push the changes to the origin for both of the branches.


cd /usr/src/kodekloudrepos/media

git checkout master
git pull origin master   # make sure master is up to date
git checkout -b devops

cp /tmp/index.html .

git add index.html
git commit -m "Added index.html in devops branch"

git push origin devops

git checkout master
git merge devops

git push origin master




4. The xFusionCorp development team added updates to the project that is maintained under /opt/media.git repo and cloned under /usr/src/kodekloudrepos/media. Recently some changes were made on Git server that is hosted on Storage server in Stratos DC. The DevOps team added some new Git remotes, so we need to update remote on /usr/src/kodekloudrepos/media repository as per details mentioned below:


a. In /usr/src/kodekloudrepos/media repo add a new remote dev_media and point it to /opt/xfusioncorp_media.git repository.


b. There is a file /tmp/index.html on same server; copy this file to the repo and add/commit to master branch.


c. Finally push master branch to this new remote origin.



 git config --global --add safe.directory /usr/src/kodekloudrepos/media



cd /usr/src/kodekloudrepos/media
git remote add dev_media /opt/xfusioncorp_media.git


git remote -v

cp /tmp/index.html /usr/src/kodekloudrepos/media/
git add index.html
git commit -m "Add index.html file"


git push dev_media master


---------------------------------------------------------------------------------------------------


The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/blog present on Storage server in Stratos DC. However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo HEAD to last commit. Below are more details about the task:


In /usr/src/kodekloudrepos/blog git repository, revert the latest commit ( HEAD ) to the previous commit (JFYI the previous commit hash should be with initial commit message ).


Use revert blog message (please use all small letters for commit message) for the new revert commit.


cd /usr/src/kodekloudrepos/blog


git log --oneline



git revert HEAD -m 1


git commit --amend -m "revert blog"


git log --oneline
