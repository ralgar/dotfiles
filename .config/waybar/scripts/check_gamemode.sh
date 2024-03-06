#!/bin/sh

if ! which gamemoded ; then
    exit 0
fi

if gamemoded -s | grep inactive > /dev/null 2>&1 ; then
    exit 0
else
    exit 1
fi
