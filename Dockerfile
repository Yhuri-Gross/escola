# Etapa 1: Construir o aplicativo
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . /app
RUN mvn clean install -DskipTests

# Etapa 2: Executar o aplicativo
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/escola-0.0.1-SNAPSHOT.jar /app/escola.jar
CMD ["java", "-jar", "escola.jar"]
