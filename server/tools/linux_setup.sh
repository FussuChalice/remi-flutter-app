#!/bin/sh

check_root_user() {
  if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root. Please run with sudo or as root user."
    exit 1
  fi
}

check_internet_connection() {
  if ping -q -c 1 -W 1 google.com >/dev/null; then
    echo "Internet connection is available."
  else
    echo "Internet connection is not available."
    exit 1
  fi
}

check_curl_installed() {
  if ! [ -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed.' >&2
    echo 'Installing curl now...' >&2
    sudo apt-get update
    sudo apt-get install curl -y
  else
    echo 'curl is already installed.'
  fi
}

check_and_install_node() {
  if ! [ -x "$(command -v node)" ]; then
    echo 'node.js is not installed. Installing now...' >&2
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    echo 'node.js is already installed.'
  fi
}

check_and_install_python() {
  if ! [ -x "$(command -v python)" ]; then
    echo 'Python is not installed. Installing now...' >&2
    sudo apt-get update
    sudo apt-get install -y python
  else
    echo 'Python is already installed.'
  fi
}

main() {

    # Check things for correct work server
    check_root_user
    check_internet_connection
    check_curl_installed
    check_and_install_node
    check_and_install_python

    cd ..
    mkdir logs

    npm install

    cd  ./assets/js

    mkdir libs
    cd libs

    curl -LO "https://code.jquery.com/jquery-3.6.4.min.js"
    curl -LO "https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"
    curl -LO "https://github.com/js-cookie/js-cookie/releases/download/v3.0.1/js.cookie.min.js"

    cd ..
    cd ..

    cd ./css/libs/
    curl -LO "https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css"

    cd ..
    cd ..
    cd ..

    echo "Server setuped"

}
