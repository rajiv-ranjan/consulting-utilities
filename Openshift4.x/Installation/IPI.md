Master KCS for trouble shooting. https://access.redhat.com/articles/4217411

* Do not use us-east-1. See trap 001
* Do not use ap-south-1. See trap 002
* Do not use unverified aws region. See trap 003
* To kill the ssh-agent and restart
killall ssh-agent; eval `ssh-agent -s`

### Traps
The common issues that I faced:
* 001 - Installation triggered for us-east-1 needs to increase the [EIP limits](https://docs.openshift.com/container-platform/4.1/installing/installing_aws/installing-aws-account.html#installation-aws-limits_installing-aws-account) . Increase if your architecture needs it by filling up the form in AWS.
* 002 - Installation in region ap-south-1 doesn't have m4.large hence the installation will fail at the time of writing this doc. 
* 003 - Make sure the user account used for the installation are allowed to create resources in the region. I had verified access to us-east-1 (N Verginia), ap-south-1 (Mumbai) & ap-southeast-2 (Sydney). I tried installation against region ap-southeast-1 and failed.
* 