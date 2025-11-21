FROM gradle:8.7-jdk17-alpine AS build
WORKDIR /app
COPY build.gradle.kts ./
COPY src ./src
RUN gradle test bootJar --no-daemon

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]