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
        stage('Prepare Jenkins Slave') {
            steps {
                sh "echo STAGE1"
                //sh "rm -rf *"
                //sh "git clone https://github.com/semperti-bootcamp/sre-bootcamp-ga-20190805.git -b w1a7-jenkins"
                sh "pwd ; ls -ltr"
            }
        }
        stage('Unit Test & Package') {
            steps {
                sh "echo TEST1"
            }
        }
    }
}
