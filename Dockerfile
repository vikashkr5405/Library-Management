# Dockerfile

# Stage 1: Build the JAR
# Using stable Maven base image with Eclipse Temurin JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . /app
WORKDIR /app
# Package the application, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Create the final production image
# Use the recommended Eclipse Temurin 21 JRE tag on the stable 'jammy' Ubuntu base
FROM eclipse-temurin:21-jre-jammy
# This JRE-only image is small, secure, and ready to run your application

# Set the application port
ENV PORT 8080
EXPOSE 8080

# Copy the built JAR from the first stage
# Ensure this JAR name matches the one created by Maven
COPY --from=build /app/target/Library-Management-0.0.1-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]