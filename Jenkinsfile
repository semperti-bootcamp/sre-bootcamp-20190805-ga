#!groovy

def man

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
            	   man = readJSON file: 'manifest.json'
		   // Stage versions
		   env.DEPLOY_STAGE_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_staging | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_STAGE_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_STAGE_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   // Prod versions
		   env.DEPLOY_PROD_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_PROD_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_PROD_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   // Print Versions 
		   echo "Stage deployed: ${env.DEPLOY_STAGE_VERSION} --> Stage to deploy: ${man.stage.version.major}.${man.stage.version.minor}"
		   echo "Prod deployed: ${env.DEPLOY_PROD_VERSION} --> Prod to deploy: ${man.prod.version.major}.${man.prod.version.minor}"

		   // Deploy stage if stage version deployed NOT EQUAL stage version in man.json
		   env.DEPLOY_STAGE = sh(returnStdout: true, script: "[ '${env.DEPLOY_STAGE_VERSION_MINOR}' -ne '${man.stage.version.minor}' ] && echo 'YES'").trim()
		
		   // Deploy prod if stage version deployed LESS THAN OR EQUAL stage in man.json
		   env.DEPLOY_PROD = sh(returnStdout: true, script: "[ '${man.prod.version.minor}' -le '${man.stage.version.minor}' ] && echo 'YES'").trim()

		}  
            }
        }
        stage('Deploy to Staging') {
	    when { 
		environment name: "DEPLOY_STAGE", value: "YES"
	    } 
            steps {
		sh "echo 'Deploy STAGE VERSION: ${man.stage.version.major}.${man.stage.version.minor}'"
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${man.stage.app.name} -e repo=${man.stage.docker_repo} -e appport=${man.stage.app.port} -e version=${man.stage.version.major}.${man.prod.version.minor}"
		} 
            }
    	}

        stage('Deploy to Prod') {
	    when { 
		environment name: "DEPLOY_PROD", value: "YES"
	    } 
            steps {
		sh "echo 'Deploy PROD VERSION: ${man.prod.version.major}.${man.prod.version.minor}'"
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${man.prod.app.name} -e repo=${man.prod.docker_repo} -e appport=${man.prod.app.port} -e version=${man.prod.version.major}.${man.prod.version.minor}"
		}
            }
    	}
    }
}
