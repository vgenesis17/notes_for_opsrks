pipeline {
    agent {
        label 'ststor01'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'sarah', url: "http://git.stratos.xfusioncorp.com/sarah/web.git"

            }
        }
         stage('Update Code') {
            steps {
                sh 'cd /var/www/html && git pull origin master'
            }
        }
    }
}
