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
                        dockerImg.push("latest")
                    }
                }
            }
        }
        stage('Removed docker image') {
            agent { label 'master'}
            steps {
                echo 'Clearing up our mess..'
                sh 'docker rmi $repository:$BUILD_NUMBER'
            }
        }
        stage('Sanity Check'){
            agent any
            steps {
                input "Does the development container look okay? Is it time to push to blue?"
            }
        }
  
        stage('Deploy - Blue') {
            agent { label 'master' }
            steps {
                    withKubeConfig([caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01EUXdPVEV3TWpFME5Gb1hEVE13TURRd056RXdNakUwTkZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTmtDClkvdG1qcWxRRmpWYmlybHZJMTNiVXhwYUZoRVJoSWVUaFh4NWJyeFZ4TjJ5aWx6Vi9EcEpCRXpaeWdaRjJ2emIKc0dKUkt0eVhtK2hBZXhFRWp2MHcvSUY0VWxHdHovcHlaRHFxRlQrN1hMQTF2L2JNVWk3MDRNK2NpbjFLaytMdApTczhDMW9Rd2ltc2VaNUZSOXRCcmZrZWh0VmZVK0UwOTlVd1hVOHc1clY4MG53UFowVnZtSFFqZmFoSWd4bVJtCnVkdm14NGh5U0JQazV1Y1JsZi9HbzhIN2dOY0RqbWFvWENiMWh2U2d0UGZ6V1JpZW10QlRsdlV4SEhzM1JvblgKVDBYamhIa214UjZ4Mmg0SnQ5bkQzOE1JRVg4YVEwT1JaU1UzRXZkM0VURTBBdkJ6dHo5UnBsNmpnV1N5akZsWQpOcFY4eElaNkw1dXI3SVZJSENrQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFMZ1d3QnVEbUxxaWxucitTaDNoVUtNb1A1VS8KNkJNMVpyYUlIU1g3UlpLNWtJa3hkNG5rcFNXbkUwSTIxcGpXREZPWkphVlg1MVRxeGZuWFl2d2N0MnNQUzk1bgo0VGVHWnRHQ3VPUnRDZDZDemE5S3lSaTh3akZuOUtCbVB6U0ZjU3RXbkZnR1VNQ2VoeFhFNDdKME56djFWZzlmClJlanh1enFtWGJhWUdROHNvSjNQZ0YxcmhnNFhVUGE1SG1CT1NRSExkSlQ2MjE0YVh6bHlDdFRZRCtBTUhKNHUKa0tzOGlTQXhOaTBzRCtJMUJjWE9DbjVkN0o5NWk1eWhXcWFnWXFNK1RTYUFnWXZYR2lSL0VBNDllaSt3NHNGRgpxRnhDTGYxQ3k4QW83UUhQb29mV3o5d25xaVFHSnNNVldodkZlWFVPdTMwZ0ZtbEtkNmtRcndidEZLWT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=', 
                                    clusterName: 'eks-demo-Cluster', 
                                    credentialsId: 'Jenkins', 
                                    serverUrl: 'https://367F1C72510883BECD696345E62FFF84.sk1.ap-southeast-1.eks.amazonaws.com']) {
                                         sh 'kubectl get pods'
                    }   
            }
        }
    }
}