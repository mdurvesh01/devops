pipeline {
    agent any
    environment {
        registry = "662519022378.dkr.ecr.us-gov-west-1.amazonaws.com"
        repo = "pmt/paymentfrontend"
        branch = "Testing"
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
              script {
                withDockerRegistry(credentialsId: 'ecr:us-gov-west-1:payment_ecr', url: "https://${registry}/pmt/paymentfrontend") {
                  front_image.push()
                  front_image.tag("$branch")
                  docker.image(jenkins_image).push()
                 }
               }
            }
        }
    }
}
