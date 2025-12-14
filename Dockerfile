# Dockerfile

# Stage 1: Build the JAR file
# Use a Maven base image with JDK
FROM maven:3.8.7-openjdk-17 AS build
WORKDIR /app
COPY . /app
# Package the application, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Create the final production image
# Use a slim JRE (smaller image size)
FROM openjdk:17-jre-slim
# Expose the application port
EXPOSE 8080
# Copy the built JAR from the first stage
COPY --from=build /Library-Management/target/Library-Management-0.0.1-SNAPSHOT.jar app.jar
# The command to run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]