node{
     
    stage('Checkout Code'){
        git url: 'https://github.com/kalyankumar-banks/java-web-app-jenkins-docker.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven-3.9.9", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
      
    } 
    
    
    stage('Build Docker Image'){
        sh "docker build -t kalyankumar2025/java-web-app:$BUILD_NUMBER ."
    }
    
    stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
          sh "docker login -u kalyankumar2025 -p ${Docker_Hub_Pwd}"
        }
        sh "docker push kalyankumar2025/java-web-app:$BUILD_NUMBER"
     }
     
      stage('Run Docker Image In Dev Server'){
        
        def dockerRun = ' docker run  -d -p 8080:8080 --name javawebapp kalyankumar2025/java-web-app'
         
         sshagent(['DOCKER_SERVER']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-5-207 docker stop javawebapp || true'
          sh 'ssh  ubuntu@ip-172-31-5-207 docker rm javawebapp || true'
          sh 'ssh  ubuntu@ip-172-31-5-207 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ubuntu@ip-172-31-5-207 ${dockerRun}"
       }
       
    }
     
     
}
