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
		   env.DEPLOY_STAGE_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_staging | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_STAGE_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_STAGE_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_STAGE_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()


		   env.DEPLOY_PROD_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_PROD_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_PROD_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   echo "Deploying the manifest ${manifest.stage.version.major}.${manifest.stage.version.minor} for ${manifest.stage.app_name} to Staging"
		   echo "URL: ${manifest.stage.app.healthcheck_url}"

		   echo "DEPLOY_STAGE_VERSION: ----> ${env.DEPLOY_STAGE_VERSION}"
		   echo "DEPLOY_STAGE_VERSION_MAJOR: ----> ${env.DEPLOY_STAGE_VERSION_MAJOR}"
		   echo "DEPLOY_STAGE_VERSION_MINOR: ----> ${env.DEPLOY_STAGE_VERSION_MINOR}"
		   echo "MANIFEST_STAGE_VERSION_MAJOR: ----> ${manifest.stage.version.major}"
		   echo "MANIFEST_STAGE_VERSION_MINOR: ----> ${manifest.stage.version.minor}"

		   echo "DEPLOY_PROD_VERSION: ----> ${env.DEPLOY_PROD_VERSION}"
		   echo "DEPLOY_PROD_VERSION_MAJOR: ----> ${env.DEPLOY_PROD_VERSION_MAJOR}"
		   echo "DEPLOY_PROD_VERSION_MINOR: ----> ${env.DEPLOY_PROD_VERSION_MINOR}"
		   echo "MANIFEST_PROD_VERSION_MAJOR: ----> ${manifest.prod.version.major}"
		   echo "MANIFEST_PROD_VERSION_MINOR: ----> ${manifest.prod.version.minor}"

		   //#if(env.DEPLOY_STAGE_VERSION_MAJOR == manifest.stage.version.major) {  
		//	echo "Deploy same major version in STAGE ${manifest.stage.version.major}.${manifest.stage.version.minor}"
		   //}
		 //   } else {
		//	echo "Deploy different major version in STAGE ${manifest.stage.version.major} v${manifest.stage.version.minor}"
		 //  }  
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
        }
        stage('Deploy to Production') {
	    when { 
	//	branch "w1a9-gitops-final"
		expression { env.DEPLOY_PROD_VERSION_MINOR < manifest.prod.version.minor } 
	    } 
            steps {
		script {
            	   //manifest = readJSON file: 'manifest.json'
		   env.DEPLOY_PROD_VERSION = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.DEPLOY_PROD_VERSION_MAJOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.DEPLOY_PROD_VERSION_MINOR = sh(returnStdout: true, script: "echo '${env.DEPLOY_PROD_VERSION}' | awk -F'[ .]' '{print \$2}'").trim()

		   echo "Deploying the manifest ${manifest.prod.version.major}.${manifest.prod.version.minor} for ${manifest.prod.app_name} to Production"
		   echo "URL: ${manifest.prod.app.healthcheck_url}"

		   echo "DEPLOY_PROD_VERSION: ----> ${env.DEPLOY_PROD_VERSION}"
		   echo "DEPLOY_PROD_VERSION_MAJOR: ----> ${env.DEPLOY_PROD_VERSION_MAJOR}"
		   echo "DEPLOY_PROD_VERSION_MINOR: ----> ${env.DEPLOY_PROD_VERSION_MINOR}"
		   echo "MANIFEST_PROD_VERSION_MAJOR: ----> ${manifest.prod.version.major}"
		   echo "MANIFEST_PROD_VERSION_MINOR: ----> ${manifest.prod.version.minor}"

		   //if ( $env.DEPLOY_PROD_VERSION_MAJOR == $manifest.prod.version.major ) {
		//	echo "Desploy same version en PROD"
 	         //  }
		 
//		}
		//dir("${env.WORKSPACE}/ansible"){
                	//sh "ansible-playbook gitops-deploy-app.yml -e appname=${environment.app.name} -e repo=${manifest.repo} -e appport=${environment.app.port} -e version=${manifest.version}"
		}
            }
    	}
    }
}
