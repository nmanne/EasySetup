#!/bin/sh
RUBY_INSTALL_VERSION="ruby-2.0.0-p648"
RUBY_GEMS_VERSION="2.1.11"

source ./xcode_installation.sh
source ./rvm_installation.sh

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

if check_rvm_installation; then
  echo "RVM is already installed"
  if ! is_rvm_path_setup_in_profile; then
  	setup_rvm_path_in_profile
  fi
else
  echo "RVM is not installed, instaiing it..."
  install_rvm
  if check_rvm_installation; then
     echo "RVM installation is successful..."
  else
     echo "RVM installation is not successful.."
     exit 1
  fi
fi

make_sure_ruby_is_setup
