pipeline {
    agent none
    environment {
            registry = "nevermyuk/capstone"
            registryCredential = 'dockerhub'
            dockerImg = ''
	    }
    stages {    
        stage('Lint dockerfile') {
            agent any
            steps {
                sh 'hadolint Dockerfile'
            }
        }
        stage('Build') {
            agent { dockerfile true }
            steps {
                echo 'Building!'
            }
        }
        stage('Linting python') {
            agent { dockerfile true }
            steps {
                echo 'Linting..'
                sh 'pylint --disable=R,C,W1203,W1202 app/*.py'

            }
        }
        stage('Test'){
            agent { dockerfile true }
            steps {
                echo 'Testing...'
            }
            post {
                always {
                    echo 'Unit test....'
                }
            }
        }     
        stage('Deploy Image') {
            agent { label 'master' }
            steps {
                echo 'Deploying...'
                script {
                    dockerImg =docker.build repo+":$BUILD_NUMBER"
                    docker.withRegistry( '', registryCredential) {
                        dockerImg.push()
                    }
                    sh 'docker rmi $repo:$BUILD_NUMBER'
                    }
            }
        }
        stage('Security Scan') {
            agent any
            steps { 
                 aquaMicroscanner imageName: 'nevermyuk/capstone', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
              }
         }  
    }
}