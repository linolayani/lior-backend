# Building the application using maven
FROM maven:3.8.1-openjdk-17-slim as builder
COPY src /src
COPY pom.xml /pom.xml
RUN mvn package
RUN mv $(find /target -name "*.jar") /app.jar

# Running the application
FROM openjdk:11
COPY --from=builder /app.jar /app.jar
RUN mkdir -p /h2
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]