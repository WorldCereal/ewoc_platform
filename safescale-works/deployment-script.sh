#!/bin/bash

# rm ewoc_platform repo
EWOCREPO=ewoc_platform/
cd ../
if ! [ -d "$EWOCREPO" ] ; then 
    echo "$EWOCREPO directory missing, you must git clone ewoc_platform project before running the script."
    exit 0 
fi

cd $EWOCREPO

# Set env variables
. ./export-env.sh


make build
make deploy
