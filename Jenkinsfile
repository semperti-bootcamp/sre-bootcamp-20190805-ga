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
                sh "mvn test -f Code/pom.xml"
            }
        }
        stage('Release & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=4.0.3 -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Snapshot & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=4.0.3-SNAPSHOT -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Docker build & tag images') {
            steps {
                sh "sudo docker build --rm=true --no-cache --force-rm --tag journal:4.0.3 ."
                sh "sudo docker tag journal:4.0.3 gonzaloacosta/journal:4.0.3"
            }
        }
    }
}
