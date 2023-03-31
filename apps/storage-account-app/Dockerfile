FROM mcr.microsoft.com/openjdk/jdk:17-mariner as build
WORKDIR /app
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

COPY src ./src
RUN ./mvnw package -DskipTests

FROM mcr.microsoft.com/openjdk/jdk:17-distroless
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app.jar
CMD ["-Xmx256m", "-jar", "/app.jar"]

