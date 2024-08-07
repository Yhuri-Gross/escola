# Etapa 1: Construir o aplicativo
FROM maven:3.8.6-jdk-11 AS build
WORKDIR /app
COPY . /app
RUN chmod +x mvnw && ./mvnw clean install

# Etapa 2: Executar o aplicativo
FROM openjdk:11-jre
COPY --from=build /app/target/escola-0.0.1-SNAPSHOT.jar /app/escola.jar
ENTRYPOINT ["java", "-jar", "/app/escola.jar"]
