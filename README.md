Microservice Spring Sample
=====================


This demo uses [Spring Boot](https://spring.io/projects/spring-boot)
to solve the typical problems of microservices.

This project creates a complete microservice demo system.
are implemented in Java using Spring Boot.

It uses three microservices:
- `Order` to accept orders.
- `Shipping` to ship the orders.
- `Invoicing` to ship invoices.

How to run
---------

See [How to run](HOW-TO-RUN.md).


Video
--------

Check out the video [Microservices with Spring](https://www.youtube.com/watch?v=9q2Qlp0IDZY) (German with auto-translated subtitles in your preferred language).


Remarks on the Code
-------------------

The microservices are: 
- [microservice-spring-order](microservice-spring-demo/microservice-spring-order) to create the orders
- [microserivce-spring-shipping](microservice-spring-demo/microservice-spring-shipping) for the shipping
- [microservice-spring-invoicing](microservice-spring-demo/microservice-spring-invoicing) for the invoices

The microservices have an Java main application in `src/test/java` to
run them stand alone. microservice-demo-shipping and
microservice-demo-invoicing both use a stub for the
other order service for the tests.

The data of an order is copied - including the data of the customer
and the items. So if a customer or item changes in the order system
this does not influence existing shipments and invoices. It would be
odd if a change to a price would also change existing invoices. Also
only the information needed for the shipment and the invoice are
copied over to the other systems.

The job to poll the order feed is run every 30 seconds.


Shutdown Kubernetes
-------------------

You can shut down the Kubernetes infrastructure and microservices using:

```shell
kubectl delete -f microservices.yaml  
kubectl delete -f infrastructure.yaml 
```

