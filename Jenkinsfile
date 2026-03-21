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
                sh "npm install"
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Docker_cred',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                        echo "${PASS}" | docker login -u "${USER}" --password-stdin
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
                sh "kubectl apply -f deployment.yml"
                sh "kubectl apply -f Service.yml"
            }
        }

    }
}
