FROM openjdk:8-jdk-alpine
MAINTAINER Gonzalo Acosta <gonzalo.acosta@semperti.com>
WORKDIR /root
RUN mkdir /root/upload
COPY ./PDFs/ /root/upload/
ADD http://10.252.7.162:8081/repository/maven-releases/com/semperti/trial/journals/4.0.3/journals-4.0.3.jar /opt/journals-4.0.3.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/opt/journals-4.0.3.jar"]
