pipeline {
    agent none
    environment {
    DOCKER_IMAGE_NAME = "nevermyuk/capstone"
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
                sh 'pylint --disable=R,C,W1203,W1202 *.py'

            }
        }
        stage('Deploy') {
            agent any
            steps {
                echo 'Deploying....'
            }
        }
    }
}