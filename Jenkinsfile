#!groovy

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
	VERSION = "4.0.6"
    }

    stages {
        stage('Configure') {
            steps {
                sh "echo STAGE1 - Tasks pre Test and build"
		sh "echo -n 'Version : ' ; echo $env.VERSION"
		sh "sed -i -e 's/VERSION/$VERSION/g' Dockerfile"
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
		withCredentials([usernamePassword(credentialsId: 'ga-docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {	
			sh "sudo docker build --rm=true --no-cache --force-rm --tag journal:$env.VERSION ."
			sh "sudo docker tag journal:$env.VERSION $USER/journal:$env.VERSION"
			sh "sudo docker login -u $USERNAME -p $PASSWORD docker.io"
			sh "sudo docker push $USERNAME/journal:$env.VERSION"
		} 
            }
        }
    }
}
