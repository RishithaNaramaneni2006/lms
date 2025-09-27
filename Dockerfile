# Use OpenJDK 21
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy the Spring Boot jar into the container
COPY target/*.jar app.jar

# Expose port 9020 (Spring Boot default)
EXPOSE 9021

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
