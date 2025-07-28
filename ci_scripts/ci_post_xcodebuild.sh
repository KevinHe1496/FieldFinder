
#! /bin/zsh

TESTFLIGHT_DIR_PATH=../TestFlight

git fetch --deepen 3 && git log -3 --pretty=format: "%s" >! $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
