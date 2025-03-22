pipeline {
   tools {
        maven 'Maven3'
    }
    agent any
    environment {
        registry = "973625940209.dkr.ecr.us-east-1.amazonaws.com/arar123"
        AWS_REGION = "us-east-1"
        
    }
    stages {
 
        stage ('Build') {
          steps {
            sh 'mvn clean install'           
            }
      }
    // Building Docker images
       stage('Building image') {
          steps{
            script {
               dockerImage = docker.build registry 
            }
           }
       }  
       stage('Pushing to ECR') {
          steps{  
            script {
               
                  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                       
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${registry}"
                        sh 'docker push 973625940209.dkr.ecr.us-east-1.amazonaws.com/arar123'
                    }
                            
            }
           }
        }
       stage('K8S Deploy') {
         steps{
            script {
               withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
               withKubeConfig(credentialsId: 'newk8s', serverUrl: 'https://D2A53313294068B898A78542A83CF533.gr7.us-east-1.eks.amazonaws.com') {
                  sh 'kubectl apply -f  eks-deploy-k8s.yaml'
                  }
               }
               
               }
            }        
        }
    }
}
