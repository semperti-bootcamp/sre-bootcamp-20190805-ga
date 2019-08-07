pipeline {
    options {
        ansiColor('xterm')
    }   

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        } 
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
    }

    stages {
        stage('Prepare Jenkins Slave') {
            steps {
                sh "echo Stage1"
            }
        }
        stage('Unit Test & Package') {
            steps {
		sh "echo Stage2"
                }
            }
        }
        stage('Clean & Generate Snapshot') {
            steps {
		sh "echo Stage3"
                }
            }
        }
        stage('Release & Deploy Image to Nexus'){
            steps{
		sh "echo Stage4"
                }
            }
        }
        stage('Configure Docker Image on Docker Host') {
            steps {
		sh "sudo docker images"
                }
            }
        }
        stage('Publish Image to DTR') {
            steps {
		sh "echo DockerPull"
                }
            }
        }
    }
}
