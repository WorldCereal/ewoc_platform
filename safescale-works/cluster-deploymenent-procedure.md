
# 1) Add SSH key on Github
 - go to https://github.com/settings/profile and add your public ssh key.

Helpfull link:
     https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
# 2) Go to AWS host
## 2.1) Copy world-cereals-fra.pem in your .ssh directory
    - go to https://odin.si.c-s.fr/plugins/git/worldcereal/EWoC?a=tree&hb=f7d6dd768e6aefc3ec39e3b359189c2565b795ae&f=Credentials and 
    - download world-cereals-fra.pem
    - copy the file in ~/.shh
## 2.2) connect to aws host
```
ssh -i ~/.ssh/world-cereals-fra.pem ubuntu@ec2-3-121-159-137.eu-central-1.compute.amazonaws.com
```

## 2.3) choice user for using Safescale 
On WorldCereal we have 2 Safescale's user:

- ewoc-prod for prod's cluster
- ewoc-test for test's cluster

Command example for using an user:
```
sudo -s
su - ewoc-prod
```

# 3) Git clone ewoc_platform project

git clone -b develop git@github.com:WorldCereal/ewoc_platform.git 

# 4) Set & run deploiment script 

## 4.1) set env variable

In deployment-script.sh, we setting some env variable required for the deployement, currently for 'prod' & 'test" cluster we defined they variables:
```
export CLUSTER=ewoc-prod
export HOSTNAME=prod.esa-worldcereal.org
export EXTERNAL-IP=185.178.84.50
```
So for any update it's here.

## 4.2) run script

```
./deployment-script.sh
```

# 5) Deploy only one component

For deploy an only component with makefile command like "deploy" you need to export env variables.
## 5.1) export env variables
```
source export-env.sh
```

## 5.2) deploy your component with make
go to you component directory, by example:
```
cd kong 
make deploy
```