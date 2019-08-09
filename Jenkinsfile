#!groovy

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
	VERSION = "4.1"
    }

    stages {
        stage('Stage 1 - Configure & Clean Slave') {
            steps {
                sh "echo STAGE1 - Tasks pre Test and build"
		sh "echo -n 'Version : ' ; echo $env.VERSION"
		sh "sudo yum -y install wget nc ansible"
            }
        }

        stage('Stage 2 - Unit Test') {
            steps {
                sh "mvn test -f Code/pom.xml"
            }
        }

        stage('Stage 3 - Release & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=$env.VERSION -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Stage 4 - Snapshot & Upload Nexus') {
            steps {
                sh "mvn versions:set -DnewVersion=$env.VERSION-SNAPSHOT -f Code/pom.xml"
                sh "mvn clean deploy -f Code/pom.xml -DskipTests" 
            }
        }
        stage('Stage 5 - Docker build, tag & push images ') {
            steps {
		withCredentials([usernamePassword(credentialsId: 'ga-docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {	
			dir("${env.WORKSPACE}/ansible"){
				sh "ansible-playbook stage5-docker-build.yml --extra-vars @vars/ansible-vars.json -e VERSION=$env.VERSION -e USERNAME=$USERNAME -e PASSWORD=$PASSWORD"
			}
		} 
            }
	}
        stage('Stage 6 - Docker pull & run') {
            steps {
		dir("${env.WORKSPACE}/ansible"){
			sh "pwd"
                	sh "ansible-playbook --extra-vars @vars/ansible-vars.json stage6-docker-run.yml -e VERSION=$env.VERSION"
		}
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
        stage('Stage 7 - Check Application RUN') {
            steps {
		sh "curl http://localhost:8080"
            }
        }
    }
}
