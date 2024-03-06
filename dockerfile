# Utilisez une image de base contenant Maven pour construire l'application
FROM maven:3.8.4-openjdk-11 AS builder

# Copiez le code source et le fichier pom.xml dans le conteneur
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Construisez l'application
RUN mvn clean package -DskipTests

# Utilisez une image légère avec Java pour exécuter l'application
FROM openjdk:11-jre-slim

# Créez un répertoire pour l'application
WORKDIR /app

# Copiez le JAR de l'étape de construction dans le conteneur
COPY --from=builder /app/target/meddoc.jar app.jar

# Exposez le port sur lequel votre application s'exécute
EXPOSE 8080

# Commande pour exécuter l'application lors du démarrage du conteneur
CMD ["java", "-jar", "app.jar"]
