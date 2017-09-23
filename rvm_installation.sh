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
