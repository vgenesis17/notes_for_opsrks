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