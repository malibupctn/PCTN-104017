def label = "kaniko-${UUID.randomUUID().toString()}"

podTemplate(name: 'kaniko', label: label, yaml: """
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/kaniko-executor:latest
    args: ['--dockerfile=Dockerfile',
            '--context=s3://kaniko-contexts/springboot-hello.tar.gz',
            '--destination=baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/springboot-hello-kaniko:latest']
    volumeMounts:
      - name: aws-secret-nokey
        mountPath: /root/.aws
      - name: devrepo-secret
        mountPath: /root/
  restartPolicy: Never
  volumes:
    - name: aws-secret-nokey
      secret:
        secretName: aws-secret-nokey
    - name: devrepo-secret
      projected:
        sources:
        - secret:
            name: devrepo-secret
            items:
            - key: .dockerconfigjson
              path: .docker/config.json
""") {
  node(label) {
    stage('Checkout GitHub') {
      git 'https://github.com/malibupctn/springboot-hello.git'
    }
    stage('Create Kaniko Context'){
      tar -C springboot-hello -cvzf springboot-hello.tar.gz .
    }
    stage('Copy Context To s3'){
      aws s3 cp springboot-hello.tar.gz 's3://kaniko-contexts'
    }
    stage('Build with Kaniko') {
        git 'https://github.com/jenkinsci/docker-jnlp-slave.git'
        container(name: 'kaniko')
      }
    }
  }