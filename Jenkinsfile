podTemplate(label: 'docker',
  containers: [containerTemplate(name: 'docker', image: 'docker:1.11', ttyEnabled: true, command: 'cat')],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
  ) {

  def image = "pctn/springboot-hello"
  
  node('docker') {
    stage('Checkout GitHub') {
      git 'https://github.com/malibupctn/springboot-hello.git'
    }
    stage('Docker Build') {
      container('docker') {
        sh "docker build -t ${image} ."
      }
    }
    stage('Docker Push') {
        container('docker') {
            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory',
            usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                sh "docker login -u ${USERNAME} -p ${PASSWORD} https://malibu-repo-local.devrepo.malibu-pctn.com"
            }
            sh "docker tag pctn/springboot-hello:latest malibu-repo-local.devrepo.malibu-pctn.com/pctn/springboot-hello:latest"
            sh "docker push malibu-repo-local.devrepo.malibu-pctn.com/pctn/springboot-hello:latest"
        }
    }
  }
}
