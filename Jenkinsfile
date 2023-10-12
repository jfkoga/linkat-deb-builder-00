def sourcePackage = ""

pipeline {
  environment {
    registry = "jfkoga/linkat-deb-builder-00"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Packager Git') {
      steps {
                checkout([$class: 'GitSCM', 
                          branches: [[name: '*/main']],
                          doGenerateSubmoduleConfigurations: false, 
                          extensions: [], 
                          submoduleCfg: [], 
                          userRemoteConfigs: []])            }
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Clone another repository to subdir') {
         steps {
           sh 'rm source -rf; mkdir source'
           dir ('source') {
             git branch: 'master',
               credentialsId: 'xxxxxxxxxxxxxxxxxxxxx',
               url: 'https://github.com/deb-package-source-example.git'
            }
        }
    }
    
stage('Build') {
       steps {
         sh 'rm output -rf; mkdir output'
         sh 'docker run --rm -v /data/docker/lab/jenkins/jenkins.linkat.lab/jenkins/workspace/docker-packager-18.04/source:/package jfkoga/linkat-deb-builder-00:$BUILD_NUMBER -b'
       }
    }
    
   
    
  }
}