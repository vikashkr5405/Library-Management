# Dockerfile

# Stage 1: Build the JAR (Update Maven base image)
FROM maven:3.9.6-eclipse-temurin-17 AS build
COPY . /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Stage 2: Create the final production image
# Use a slim JRE (Update JRE/JDK base image)
FROM openjdk:17-jdk-slim
# The JDK slim image contains the JRE components needed to run the app

ENV PORT 8080
EXPOSE 8080

# Copy the JAR file from the build stage
# Ensure this JAR name matches the one created by Maven
COPY --from=build /app/target/Library-Management-0.0.1-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]