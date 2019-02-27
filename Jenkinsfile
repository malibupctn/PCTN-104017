pipeline {
    agent {
        kubernetes {
            label 'kaniko'
            defaultContainer 'jnlp'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - /busybox/cat
    tty: true
"""
        }
    }
    stages {
        stage('Build with Kaniko') {
            steps {
      
        container(name: 'kaniko', shell: '/busybox/sh') {
           withEnv(['PATH+EXTRA=/busybox']) {
            sh '''#!/busybox/sh
            /kaniko/executor --context `pwd` --destination=baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/hello-kaniko:3
            '''
           }
        }
        }
      }
    }
}