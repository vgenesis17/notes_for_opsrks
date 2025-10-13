pipeline {
    agent { dockerfile true }

    stages {
        stage('Checkout Source Code') {
            steps {
                git credentialsId: 'd6ea8f0e-f28f-4a69-bd51-de2af1e16db3', url: 'https://github.com/genesis-villagracia/node-webapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def appImage = docker.build("gvillagracia/node-app${env.BUILD_NUMBER}", "./node-app/Dockerfile")
                   
                }
            }
        }

       
        stage('Deploy to linux-Node') {
            agent {
                label 'linux-node' 
            }
            steps {
                // Example for deploying using Docker Compose
                withCredentials([string(credentialsId: 'your-ssh-key-credential-id', variable: 'SSH_KEY')]) {
                    sh '''
                        echo "$SSH_KEY" > ~/.ssh/id_rsa
                        chmod 600 ~/.ssh/id_rsa
                        ssh -o StrictHostKeyChecking=no gvillagracia@gvillagracia-a2t-pe-cid1b"
                            docker pull villagracia213/node-app:${BUILD_NUMBER}
                            docker stop node-app || true
                            docker rm node-app|| true
                            docker run -d --name node-app -p 80:3000 villagracia213/node-app:${BUILD_NUMBER}
                        "
                    '''
                }
               
            }
        }
    }

    post {
        always {
            cleanWs() 
        }
        failure {
            echo "Pipeline failed!"
            
        }
        success {
            echo "Pipeline succeeded!"
           
        }
    }
}
