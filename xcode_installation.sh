#!/bin/bash


function check_xcode_installation() {
  echo "checking for xcode...."
  if type xcode-select &>/dev/null;
  then
    return 0
  else
    return 1
  fi
}

function agree_xcode_terms() {
  if xcodebuild -license accept &>/dev/null; then
    echo "agreed xcode license."
  else
    echo "failed to agreed xcode license"
    exit 1
  fi
}

function install_xcode() {
  xcode-select --install &>/dev/null
  STATUS_CODE=$?
  echo "xcode installation is complete, verifying it..."
  #echo "status $STATUS_CODE"
  if [ $STATUS_CODE -ne 0 ]; then
    echo "xcode installation failed"
    exit 1
  else
    echo "verification complete. xcode is installed."
  fi
}

#if type xcode-select >/dev/null 2>&1;
#if type xcode-select &>/dev/null;
# if type xcode-select &>/dev/null;
# then
#   echo "xcode already is installed $(type xcode-select)"
#   xcodebuild
# else
#   echo "xcode is not installed, installing it...."
#   xcode-select --install &>/dev/null
#   STATUS_CODE=$?
#   echo "xcode installation is complete, verifying it..."
#   #echo "status $STATUS_CODE"
#   if [ $STATUS_CODE -ne 0 ]; then
#     echo "xcode installation failed"
#   else
#     echo "verification complete. xcode is installed."
#   fi
# fi

if check_xcode_installation; then
  echo "xcode already is installed $(type xcode-select)"
  agree_xcode_terms
else
  echo "xcode is not installed, installing it...."
  install_xcode
  agree_xcode_terms
fi
