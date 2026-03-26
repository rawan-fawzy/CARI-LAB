pipeline {
    agent any

    environment {
        COMPOSE_FILE = 'docker-compose.yml'
        APP_NAME     = 'taskflow'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Fetching source code...'
                checkout scm
            }
        }

        stage('Cleanup') {
            steps {
                echo 'Cleaning up old containers...'
                sh 'docker-compose -f ${COMPOSE_FILE} down --remove-orphans 2>/dev/null || true'
            }
        }

        stage('Build Images') {
            steps {
                echo 'Building Docker images...'
                sh 'docker-compose -f ${COMPOSE_FILE} build --no-cache'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Starting containers...'
                //(Detached mode)
                sh 'docker-compose -f ${COMPOSE_FILE} up -d'
            }
        }

        stage('Health Check') {
            steps {
                echo 'Verifying that the application is running...'
                sleep 15 
                sh 'docker-compose -f ${COMPOSE_FILE} ps'
            }
        }
    }

    post {
        success {
            echo "Build #${BUILD_NUMBER} succeeded! App is live at http://localhost"
        }
        failure {
            echo "Build #${BUILD_NUMBER} failed!"
            sh 'docker-compose -f ${COMPOSE_FILE} down'
        }
    }
}
