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
                withEnv(['PYLINTHOME=.']) {
                    //sh 'pylint --disable=R,C,W1203,W1202 app/*.py'
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
        stage('Deploy Image') {
            agent { label 'master' }
            steps {
                echo 'Deploying...'
                script {
                    dockerImg = docker.build repository+":$BUILD_NUMBER"
                    docker.withRegistry( '', registryCredential) {
                        dockerImg.push()
                    }
                    sh 'docker rmi $repository:$BUILD_NUMBER'
                    }
            }
        }
    }
}