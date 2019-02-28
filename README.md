# Jenkins plugins version checker
---
Running the for-loop below will grab the currently used jenkins plugins from a jenkins configmap in a pipeline namespace, then pass each plugin to the version_checker.sh script which will look for the newest plugin version from https://plugins.jenkins.io/. The script will create a "version_results" folder if one doesn't exist and print out a copy/pastable list to stdout to add to the jenkins configmap in yaml format, as well as make a plugins.txt file in yaml format, as well as create a summary of the plugins that have available updates; both in the version_results folder.  

```
[ -d "version_results"] && rm version_results/*

for item in $(printf $(kubectl get cm jenkins -n pipeline -o json | jq '.data["plugins.txt"]') | tr -d '"'); do ./version_checker.sh $item; done
```  

For now, this script will only add to the plugins.txt and updated_plugins.txt files in a version_results folder (which it creates), hence the business above the for-loop about checking for a folder and deleting its contents.
