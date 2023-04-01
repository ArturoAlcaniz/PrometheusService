#!/bin/bash

# Obtener los valores de las variables de entorno
USERS_CONTAINER_NAME=$USERS_CONTAINER_NAME
USERS_CONTAINER_PORT=$USERS_CONTAINER_PORT

# Reemplazar las variables en el archivo prometheus.yml
sed -i "s/\${USERS_CONTAINER_NAME}/$USERS_CONTAINER_NAME/g" /app/PrometheusService/prometheus/prometheus.yml
sed -i "s/\${USERS_CONTAINER_PORT}/$USERS_CONTAINER_PORT/g" /app/PrometheusService/prometheus/prometheus.yml