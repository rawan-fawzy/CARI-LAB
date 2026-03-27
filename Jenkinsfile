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
                echo 'Cleaning up old containers and volumes...'
                // التعديل هنا: أضفنا -v لمسح الـ Volume البايظ بتاع الـ DB
                sh 'docker compose down -v --remove-orphans || true'
            }
        }

        stage('Build Images') {
            steps {
                echo 'Checking files before build...'
                sh 'ls -R' 
                
                echo 'Building Docker images...'
                // استخدمنا docker compose بدون شرطة لضمان التوافق مع السيرفر
                sh 'docker compose build --no-cache'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Starting containers...'
                sh 'docker compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                echo 'Verifying that the application is running...'
                sleep 20 // زودنا الوقت شوية عشان الـ MySQL تلحق تقوم
                sh 'docker compose ps'
            }
        }
    }

    post {
        success {
            echo "Build #${BUILD_NUMBER} succeeded! App is live at http://192.168.75.128"
        }
        failure {
            echo "Build #${BUILD_NUMBER} failed!"
            sh 'docker compose down'
        }
    }
}