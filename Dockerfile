FROM baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/infra-base-images/openjdk:1.8
ADD ./target /target
EXPOSE 8080
CMD java -jar /target/springboot-hello-1.0.jar
