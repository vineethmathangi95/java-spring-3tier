# Stage 1: Build with Java 8
FROM eclipse-temurin:8-jdk-alpine AS builder
WORKDIR /build
COPY . .
RUN mvn clean install -DskipTests

# Stage 2: Runtime with Java 8
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=builder /build/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
