#!/bin/sh
RUBY_INSTALL_VERSION="ruby-2.0.0-p648"
BUNDLER_VERSION="1.11.2"

source ./xcode_installation.sh
source ./rvm_installation.sh

#echo "This script will do the required setup to run the automation"
# echo "do you want to continue? (y/n)"
# read continue
# echo "you entered $continue"

if [[ -z $CUCUMBER_FOLDER ]]; then
  echo "CUCUMBER_FOLDER not set"
  return 1
fi

if [ ! -f $CUCUMBER_FOLDER/Gemfile_Ruby20 ]; then
  echo “could not find the Gemfile_Ruby20 file”
  return 1
fi

echo ‘———— Checking Xcode —————’
if check_xcode_installation; then
  echo "xcode command line tools are already is installed $(type xcode-select)"
else
  echo "xcode command line tools are not installed, installing it...."
  install_xcode
fi

echo ‘———— Checking RVM installation ————’
if ! check_rvm_installation; then
  echo "RVM is not installed, instaiing it..."
  install_rvm
  if check_rvm_installation; then
     echo "RVM installation is successful..."
  else
     echo "RVM installation is not successful.."
     exit 1
  fi
else
  echo “RVM is already installed, moving to next step…”
fi


make_sure_ruby_is_setup

echo ‘———— Checking Bundler ————’
if ! check_bundler_installation; then
  if ! install_bundler; then
    if reinstall_ruby; then
      install_bundler
    fi
  fi
fi

if ! check_bundler_installation; then
    echo "Bundler installation is failed, exit setup process....."
fi


