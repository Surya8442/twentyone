pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "surya8442/myapp:v1"
    }

    stages {

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-token', variable: 'TOKEN')]) {
                    sh "echo $TOKEN | docker login -u surya8442 --password-stdin"
                }
                sh "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Approval') {
            steps {
                input "Deploy to Kubernetes?"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yml'
                sh 'kubectl apply -f service.yml'
            }
        }
    }
}
