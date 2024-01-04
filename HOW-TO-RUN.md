# How to Run

This is a step-by-step guide how to run the example:

## Install Docker

Install Docker and [Docker Compose](https://docs.docker.com/compose/install/).

## Build the Applications

This step is optional. You can skip this part and
proceed to "Run the Containers".

* The example is implemented in Java. See
   https://www.java.com/en/download/help/download_options.xml about how
   to download Java. The
   examples need to be compiled so you need to install a JDK (Java
   Development Kit). A JRE (Java Runtime Environment) is not
   sufficient. After the installation you should be able to execute
   `java` and `javac` on the command line.
   You need at least Java 10. 
   
Change to the directory `microservice-spring-demo` and run `./mvnw clean
package` (macOS / Linux) or `mvnw.cmd clean package` (Windows). This will take a while:

```
[~/microservice-spring/microservice-spring-demo]./mvnw clean package
....
[INFO] The original artifact has been renamed to /home/wolff/microservice-spring/microservice-spring-demo/microservice-spring-order/target/microservice-spring-order-0.0.1-SNAPSHOT.jar.original
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for microservice-spring 0.0.1-SNAPSHOT:
[INFO]
[INFO] microservice-spring .................................. SUCCESS [  4.424 s]
[INFO] microservice-spring-shipping ......................... SUCCESS [ 33.489 s]
[INFO] microservice-spring-invoicing ........................ SUCCESS [ 21.327 s]
[INFO] microservice-spring-order ............................ SUCCESS [ 24.298 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:26 min
[INFO] Finished at: 2023-10-24T14:59:35+02:00
[INFO] ------------------------------------------------------------------------
```

If this does not work:

* Ensure that `settings.xml` in the directory `.m2` in your home
directory contains no configuration for a specific Maven repo. If in
doubt: delete the file.

* The tests use some ports on the local machine. Make sure that no
server runs in the background.

* Skip the tests: `./mvnw clean package -Dmaven.test.skip=true` or
  `mvnw.cmd clean package -Dmaven.test.skip=true` (Windows).

* In rare cases dependencies might not be downloaded correctly. In
  that case: Remove the directory `repository` in the directory `.m2`
  in your home directory. Note that this means all dependencies will
  be downloaded again.

## Build the Docker containers

* Go to the directory `microservice-spring-demo` and build the Docker
  containers: 
```
[~/microservice-spring/microservice-spring-demo/postgres]docker-compose build
...
Building prometheus
[+] Building 1.5s (7/7) FINISHED
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 121B                                                                               0.0s
 => [internal] load metadata for docker.io/prom/prometheus:v2.47.2                                                 1.5s
 => [internal] load build context                                                                                  0.0s
 => => transferring context: 36B                                                                                   0.0s
 => [1/2] FROM docker.io/prom/prometheus:v2.47.2@sha256:3002935850ea69a59816825d4cb718fafcdb9b124e4e6153ebc689462  0.0s
 => CACHED [2/2] ADD prometheus.yml  /etc/prometheus/                                                              0.0s
 => exporting to image                                                                                             0.0s
 => => exporting layers                                                                                            0.0s
 => => writing image sha256:fe7653ec96e872024bff7bc0dd612235c312737c10f84ccfcb3854f3719e0260                       0.0s
 => => naming to docker.io/spring-microservices/prometheus:latest
```

## Run the microservices system

* Go to the directory `microservice-spring-demo` and start the
  microservices system:

```
[~/microservice-spring/microservice-spring-demo/postgres]docker-compose up
Starting microservice-spring-demo_zipkin_1 ... done
Starting spring-postgres                   ... done
Starting spring-order                      ... done
Starting spring-invoicing                  ... done
Starting spring-shipping                   ... done
Starting spring-prometheus                 ... done
...
```

* Open `index.html`. It contains links to the web applications.

## Tracing

* Zipkin can be accessed at [http://localhost:9412](http://localhost:9412).

## Metrics with Prometheus

* Open [http://localhost:9090](http://localhost:9090) to access
  Prometheus.

## Metric with Grafana

Grafana provides Dashboards for the metrics stored in Prometheus.

* Open Grafana at [http://localhost:3000/](http://localhost:3000/).
* Log in with user account `admin` and password `admin`.
* Configure Prometheus as a datasource
  * Toggle the menu with the three bars at the top left
  * Select `Connections`
  * Select `Add new connection`
  * Select `Prometheus`
  * Click on `Add new data source` at the top right.
  * Select`Prometheus` as the `Name`
  * `Default` should be on.
  * The `Prometheus server URL` will be `http://prometheus:9090`
  * Select `Skip TLS Verify`.
  * Click `Save & Test` to make sure the connection works.
* You can import Grafana dashboards.
  * Go to the [Grafana home page](http://localhost:3000).
  * Click on `Dashboards`
  * Click on `New` at the to right.
  * Click on `Import`
  * Click on `Upload dashboard JSON file`
  * Select the JSON file `Spring Microservices Overview Dashboard.json` from this repo.
* You can now access the dashboards from Home - Dashboard.
* Add some load using `./load.sh "-X POST http://localhost:18082/poll" &`

## Resilience with resilience4j

* You might need to remove the previous demo with `docker-compose
  down`. Otherwise there are e.g. naming conflicts for containers.
* Start the system with `docker-compose -f fail.yaml up`.
* With this configuration, half of the HTTP request to the order
  microservice will fail. Go to
  [http://localhost:18081/](http://localhost:18081/) and reload the
  page 
  a few times to see that the HTTP request really fails. The log
  output also shows that some of the calls fail.
* Now poll for new orders from the shipping or invoicing
  applications at [http://localhost:18082/](http://localhost:18082/)
  and [http://localhost:18083/](http://localhost:18083/). Notice how
  the order application still fails randomly 
  but the polling never fails. This is because of the retry in the
  poller. The source code actually contains a `@Retry` annotation.
* resilience4j provides more features e.g. bulkhead, circuit breaker,
  rate limiter or time limiter i.e. timeouts. See
  [https://github.com/resilience4j/resilience4j-spring-boot3-demo/](https://github.com/resilience4j/resilience4j-spring-boot3-demo/)
  for a demo of these features.

## Run on Kubernetes

### Build containers locally

* Build the containers using `docker-build.sh`.
* Deploy the infrastructure using `kubectl apply -f
  infrastructure.yaml`
* Deploy the microservices using `kubectl apply -f microservices.yaml`
* Start the service proxies using `service-proxy.sh`.
* Open `index.html`. It contains links to the web applications.

### Cleanup
-------------------

You can remove the infrastructure and microservices using:

```shell
kubectl delete -f microservices.yaml
kubectl delete -f infrastructure.yaml 
```
