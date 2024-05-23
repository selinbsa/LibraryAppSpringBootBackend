FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app
# cp app

COPY ./pom.xml /app
# cp package.json /app/package.json

COPY ./src /app/src
# cp ./src /app/src

RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:17-jdk

WORKDIR /app
# cd app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
# npm run dev