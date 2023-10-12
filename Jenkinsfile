def sourcePackage = ""

pipeline {
  environment {
    registry = "linkatedu/linkat-deb-builder"
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
          docker.withRegistry( '', 'a8f241ed-c93c-41e8-820d-d168799f6512') {
            dockerImage.push()
          }
        }
      }
    }
    
  }
}
