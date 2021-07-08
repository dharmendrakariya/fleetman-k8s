FROM maven:3.5.4-jdk-8-alpine AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package 


FROM openjdk:8u131-jdk-alpine
WORKDIR /usr/local/bin/
COPY --from=build /usr/src/app/target/fleetman-0.0.1-SNAPSHOT.jar ./webapp.jar  
EXPOSE 8080
CMD ["java","-Dspring.profiles.active=docker-demo","-jar","/usr/local/bin/webapp.jar"]
# ENTRYPOINT ["java","-jar","/usr/local/bin/webapp.jar"]
