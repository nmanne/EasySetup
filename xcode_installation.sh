#!/bin/bash


function check_xcode_installation() {
  echo "checking for xcode command line tools ...."
  if type xcode-select &>/dev/null;
  then
    return 0
  else
    return 1
  fi
}

function agree_xcode_terms() {
  if sudo xcodebuild -license accept &>/dev/null; then
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
