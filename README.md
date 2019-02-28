# Jenkins plugins version checker
---
This script is for the ops engineer running jenkins in a kubernetes cluster and using a configmap named "jenkins" for configuration details. It also assumes that jenkins (and its configmap) are living in a namespace named 'pipeline'  

This script will get the plugins in the current jenkins configuration and look for a newer version for each at https://plugins.jenkins.io/.  

It will output a list in yaml format to std.out that can be copy/pasted into the spec file for the jenkins configmap under "plugins", as well as making a plugins.txt file with the same list in a folder "jenkins_plugins_versions_<YYYY-MM-DD>" folder which it will create. Also inside this folder will be a "updated_plugins.txt" file with information on the plugins that were updated, and links to the new versions for further research.

Running `bash run_version_checker.sh` will create a folder named "jenkins_plugins_versions_<date>"
