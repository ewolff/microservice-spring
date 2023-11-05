#!/bin/bash

# Define a function to handle cleanup
cleanup() {
  echo "Cleaning up and stopping child processes..."
  # Terminate all child processes
  kill $(jobs -p)
  exit 0
}

# Register the cleanup function to execute on Ctrl+C (SIGINT)
trap cleanup SIGINT

# Start your child processes in the background
# Example: Start three background processes
echo Order http://localhost:18081/
kubectl port-forward service/spring-order 18081:8080 &
echo Shipping http://localhost:18083/
kubectl port-forward service/spring-shipping 18083:8080 &
echo Invoicing http://localhost:18082/
kubectl port-forward service/spring-invoicing 18082:8080 &

# Wait for all background processes to complete
wait
