pipeline {
    agent any
    environment {
        registry = "xxxxxx.dkr.ecr.us-gov-west-1.amazonaws.com"
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
                withDockerRegistry(credentialsId: 'xxx-key', url: "https://${registry}") {
                  front_image.push()
                  front_image.tag("$branch")
                  docker.image(jenkins_image).push()
                 }
               }
            }
        }
    }
}
