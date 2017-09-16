#!/bin/sh

#echo "This script will do the required setup to run the automation"
# echo "do you want to continue? (y/n)"
# read continue
# echo "you entered $continue"


#########################################
# xcode command line tools
#########################################
echo "checking for xcode command line tools"
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
  echo "xcode command line tools are already installed"
else
  echo "xcode command line tools not installed, installing";
  xcode-select --install
fi
