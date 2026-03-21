pipeline {
    agent any

    environment {
        IMAGE = "myapp:v1"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/Surya8442/twentyone.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t myapp:v1 .'
            }
        }

        stage('Approval') {
            steps {
                input {
                    message "Deploy to Kubernetes?"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'kubectl apply -f deployment.yml'
                sh 'kubectl apply -f service.yml'
            }
        }
    }
}
