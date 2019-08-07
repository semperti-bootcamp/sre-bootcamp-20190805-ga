pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        } 
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
    }

    stages {
        stage('Configure') {
            steps {
                sh "echo STAGE1"
            }
        }
        stage('Unit Test') {
            steps {
                sh "echo TEST1"
            }
        }
        stage('Snapshot') {
            steps {
                sh "echo SNAPSHOT"
            }
        }
        stage('Release') {
            steps {
                sh "echo RELEASE"
            }
        }
        stage('Upload Artifact to Nexus') {
            steps {
                sh "echo NEXUS"
            }
        }
        stage('Docker images') {
            steps {
                sh "echo DOCKER"
            }
        }
    }
}
