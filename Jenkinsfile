pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    environment {
        IMAGE = 'sk030688/employee-app:latest'
    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh '''
                docker build -t $IMAGE .
                docker push $IMAGE
                '''
            }
        }

        stage('Deploy DEV') {
            steps {
                sh '''
                oc project sabbavarapusatishkum-dev
                oc delete all -l app=employee-app-dev || true
                oc new-app --name=employee-app-dev $IMAGE
                oc expose svc employee-app-dev || true
                '''
            }
        }

        stage('Approval for TEST') {
            steps {
                input message: 'Approve TEST deployment?'
            }
        }

        stage('Deploy TEST') {
            steps {
                sh '''
                oc project sabbavarapusatishkum-dev
                oc delete all -l app=employee-app-test || true
                oc new-app --name=employee-app-test $IMAGE
                oc expose svc employee-app-test || true
                '''
            }
        }

        stage('Approval for PROD') {
            steps {
                input message: 'Approve PROD deployment?'
            }
        }

        stage('Deploy PROD') {
            steps {
                sh '''
                oc project sabbavarapusatishkum-dev
                oc delete all -l app=employee-app-prod || true
                oc new-app --name=employee-app-prod $IMAGE
                oc expose svc employee-app-prod || true
                '''
            }
        }
    }
}
