FROM arturoalcaniz/node-image:latest
RUN --mount=type=secret,id=env \
    git clone "https://$(grep TOKEN_GIT /run/secrets/env | cut -d'=' -f 2-)@github.com/ArturoAlcaniz/PrometheusService.git" /app/PrometheusService/
RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common wget
RUN apt-get install -y coreutils
RUN LATEST=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') && \
    PROMETHEUS_URL=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest \
    | grep browser_download_url \
    | grep linux-amd64 \
    | cut -d '"' -f 4) && \
    PROMETHEUS_FILENAME=$(basename "$PROMETHEUS_URL") && \
    wget $PROMETHEUS_URL && \
    tar xvfz $PROMETHEUS_FILENAME && \
    mv ${PROMETHEUS_FILENAME%.tar.gz} /app/PrometheusService/prometheus && \
    rm $PROMETHEUS_FILENAME
RUN LATEST=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') && \
    PROMETHEUS_URL=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest \
    | grep browser_download_url \
    | grep linux-amd64 \
    | cut -d '"' -f 4) && \
    PROMETHEUS_FILENAME=$(basename "$PROMETHEUS_URL") && \
    wget $PROMETHEUS_URL && \
    tar xvfz $PROMETHEUS_FILENAME && \
    mv ${PROMETHEUS_FILENAME%.tar.gz} /app/PrometheusService/prometheus && \
    rm $PROMETHEUS_FILENAME
RUN mv /app/PrometheusService/prometheus.yml /app/PrometheusService/prometheus/