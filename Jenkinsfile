pipeline {
    agent any

    environment {
        DOCKER_USER = "surya8442"
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "v1"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Surya8442/twentyone.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub_token', variable: 'TOKEN')]) {
                    sh """
                        echo $TOKEN | docker login -u ${DOCKER_USER} --password-stdin
                        docker push ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    input message: "Approve deployment?"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    kubectl apply -f deployment.yaml
                """
            }
        }

    } // <-- closes stages
} // <-- closes pipeline
