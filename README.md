# Clean git branches

Allows to iterate over git branches list, search each of them for pull requests created on Github and delete by confirmation.

These was done to clear local branches list when Github's `squash and merge` method used on pull requests — merges are mot detected automatically.

You need python 2.7+ and `pip install PyGitHub`.

NB for Python 2.7 on Centos 6.5: `yum install python2.7` and then `scl enable python27 bash` will launch bash with `python` aliased to 2.7 version. 

Example usage:
```
bash-4.1$ ./clean-git-branches.sh
Enter base branch name: HEAD
OK, base branch set to HEAD.

Enter branches list specifier: git branch | grep -v \\* | grep -v master | grep -v development
Search Github for pull requests? (y/N): y
Ok, each branch will be searched for pull request state using Github API.
You need to provide credentials if you want to check branches from private repos
or they will be incorrectly marked as not having pull requests associated.
Github login or token (optional): b1rdex
Github password (optional):

----------------------------------------------
Branch 2048-https Github search results:
----------------------------------------------
All pull requests for 4b01d15fccea81cac52032297580e387a1b8c156 are open.
Found results:
https://github.com/andreyvlru/dev.100sp/pull/902

----------------------------------------------
Branch 2048-https summary (first 40 lines):
----------------------------------------------
4b01d15 wip
email-templates/src/pages/delivery-group-bill.html
email-templates/src/pages/delivery-group-delay.html
email-templates/src/pages/delivery-group-detach.html
protected/components/CityUrlRule.php
protected/components/SHtml.php
protected/components/UrlManager.php
protected/config/base.php
protected/controllers/DeliveryGroupsController.php
protected/controllers/MegaorderController.php
protected/themes/default/views/megaorder/groupDelivery.php
src/WebApplication.php
src/Yii/UrlManager.php

Delete branch 2048-https? (y/N): n
Branch 2048-https left intact

```
