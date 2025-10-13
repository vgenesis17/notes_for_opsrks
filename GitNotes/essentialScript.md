see files committed 

git log --name-only



git reflog 






sarah (master)$ git log --name-only
commit 1457f460ec67352dfb2b2133b44d1695f042c145 (HEAD -> master)
Author: sarah <sarah@example.com>
Date:   Wed Aug 27 02:40:26 2025 +0000

    Add author info to stories

fox-and-grapes.txt
frogs-and-ox.txt
hare-and-tortoise.txt
lion-and-mouse.txt
wolf-and-goat.txt

commit 094c896cf9abf907c8c70774e8c25a2d399215af
Author: sarah <sarah@example.com>
Date:   Wed Aug 27 02:39:53 2025 +0000

    Add stories

fox-and-grapes.txt
frogs-and-ox.txt
hare-and-tortoise.txt
lion-and-mouse.txt
wolf-and-goat.txt
sarah (master)$ git reflog 
1457f46 (HEAD -> master) HEAD@{0}: commit: Add author info to stories
094c896 HEAD@{1}: commit (initial): Add stories
sarah (master)$ 
------------------------------------------


However she does not want multiple commits for the same story. She would like to squash all the commits into a single commit.

Run the command git rebase -i HEAD~3 to squash the last 3 commits into 1.

In the editor that opens, leave the first line as is, and change the second and third lines to use squash instead of pick. Then save the file. This way we pick the first commit and then squash the second and third commits to it.

In the next editor window that opens set the commit message to Add hare-and-tortoise story and save it.


sarah ((no branch, rebasing story/hare-and-tortoise))$ git rebase -i HEAD~3
fatal: It seems that there is already a rebase-merge directory, and
I wonder if you are in the middle of another rebase.  If that is the
case, please try
        git rebase (--continue | --abort | --skip)
If that is not the case, please
        rm -fr ".git/rebase-merge"
and run me again.  I am stopping in case you still have something
valuable there.

```bash
sarah ((no branch, rebasing story/hare-and-tortoise))$ git rebase --edit-todo
error: cannot 'squash' without a previous commit
sarah ((no branch, rebasing story/hare-and-tortoise))$ git rebase --continue\
> ^C
sarah ((no branch, rebasing story/hare-and-tortoise))$ git rebase --continue
Successfully rebased and updated refs/heads/story/hare-and-tortoise.
```