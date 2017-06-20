#!/usr/bin/env bash

read -e -p "Enter base branch name: " -i "HEAD" base
echo OK, base branch set to ${base}.
echo

read -e -p "Enter branches list specifier: " -i "git branch | grep -v \\\* | grep -v master | grep -v development" lister

read -e -p "Search Github for pull requests? (y/N): " github
if [[ ${github} =~ ^[Yy] ]]
then
    echo Ok, each branch will be searched for pull request state using Github API.
    echo You need to provide credentials if you want to check branches from private repos
    echo or they will be incorrectly marked as not having pull requests associated.

    read -e -p "Github login or token (optional): " login
    read -e -p "Github password (optional): " password
    echo
fi

lines=40
for branch in $(eval ${lister}); do
    if [[ ${github} =~ ^[Yy] ]]
    then
        echo ----------------------------------------------
        echo Branch ${branch} Github search results:
        echo ----------------------------------------------
        python git-is-merged.py ${branch} --login_or_token=${login} --password=${password}
        echo
    fi

    echo ----------------------------------------------
    echo Branch ${branch} summary \(first ${lines} lines\):
    echo ----------------------------------------------
    git --no-pager whatchanged --name-only --oneline --color=always master..${branch} | head -n ${lines}
    echo
    read -p "Delete branch ${branch}? (y/N): " -n 1 -r
    clear
    if [[ $REPLY =~ ^[Yy] ]]
    then
        git branch -D ${branch}
    else
        echo Branch ${branch} left intact
    fi
    echo
done
