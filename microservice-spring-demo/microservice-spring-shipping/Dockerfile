FROM docker.io/eclipse-temurin:24-jre-alpine
COPY target/microservice-spring-shipping-0.0.1-SNAPSHOT.jar .
CMD java -Xmx300m -Xms300m -XX:TieredStopAtLevel=1 -noverify -jar microservice-spring-shipping-0.0.1-SNAPSHOT.jar
EXPOSE 8083
