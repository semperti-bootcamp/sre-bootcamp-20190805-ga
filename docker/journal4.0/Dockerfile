FROM openjdk:8-jdk-alpine
MAINTAINER Gonzalo Acosta <gonzalo.acosta@semperti.com>
WORKDIR /root
RUN mkdir /root/upload
COPY ./upload/ /root/upload/
ADD http://10.252.7.162:8081/repository/maven-releases/com/semperti/trial/journals/4.0/journals-4.0.jar /opt/journals-4.0.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/opt/journals-4.0.jar"]
