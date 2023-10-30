#!/bin/bash
cd ~/minibank-clients
if [ $1 = "blue" ]; then
  docker-compose -f docker-compose.clients.production.yml up --scale clients_blue=0 -d
  docker build -t minibank_clients_test  -f Dockerfile.clients.test .
  docker-compose -f docker-compose.clients.production.yml up --force-recreate -d clients_blue
  docker-compose -f docker-compose.clients.production.yml up -d
elif [ $1 = "green" ]; then
  docker-compose -f docker-compose.clients.production.yml up --scale clients_blue=0 -d
  docker build -t minibank_clients_test  -f Dockerfile.clients.test .
  docker-compose -f docker-compose.clients.production.yml up --force-recreate -d clients_blue
  docker-compose -f docker-compose.clients.production.yml up -d
fi

