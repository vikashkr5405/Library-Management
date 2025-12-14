# Dockerfile

# Stage 1: Build the JAR
# Use Maven with Eclipse Temurin JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . /app
WORKDIR /app
# Package the application, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Create the final production image
# Use OpenJDK 21 JRE-slim for the smallest runtime image size
FROM openjdk:21-jre-slim
# The JRE-slim image is ideal for running the built JAR

# Set the application port
ENV PORT 8080
EXPOSE 8080

# Copy the built JAR from the first stage
# Ensure this JAR name matches the one created by Maven
COPY --from=build /app/target/Library-Management-0.0.1-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]