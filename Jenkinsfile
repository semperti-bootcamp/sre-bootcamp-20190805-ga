#!groovy

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
	VERSION = "4.0.7"
	APP_NAME='journal'
	DOCKER_REPO='gonzaloacosta/journal'
    }

    stages {
        stage('Configure & Clean Slave') {
            steps {
                sh "echo STAGE1 - Tasks pre Test and build"
		sh "echo -n 'Version : ' ; echo $env.VERSION"
		sh "sed -i -e 's/VERSION/$VERSION/g' Dockerfile"
		sh "yum -y install wget nc"
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
        stage('Docker build, tag & push images ') {
            steps {
		withCredentials([usernamePassword(credentialsId: 'ga-docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {	
			sh "sudo docker build --rm=true --no-cache --force-rm --tag $env.APP_NAME:$env.VERSION ."
			sh "sudo docker tag $env.APP_NAME:$env.VERSION $env.APP_NAME:latest" 
			sh "sudo docker tag $env.APP_NAME:$env.VERSION $env.DOCKER_REPO:$env.VERSION"
			sh "sudo docker tag $env.APP_NAME:$env.VERSION $env.DOCKER_REPO:latest"
			sh "sudo docker login -u $USERNAME -p $PASSWORD docker.io"
			sh "sudo docker push $env.DOCKER_REPO:$env.VERSION"
			sh "sudo docker push $env.DOCKER_REPO:latest"
			sh "sudo docker images"
			sh "sudo docker logout"
		} 
            }
	}
        stage('Docker pull & run') {
            steps {
		sh "sudo docker stop $(sudo docker ps -a | grep $env.APP_NAME | awk '{ print $1 }')"
		sh "sudo docker rmi $(sudo docker images -a | grep $env.APP_NAME | awk '{ print $3 })"
		sh "sudo docker run --rm -d -p 8080:8080 $env.DOCKER_REPO:latest"
		sh "sudo docker ps -a"
		timeout(300) {
		    waitUntil {
		       script {
			 def r = sh script: 'curl http://localhost:8080', returnStatus: true
			 return (r == 0);
		       }
		    }
		} 
            }
        }
        stage('Check Application RUN') {
            steps {
		sh "curl http://localhost:8080"
            }
        }
    }
}
