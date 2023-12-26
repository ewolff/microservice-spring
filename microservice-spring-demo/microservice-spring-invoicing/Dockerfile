FROM eclipse-temurin:21-jre-alpine
COPY target/microservice-spring-invoicing-0.0.1-SNAPSHOT.jar .
CMD java -Xmx300m -Xms300m -XX:TieredStopAtLevel=1 -noverify -jar microservice-spring-invoicing-0.0.1-SNAPSHOT.jar
EXPOSE 8082
