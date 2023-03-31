#!/bin/bash
# Script to be executed just once, when the system is installed.
# Commands are only run once even if the script is called multiple times.
dockerd > /dev/null 2>&1 &
/app/PrometheusService/prometheus/node_exporter/node_exporter --web.listen-address=":9100" >/dev/null 2>&1 & /app/PrometheusService/prometheus/prometheus --config.file=/app/PrometheusService/prometheus/prometheus.yml