FROM maven:3.5-jdk-8 as BUILD
#FROM maven:3-jdk-9-onbuild as BUILD
#COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp
RUN mvn -f /usr/src/myapp/pom.xml clean package
#FROM jboss/wildfly:10.1.0.Final
FROM tomcat:8.5.14
#COPY *.war /usr/local/tomcat/webapps/
COPY --from=BUILD /usr/src/myapp/target/*.jar /usr/local/tomcat/webapps/
