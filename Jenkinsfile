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
		   env.run_stg_ver = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_staging | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.run_stg_ver_maj = sh(returnStdout: true, script: "echo '${env.run_stg_ver}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.run_stg_ver_min = sh(returnStdout: true, script: "echo '${env.run_stg_ver}' | awk -F'[ .]' '{print \$2}'").trim()

		   // Prod versions
		   env.run_prod_ver = sh(returnStdout: true, script: "sudo docker ps -a | grep journal_latest | awk '{ print \$2 }' | cut -d: -f2").trim()
		   env.run_prod_ver_maj = sh(returnStdout: true, script: "echo '${env.run_prod_ver}' | awk -F'[ .]' '{print \$1}'").trim()
		   env.run_prod_ver_min = sh(returnStdout: true, script: "echo '${env.run_prod_ver}' | awk -F'[ .]' '{print \$2}'").trim()

		   // Print Versions 
		   echo "Stage deployed: ${env.run_stg_ver} -- Stage to deploy: ${man.stg.ver.maj}.${man.stg.ver.min}"
		   echo "Prod deployed: ${env.run_prod_ver} -- Prod to deploy: ${man.prod.ver.maj}.${man.prod.ver.min}"

		   // Deploy stage if stg.ver deployed NOT EQUAL stg.ver in man.json
		   env.deploy_stg = sh(returnStdout: true, script: "[ '${env.run_stg_ver_min}' -ne '${man.stg.ver.min}' ] && echo 'YES'").trim()
		
		   // Deploy prod if stg.ver deployed LESS THAN OR EQUAL stage in man.json
		   env.deploy_prod = sh(returnStdout: true, script: "[ '${man.prod.ver.min}' -le '${man.stg.ver.min}' ] && echo 'YES'").trim()

		}  
            }
        }
        stage('Deploy to Staging') {
	    when { 
		environment name: "deploy_stg", value: "YES"
	    } 
            steps {
		sh "echo 'Deploy Stage Version: ${man.stg.ver.maj}.${man.stg.ver.min}'"
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${man.stage.app.name} -e repo=${man.stage.docker_repo} -e appport=${man.stage.app.port} -e version=${man.stg.ver.maj}.${man.stg.ver.min}"
		} 
            }
    	}

        stage('Deploy to Prod') {
	    when { 
		environment name: "deploy_prod", value: "YES"
	    } 
            steps {
		sh "echo 'Deploy Prod Version: ${man.prod.ver.maj}.${man.prod.ver.min}'"
		dir("${env.WORKSPACE}/ansible"){
                	sh "ansible-playbook gitops-deploy-app.yml -e appname=${man.prod.app.name} -e repo=${man.prod.docker_repo} -e appport=${man.prod.app.port} -e version=${man.prod.ver.maj}.${man.prod.ver.min}"
		}
            }
    	}
    }
}
