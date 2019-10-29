#!/usr/bin/env bash

# This script allows you to easily and quickly generate and deploy your website
# using Hugo to your personal GitHub Pages repository. This script requires a
# certain configuration, run the `setup.sh` script to configure this. See
# https://hjdskes.github.io/blog/deploying-hugo-on-personal-github-pages/index.html
# for more information.

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# GitHub username.
USERNAME=williamlfang
# Name of the branch containing the Hugo source files.
SOURCE=betteR
# The commit message.
MESSAGE="Gitbook rebuild $(date)"

## -------------------------------------------
msg() {
    printf "\033[1;32m :: %s\n\033[0m" "$1"
}
## -------------------------------------------


## -------------------------------------------
msg "Pulling down from ${SOURCE}"
git pull
## -------------------------------------------


## -------------------------------------------
msg "Rebuild gitbook"
## 安装插件
# /opt/node-v12.10.0-linux-x64/bin/gitbook install ./
## 建立静态网页
/opt/node-v12.10.0-linux-x64/bin/gitbook build
## -------------------------------------------


## -------------------------------------------
msg "Pushing new info to Github"

git add -A 
git commit -m "$MESSAGE"
git push

msg "We've happily done."
