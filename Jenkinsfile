pipeline {
    agent
    environment {
    DOCKER_IMAGE_NAME = "nevermyuk/capstone"
	    }
    stages {    
        stage('Build') {
            agent { dockerfile true}
            steps {
                echo 'Building!'
            }
        }
        stage('Test') {
            agent any
            steps {
                echo 'Testing..'
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