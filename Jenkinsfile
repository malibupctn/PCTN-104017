pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      label 'mypod'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    image: baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/cloudbees-base-images/maven:3.6-jdk-8
    command: ['cat']
    tty: true
  - name: kaniko
    image: baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/cloudbees-base-images/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: devrepo-secret
          items:
            - key: .dockerconfigjson
              path: config.json
"""
    }
  }
  stages {
    stage('build maven') {
        steps {
            container('maven') {
                sh 'mvn package -B -e -Dmaven.test.skip=true'
            }
        }
    }
        stage('Build with Kaniko') {
      environment {
        PATH = "/busybox:/kaniko:$PATH"
      }
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
            sh '''#!/busybox/sh
            /kaniko/executor -v debug -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --destination=baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/hello-kaniko:3
            '''
        }
      }
    }
  }
}
