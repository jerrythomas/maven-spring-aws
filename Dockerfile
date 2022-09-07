FROM openjdk:18-alpine as jar-builder
RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN chmod 700 ./mvnw
RUN ./mvnw clean package -DskipTests

FROM openjdk:18-alpine as execution
COPY --from=jar-builder /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
