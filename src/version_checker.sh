#!/bin/bash

PLUGINS=version_results/plugins.txt
UPDATES=version_results/updated_plugins.txt

APPLICATION=$(echo $1 | cut -f1 -d":");
LOCAL_VERSION_NUMBER=$(echo $1 | cut -f2 -d":");
VERSION=$(curl -s https://plugins.jenkins.io/$APPLICATION | grep -o "\w*http://updates.jenkins-ci.org/download/plugins/$APPLICATION/\w......")
LATEST_VERSION_NUMBER=$(echo $VERSION | egrep -o "([0-9]{1,}\.)+[0-9]{1,}")

if [[ $LOCAL_VERSION_NUMBER == $LATEST_VERSION_NUMBER ]]; then
  # add result to plugins.txt file
  echo "  - $APPLICATION:$LOCAL_VERSION_NUMBER" >> $PLUGINS
  # show result to user
  echo "  - $APPLICATION:$LOCAL_VERSION_NUMBER"
else
  # add result to plugins.txt file
  echo "  - $APPLICATION:$LATEST_VERSION_NUMBER" >> $PLUGINS
  # show result to user
  echo "  - $APPLICATION:$LATEST_VERSION_NUMBER"

  # create file that shows which plugins have available updates
  echo "$APPLICATION from $LOCAL_VERSION_NUMBER to $LATEST_VERSION_NUMBER" >> $UPDATES
  echo "https://plugins.jenkins.io/$APPLICATION" >> $UPDATES
  echo '' >> $UPDATES
fi


# To avoid adding to existing files, empty the version_checker folder with:
# [ -d "version_results" ] && rm version_results/*
#----
# This for loop will pull the most current jenkins plugins from the jenkins configmap in the pipeline namespace and apply this bash script to each.
#for item in $(printf $(kubectl get cm jenkins -n pipeline -o json | jq '.data["plugins.txt"]') | tr -d '"'); do ./version_checker.sh $item; done
#---
