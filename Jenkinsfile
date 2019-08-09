#!groovy

def manifest
def environment

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }

    stages {

        stage('Deploy to Staging') {
	    when { 
	    expression {
		return env.BRANCH_NAME == 'orgin/w1a9-gitops-stagin';
		}
	    } 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
                   environment = readJSON file: 'staging-env.json'
		   echo "Deploying the manifest ${manifest.version} for ${manifest.artifacts.web} to Staging"
		   echo "URL: ${environment.app.healthcheck_url}"
		}
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${environment.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
        }

        stage('Deploy to Production') {
	    when { 
		branch 'origin/w1a9-gitops-prod'
	    } 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
                   environment = readJSON file: 'prod-env.json'
		   echo "Deploying the manifest ${manifest.version} for ${manifest.artifacts.web} to Production"
		   echo "URL: ${environment.app.healthcheck_url}"
		}
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${environment.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
    	}
    }
}
