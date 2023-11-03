#!/bin/sh
docker tag microservice-spring-postgres:1 ewolff/microservice-spring-postgres:latest
docker tag microservice-spring-apache:1 ewolff/microservice-spring-apache:latest
docker tag microservice-spring-shipping:1 ewolff/microservice-spring-shipping:latest
docker tag microservice-spring-invoicing:1 ewolff/microservice-spring-invoicing:latest
docker tag microservice-spring-order:1 ewolff/microservice-spring-order:latest
docker push ewolff/microservice-spring-apache:latest
docker push ewolff/microservice-spring-postgres:latest
docker push ewolff/microservice-spring-shipping:latest
docker push ewolff/microservice-spring-invoicing:latest
docker push ewolff/microservice-spring-order:latest
