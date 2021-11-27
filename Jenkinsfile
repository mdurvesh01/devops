pipeline {
    agent any
    environment {
        registry = "662519022378.dkr.ecr.us-gov-west-1.amazonaws.com"
        repo = "pmt/paymentfrontend"
        branch = "Testing
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    jenkins_image = docker.build "${registry}/pmt/paymentbackend:$branch-latest"
               }
            }
        }
        stage('Ecr login') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-gov-west-1'){
                sh 'aws ecr get-login-password | docker login --username AWS --password-stdin $registry'
                sh 'docker push ${registry}/pmt/paymentbackend:$branch-latest'
                }
            }
        }
    }
}
