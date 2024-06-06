FROM public.ecr.aws/docker/library/maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM public.ecr.aws/docker/library/openjdk:17
WORKDIR /app
COPY --from=build /app/target/*jar-with-dependencies.jar revfieldrevhire.jar
EXPOSE 8000

ENTRYPOINT ["java", "-jar", "revfieldrevhire.jar"]