#!/bin/sh

set -e


if ! command -v ansible-playbook > /dev/null; then
    echo "ansible-playbook not found, please install ansible."
    exit 1
fi


if [ "x$1" = "x" ]; then
    echo "home path not specified as parameter, using ${HOME}"
    USER_HOME=${HOME}
else
    USER_HOME="$1"
fi


if [ "x${USER_HOME}" = "x" ]; then
    echo "User home path not specified, aborting."
    exit 1
fi


REPO_PATH="$(dirname $(realpath $0))"


echo "user home: ${USER_HOME}"
echo "repo path: ${REPO_PATH}"
echo -n "correct? (y/n): "
read RESPONSE

if [ "x${RESPONSE}" = "xy" ]; then
    ansible-playbook \
        --inventory /dev/null \
        --connection=local \
        --extra-var HOME_PATH="${USER_HOME}" \
        --extra-var REPO_PATH="${REPO_PATH}" \
        dotfiles.yaml
fi
