#!/bin/bash

function check_rvm_installation() {
   echo "===> checking rvm installation "
   if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
   	  return 0
     # result=$( type ~/.rvm/scripts/rvm | head -1 )
#      echo "$result"
#    	 if [ "$result" = "rvm is a function" ]; then
#         return 0
#      else
#         return 1
#      fi
   else
     return 1
   fi
}

function is_rvm_path_setup_in_profile() {
	if type rvm &>/dev/null; then
		return 0
	else
		return 1
	fi
}

function setup_rvm_path_in_profile() {
	echo "setting-up RVM path in profile"
	if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
		echo '. $HOME/.rvm/scripts/rvm # Load RVM function' >> ~/.bash_profile
		source ~/.bash_profile
	fi
}

function install_rvm() {
  echo "===> installing rvm"
  curl -sSL https://get.rvm.io | bash -s stable
  setup_rvm_path_in_profile
}


function is_ruby_installed() {
  if type ruby &>/dev/null; then
		return 0
	else
		return 1
	fi
}

function is_ruby_version_installed() {
  required_ruby_version=$(echo $RUBY_INSTALL_VERSION | tr -d ' .-')
  existing_versions=$(echo $(rvm list) | tr -d ' .-')
  if [[ "$existing_versions"==*"$required_ruby_version"* ]]; then
    return 0
  else
    return 1
  fi
}

function is_correct_ruby_version_in_use() {
  required_ruby_version=$(echo $RUBY_INSTALL_VERSION | tr -d ' .-')
  current_ruby_version=$(echo $(ruby --version) | tr -d ' .-')
  if [[ "$current_ruby_version"==*"$required_ruby_version"* ]]; then
    return 0
  else
    return 1
  fi
}

function install_ruby() {
  rvm install $RUBY_INSTALL_VERSION
}

function use_correct_ruby_version() {
  rvm use $RUBY_INSTALL_VERSION
}

function install_ruby_and_use_the_version() {
  install_ruby
  if !is_ruby_version_installed; then
    echo "failed to install ruby version $RUBY_INSTALL_VERSION"
    exit 1
  fi
  use_correct_ruby_version
}

function make_sure_ruby_is_setup() {
  if is_ruby_installed; then
    if is_ruby_version_installed; then
      if is_correct_ruby_version_in_use; then
        echo "correct ruby version in use"
      else
        use_correct_ruby_version
      fi
    else
      install_ruby_and_use_the_version
    fi
  else
    install_ruby_and_use_the_version
  fi


  #  required_ruby_version=$(echo $RUBY_INSTALL_VERSION | tr -d ' .-')
  #  actual_ruby_version=$(echo $RUBY_VERSION | tr -d ' .-')
  #  echo "actual ruby version: $actual_ruby_version"
  #  if [[ "$actual_ruby_version" == *"$required_ruby_version"* ]]; then
  #    echo "required ruby version $RUBY_INSTALL_VERSION is already installed and it is set to use"
  #  else
  #    existing_versions=$(echo $(rvm list) | tr -d ' .-')
  #    if [[ "$existing_versions"==*"$required_ruby_version"* ]]; then
  #      set_ruby_version
  #    else
  #      echo "installing ruby version $RUBY_INSTALL_VERSION"
  #      rvm install $RUBY_INSTALL_VERSION
   #
  #    fi
    #  echo "required version:$RUBY_INSTALL_VERSION"
    #  echo "existing version:$existing_versions"
    #  echo "required version:$required_ruby_version"
  #
}
