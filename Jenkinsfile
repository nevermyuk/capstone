pipeline {
    agent none
    environment {
            repository = "nevermyuk/capstone"
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
        stage('Linting python') {
            agent { dockerfile true }
            steps {
                echo 'Linting..'
                withEnv(['PYLINTHOME=.']) {
                    sh "pylint --disable=R,C,W1203,W1202 --output-format=parseable --reports=no app/*.py"
                }
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
        stage('Build Image') {
            agent { label 'master' }
            steps {
                echo 'Building...'
                script {
                    dockerImg = docker.build repository + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push Image to Dockerhub') {
            agent { label 'master' }
            steps {
                echo 'Deploying...'
                script {
                    docker.withRegistry( '', registryCredential) {
                        dockerImg.push()
                        dockerImg.push("development")
                    }
                }
            }
        }
        stage('Security Scan') {
            agent { label 'master' }
            steps {
                aquaMicroscanner imageName: 'nevermyuk/capstone', notCompliesCmd: 'exit 4', onDisallowed: 'ignore', outputFormat: 'html'
            }
        }
        stage('Deploy - Development') {
            agent { label 'master' }
            steps {
                build job: 'eks-dev'
            }
        }
        stage('Removed docker image') {
            agent { label 'master'}
            steps {
                echo 'Clearing up our mess..'
                sh 'docker rmi $repository:$BUILD_NUMBER'
            }
        }
    }
}