#!/bin/sh
docker build --tag=microservice-spring-postgres:1 postgres
docker build --tag=microservice-spring-shipping:1 microservice-spring-shipping
docker build --tag=microservice-spring-invoicing:1 microservice-spring-invoicing
docker build --tag=microservice-spring-order:1 microservice-spring-order
