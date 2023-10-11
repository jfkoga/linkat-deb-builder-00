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
        git 'https://github.com/jfkoga/linkat-deb-builder-00.git'
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
  
    
   
    
  }
}
