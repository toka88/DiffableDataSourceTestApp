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

/* Abort Jenkins if there is a new commit. */
def buildNumber = env.BUILD_NUMBER as int
if (buildNumber > 1) milestone(buildNumber - 1)
milestone(buildNumber)  

pipeline {
    agent any

    environment {
        // Fastlane Environment Variables
        PATH = "$HOME/.fastlane/bin:" +
                "$HOME/.rvm/gems/ruby-2.5.3/bin:" +
                "$HOME/.rvm/gems/ruby-2.5.3@global/bin:" +
                "$HOME/.rvm/rubies/ruby-2.5.3/bin:" +
                "/usr/local/bin:" +
                "/usr/bin/env:" +
                "$PATH"
        LC_ALL = "en_US.UTF-8"
        LANG = "en_US.UTF-8"
    }

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

                    slackMessage = "*${env.JOB_NAME}* *${env.BRANCH_NAME}* received a new commit. ${skippingText}\nHere is commmit info: ${lastCommitInfo}"
                }
            }
        }

        /********* Testing *********/

        stage('Validate code with Danger') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                sh "bundle exec danger"
            }
        }

        // stage('Validate code with SwiftLint') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false"
        //         }
        //     }
        //     steps {
        //         sh "fastlane runSwiftLint slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\" build_url:\"${env.BUILD_URL}\""
        //     }
        // }

        stage('Run Unit and UI Tests') {
            when {
                expression {
                    return env.shouldBuild != "false"
                }
            }
            steps {
                script {
                    try {
                        sh "fastlane runTests slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\" build_url:\"${env.BUILD_URL}\"" 
                    } catch(exc) {
                        currentBuild.result = "FAILURE"
                        error('There are failed tests.')
                        throw exc
                    }
                }
            }
        }

        /********* Keychain *********/

        // stage('Reinitialize jenkins keychain') {
        //     when {
        //         anyOf { 
        //             branch "master";
        //             branch "development"
        //         }
        //     }
        //     steps {
        //         sh "fastlane refreshJenkinsKeychain"
        //     }
        // }

        // stage('Populate Jenkins Keychain') {
        //     when {
        //         anyOf { 
        //             branch "master";
        //             branch "development"
        //         }
        //     }
        //     steps {
        //         sh "fastlane matchPopulateJenkinsKeychain"
        //     }
        // }

        /********* Deploying *********/

        stage('Deploy to beta') {
            when {
                branch "development"
            }
            steps {
                sh "fastlane beta slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\""
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

        /********* Informing *********/

        // stage('Inform Slack for success') {
        //     when {
        //         expression {
        //             return env.shouldBuild != "false"
        //         }
        //     }
        //     steps {
        //         sh "fastlane sendInfoToSlack slack_url:\"${env.TEST_PROJECT_SLACK_WEBHOOK}\" message:\"*${env.JOB_NAME}* *${env.BRANCH_NAME}* job is completed successfully\""
        //     }
        // }
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