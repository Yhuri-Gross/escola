# Estágio 1: Construção do aplicativo
FROM maven:3.8.7-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Estágio 2: Imagem para execução do aplicativo
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/escola-0.0.1-SNAPSHOT.jar /app/escola.jar

# Especifica que a aplicação será exposta na porta 8080
EXPOSE 8080

# Comando de execução
ENTRYPOINT ["java", "-jar", "/app/escola.jar"]
