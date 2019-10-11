node(jenkins-agent){
  def IMAGE = "xxxxxxxxxxx:xxxxxx"
  def Creds = "12344556777" // dummy creds
  try {
  stage('Checkout code'){
      git 'https://github.com/thomasbinny/devops-assignment.git'
      sh "git rev-parse --short HEAD > .git/commit-id"
  }

  stage('Docker Build, Push'){
    withDockerRegistry([credentialsId: "${Creds}", url: 'https://index.docker.io/v1/']) {
      sh "docker build -t ${IMAGE}"
      sh "docker push ${IMAGE}"
      sh "sed -e \"s~{{IMAGE}}~${IMAGE}~g\" deploy/deployk8s.yaml"
        }
  }

  stage('Deploy on K8s'){
    sh "cd deploy"
    sh "kubectl apply -f deployk8s.yaml"
  }
  }
  catch (e) {
        // If there was an exception thrown, the build failed
        currentBuild.result = "FAILED"
        throw e
  }
}
