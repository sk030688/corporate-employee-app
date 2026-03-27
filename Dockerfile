FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/employee-app-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]

