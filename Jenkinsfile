#!groovy

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
	VERSION = "4.0.5"
    }

    stages {
        stage('Configure') {
            steps {
                sh "echo STAGE1 - Tasks pre Test"
		sh "echo -n 'Version : ' ; echo $env.VERSION"
            }
        }
        stage('Unit Test') {
            steps {
                sh "mvn test -f Code/pom.xml"
            }
        }
        stage('Release & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=$env.VERSION -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Snapshot & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=$env.VERSION-SNAPSHOT -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Docker build & tag images') {
            steps {
		withCredentials([file(credentialsId: 'ga-docker-hub', password: 'PASS', username: 'USER')]) {
			sh "sudo docker build --rm=true --no-cache --force-rm --tag journal:$env.VERSION ."
			sh "sudo docker tag journal:$env.VERSION $USER/journal:$env.VERSION"
			sh "sudo docker login -u $USER -p $PASS docker.io"
			sh "sudo docker push $USER/journal:$env.VERSION"
		} 
            }
        }
    }
}
