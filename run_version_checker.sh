#!/bin/bash

# make version_results folder if it doesn't exist, or empty version_results folder if it does
[ ! -d "version_results" ] && mkdir version_results || rm -f version_results/*

# grab the currently used jenkins plugins from a jenkins configmap in a pipeline namespace, then pass each plugin to the version_checker.sh script
for item in $(printf $(kubectl get cm jenkins -n pipeline -o json | jq '.data["plugins.txt"]') | tr -d '"'); do ./src/version_checker.sh $item; done
