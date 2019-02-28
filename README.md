# Jenkins plugins version checker
---
This script is for the ops engineer running jenkins in a kubernetes cluster and using a configmap named "jenkins" for configuration details. It also assumes this jenkins configmap is living in a kubernetes namespace named 'pipeline'  

This script will get the plugins in the current jenkins configuration and look for a newer version for each at https://plugins.jenkins.io/.  

It will output a list, in yaml format, to std.out that can be copy/pasted into the jenkins configmap's spec file under "plugins". It will also write a plugins.txt file with the same list in a folder named "jenkins_plugins_versions_\<YYYY-MM-DD\>" which it will create. Also inside this folder will be a "updated_plugins.txt" file with information on the plugins that were updated, and links to the new versions for further research.

## Installation
To use this code, install with:

```
git clone https://github.com/ChrisAshton/jenkins_plugins_version_checker.git
```
## Operation
Run the following code in the cloned folder
```
bash run_version_checker.sh
```
