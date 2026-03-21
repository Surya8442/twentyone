pipeline {
    agent any

    environment {
        DOCKER_USER = "surya8442"
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "v1"
        CONTAINER_NAME = "myapp-container"
        APP_PORT = "3000"     // Change port if needed
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

        stage('Run Container') {
            steps {
                sh """
                    docker rm -f ${CONTAINER_NAME} || true

                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${APP_PORT}:${APP_PORT} \
                        ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                """
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
