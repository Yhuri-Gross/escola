# Etapa 1: Imagem base para o Maven e Java
FROM maven:3.8.7-openjdk-17 AS build

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo pom.xml e baixa as dependências do Maven
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia o código-fonte do projeto para o container
COPY src ./src

# Compila e gera o pacote JAR
RUN mvn clean install -DskipTests

# Etapa 2: Imagem para execução do aplicativo
FROM openjdk:17-jdk-slim

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia o JAR gerado na etapa de build para o container
COPY --from=build /app/target/escola-0.0.1-SNAPSHOT.jar /app/escola.jar

# Expor a porta que a aplicação Spring Boot estará rodando
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "/app/escola.jar"]
