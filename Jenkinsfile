#!groovy

def manifest

pipeline {

    agent {
        node (){
            label 'sre-bootcamp-ga-1'
        }
    }

    stages {

        stage('Determine Version') {
            steps {
		script {
            	   manifest = readJSON file: 'manifest.json'
		   // STAGE
		   env.DEPLOY_STAGE_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_staging | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_STAGE_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_STAGE_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   // PROD
		   env.DEPLOY_PROD_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_PROD_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_PROD_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   // Print Versions 
		   echo "DEPLOY_STAGE_VERSION:         ${env.DEPLOY_STAGE_VERSION}"
		   echo "DEPLOY_STAGE_VERSION_MAJOR:   ${env.DEPLOY_STAGE_VERSION_MAJOR}"
		   echo "DEPLOY_STAGE_VERSION_MINOR:   ${env.DEPLOY_STAGE_VERSION_MINOR}"
		   echo "MANIFEST_STAGE_VERSION_MAJOR: ${manifest.stage.version.major}"
		   echo "MANIFEST_STAGE_VERSION_MINOR: ${manifest.stage.version.minor}"

		   echo "DEPLOY_PROD_VERSION:          ${env.DEPLOY_PROD_VERSION}"
		   echo "DEPLOY_PROD_VERSION_MAJOR:    ${env.DEPLOY_PROD_VERSION_MAJOR}"
		   echo "DEPLOY_PROD_VERSION_MINOR:    ${env.DEPLOY_PROD_VERSION_MINOR}"
		   echo "MANIFEST_PROD_VERSION_MAJOR:  ${manifest.prod.version.major}"
		   echo "MANIFEST_PROD_VERSION_MINOR:  ${manifest.prod.version.minor}"

		   // Deploy STAGE if version is different to version deployed.
		   env.DEPLOY_STAGE = sh(returnStdout: true, script: "[ '${env.DEPLOY_STAGE_VERSION_MAJOR}' -ne '${manifest.stage.version.major}' ] && echo 'YES'").trim()

		   // Deploy PROD if version es different to version deployed and minor the STAGE to deploy.
		   env.DEPLOY_PROD = sh(returnStdout: true, script: "[ '${env.DEPLOY_PROD_VERSION.MAJOR}' -le '${manifest.stage.version.major}' ] && [ '${env.DEPLOY_PROD_VERSION.MINOR}' -le '${manifest.stage.version.minor}' ] && echo 'YES'").trim() 

		}  
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		//}
            }
        }
        stage('Deploy to Staging') {
	    when { 
		environment name: "DEPLOY_STAGE", value: "YES"
	    } 
            steps {
		script {
			echo "Deploy STAGE VERSION: ${manifest.stage.version.major}.${manifest.stage.version.minor}"
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
    	}
        stage('Deploy to Production') {
	    when { 
		expression { env.DEPLOY_PROD_VERSION_MAJOR == 'greeting' }	
	    } 
            steps {
		script {
			echo "Deploy PROD VERSION: ${manifest.prod.version.major}.${manifest.prod.version.minor}"
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
    	}
    }
}
