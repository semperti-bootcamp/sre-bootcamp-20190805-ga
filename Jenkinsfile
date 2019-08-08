#!groovy

def manifest
def environment

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

        stage('Deploy to Staging') {
	    when { 
		branch 'w1a9-gitops-staging'
	    } 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
                   environment = readJSON file: 'staging-env.json'
		   echo "Deploying the manifest ${manifest.version} for ${manifest.artifacts.web} to Staging"
		   echo "URL: ${environment.app.healthcheck_url}"
		}
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml --extra-vars=${ manifest } --extra-vars=${ environment }" 
		}
            }
        }

        stage('Deploy to Production') {
	    when { 
		branch 'w1a9-gitops-prod'
	    } 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
                   environment = readJSON file: 'prod-env.json'
		   echo "Deploying the manifest ${manifest.version} for ${manifest.artifacts.web} to Production"
		   echo "URL: ${environment.app.healthcheck_url}"
		}
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml --extra-vars=${ manifest } --extra-vars=${ environment }" 
		}
            }
    	}
    }
}
