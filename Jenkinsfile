#!groovy

def lastCommitInfo = ""
def skippingText = ""
def commitContainsSkip = 0
def slackMessage = ""
def shouldBuild = false

def pollSpec = "" 

if(env.BRANCH_NAME == "master") {
    pollSpec = "*/5 * * * *"
} else if(env.BRANCH_NAME == "test") {
    pollSpec = "* * * * 1-5"
}

pipeline {
    agent any

    options {
        ansiColor("xterm")
    }
 
    triggers {
        pollSCM ignorePostCommitHooks: false, scmpoll_spec: pollSpec
    }

    stages {
        stage('Init') {
            steps {
                script {
                    lastCommitInfo = sh(script: "git log -1", returnStdout: true).trim()
                    commitContainsSkip = sh(script: "git log -1 | grep '.*\\[skip ci\\].*'", returnStatus: true)

                    if(commitContainsSkip == 0) {
                        skippingText = "Skipping commit."
                        env.shouldBuild = false
                        currentBuild.result = "NOT_BUILT"
                    }

                    slackMessage = "*${env.JOB_NAME}* bjdsk *${env.BRANCH_NAME}* received a new commit. ${skippingText}\nHere is commmit info: ${lastCommitInfo}"
                }
            }
        }

        stage('Send info to Slack') {
            steps {
                sh "/usr/local/bin/fastlane sendInfoToSlack message:\"${slackMessage}\" slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\""
            }
        }

        /********* Keychain *********/

        stage('Reinitialize jenkins keychaix') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                sh "/usr/local/bin/fastlane refreshJenkinsKeychain"
            }
        }

        stage('Populate Jenkins Keychain') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                sh "/usr/local/bin/fastlane matchPopulateJenkinsKeychain"
            }
        }

        /********* Testing *********/

        stage('Run Unit and UI Tests') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                script {
                    try {
                        sh "/usr/local/bin/fastlane runTests slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\"" 
                    } catch(exc) {
                        //  echo "Uhvacen exception ${exc}"
                        currentBuild.result = "FAILURE"
                        // throw exc
                        error('There are failed tests.')
                        throw exc
                    }
                }
            }
        }

        /********* Building *********/

        // stage('Install Pods') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false"
        //         }
        //     }
        //     steps {
        //         // sh "pod install --deployment --repo-update"
        //         sh "fastlane cocoapods"
        //     }
        // }

        // stage('Build application for beta') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false"
        //         }
        //     }
        //     steps {
        //         // Steps for beta build
        //     }
        // }

        /********* Deploying *********/

        stage('Deploy to beta') {
            when {
                branch 'development'
                // expression {
                //     return env.shouldBuild != "false" 
                // }
            }
            steps {
                sh "/usr/local/bin/fastlane beta slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}"
            }
        }

        // stage('Build application for prod') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false" && env.BRANCH_NAME == "master"
        //         }
        //     }
        //     steps {
        //         // Build steps to build application for prod
        //     }
        // }

        // stage('Send to Prod') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false" && env.BRANCH_NAME == "master"
        //         }
        //     }
        //     steps {
        //         // Steps to deploy application to prod
        //     }
        // }

        /********* Infirming *********/

        stage('Inform Slack for success') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                slackSend color: "good", message: "*${env.JOB_NAME}* *${env.BRANCH_NAME}* job is completed successfully"
            }
        }
    }

    post {
        failure {
            slackSend color: "danger", message: "*${env.JOB_NAME}* *${env.BRANCH_NAME}* job is failed"
        }
        unstable {
            slackSend color: "danger", message: "*${env.JOB_NAME}* *${env.BRANCH_NAME}* job is unstable. Unstable means test failure, code violation etc."
        }
    }
}