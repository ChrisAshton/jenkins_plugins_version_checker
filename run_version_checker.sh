#!/bin/bash

export DATE=`date +%Y-%m-%d`

# make jenkins_plugins_versions_<today's date> folder if it doesn't exist, or empty version_results folder if it does
[ ! -d "jenkins_plugins_versions_$DATE" ] && mkdir jenkins_plugins_versions_$DATE || rm -f jenkins_plugins_versions_$DATE/*

# grab the currently used jenkins plugins from a jenkins configmap in a pipeline namespace, then pass each plugin to the version_checker.sh script
for item in $(printf $(kubectl get cm jenkins -n pipeline -o json | jq '.data["plugins.txt"]') | tr -d '"'); do ./src/version_checker.sh $item; done
