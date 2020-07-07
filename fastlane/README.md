fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios create_app
```
fastlane ios create_app
```
Create new app
### ios screenshot
```
fastlane ios screenshot
```

### ios sendInfoToSlack
```
fastlane ios sendInfoToSlack
```
Send custom message to slack channel
### ios refreshJenkinsKeychain
```
fastlane ios refreshJenkinsKeychain
```
Refresh Jenkins keychains
### ios matchPopulateJenkinsKeychain
```
fastlane ios matchPopulateJenkinsKeychain
```
Fetch certicifates
### ios installPods
```
fastlane ios installPods
```
Install pods.
### ios runTests
```
fastlane ios runTests
```
Run unit and ui tests
### ios createCoverageReport
```
fastlane ios createCoverageReport
```
Create coverage html
### ios beta
```
fastlane ios beta
```
Upload app to TestFlight and notify testers

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
