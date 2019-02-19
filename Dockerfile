FROM baserepodev.devrepo.malibu-pctn.com/104017-malibu-artifacts/openjdk:1.8
ADD ./bin /bin
EXPOSE 8080
CMD java -jar /bin/springboot-hello-1.0.jar
