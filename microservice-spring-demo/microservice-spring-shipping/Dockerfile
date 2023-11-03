FROM eclipse-temurin:20.0.1_9-jre-alpine
COPY target/microservice-spring-shipping-0.0.1-SNAPSHOT.jar .
CMD java -Xmx300m -Xms300m -XX:TieredStopAtLevel=1 -noverify -jar microservice-spring-shipping-0.0.1-SNAPSHOT.jar --spring.datasource.url=jdbc:postgresql://postgres:5432/dbinvoicing
EXPOSE 8083