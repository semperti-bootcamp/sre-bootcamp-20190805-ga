FROM openjdk:8-jdk-alpine
MAINTAINER Gonzalo Acosta <gonzalo.acosta@semperti.com>
WORKDIR /root
RUN mkdir /root/upload
COPY ./upload/ /root/upload/
ADD http://10.252.7.162:8081/repository/maven-snapshots/com/semperti/trial/journals/3.3-SNAPSHOT/journals-3.3-20190806.221420-3.jar /opt/journals-3.3-20190806.221420-3.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/opt/journals-3.3-20190806.221420-3.jar"]
