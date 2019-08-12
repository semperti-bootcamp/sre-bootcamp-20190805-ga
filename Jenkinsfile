#!groovy

def manifest

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }

    stages {

        stage('Deploy to Staging') {
	    //when { 
	    //	branch "w1a9-gitops-final"
	    //} 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
		   env.DEPLOY_VERSION_STAGE = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_staging | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_MAJOR_VERSION = sh(returnStdout: true, script: "echo '${env.DEPLOY_VERSION_STAGE}' | awk -F'[ .]' '{print \$1}'").trim()
		   echo "Deploying the manifest ${manifest.stage.version} for ${manifest.stage.app_name} to Staging"
		   echo "URL: ${manifest.stage.app.healthcheck_url}"
		   echo "DEPLOY_VERSION_STAGE: ----> $env.DEPLOY_VERSION_STAGE"
		   echo "DEPLOY_MAJOR_VERSION: ----> $env.DEPLOY_MAJOR_VERSION"
		   echo "DEPLOY_NEW_VERSION: ----> $manifest.stage.version"
		}
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		//}
            }
        }
        stage('Deploy to Production') {
	    //when { 
	//	branch "w1a9-gitops-final"
	    //} 
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
		   env.DEPLOY_VERSION_PROD = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   echo "Deploying the manifest ${manifest.prod.version} for ${manifest.prod.app_name} to Production"
		   echo "URL: ${manifest.prod.app.healthcheck_url}"
		   echo "DEPLOY_VERSION_PROD: ----> $env.DEPLOY_VERSION_PROD"
		   echo "DEPLOY_NEW_VERSION_PROD: ----> $manifest.prod.version"
		}
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		//}
            }
    	}
    }
}
