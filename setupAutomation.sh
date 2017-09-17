#!/bin/sh
source ./xcode_installation.sh

#echo "This script will do the required setup to run the automation"
# echo "do you want to continue? (y/n)"
# read continue
# echo "you entered $continue"



if check_xcode_installation; then
  echo "xcode command line tools are already is installed $(type xcode-select)"
else
  echo "xcode command line tools are not installed, installing it...."
  install_xcode
fi

