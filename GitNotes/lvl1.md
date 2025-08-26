The Nautilus development team has provided requirements to the DevOps team for a new application development project, specifically requesting the establishment of a Git repository. Follow the instructions below to create the Git repository on the Storage server in the Stratos DC:



Utilize yum to install the git package on the Storage Server.


Create a bare repository named /opt/news.git (ensure exact name usage).


```bash
mkdir -p /opt/news.git
```


```bash
git init --bare /opt/news.git
```

verify:
expected output: True
```bash
 git --git-dir=/opt/news.git rev-parse --is-bare-repository
```



git clone <git repo>



There is a Git server utilized by the Nautilus project teams. Recently, a new developer named Jon joined the team and needs to begin working on a project. To begin, he must fork an existing Git repository. Follow the steps below:



Click on the Gitea UI button located on the top bar to access the Gitea page.


Login to Gitea server using username jon and password Jon_pass123.


Once logged in, locate the Git repository named sarah/story-blog and fork it under the jon user.


Note: For tasks requiring web UI changes, screenshots are necessary for review purposes. Additionally, consider utilizing screen recording software such as loom.com to record and share your task completion process.



simple just don't for get to sudo git push



4. On the Storage server in Stratos DC, delete a branch named xfusioncorp_media from the /usr/src/kodekloudrepos/media Git repository.

<switch to another branch b4 deleting>




The Nautilus development team shared with the DevOps team requirements for new application development, setting up a Git repository for that project. Create a Git repository on Storage server in Stratos DC as per details given below:



Install git package using yum on Storage server.


After that, create/init a git repository named /opt/games.git (use the exact name as asked and make sure not to create a bare repository).
```bash
sudo mkdir -p /opt/games.git
cd /opt/games.git
sudo git init
```



