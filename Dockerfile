FROM arturoalcaniz/node-image:latest
RUN --mount=type=secret,id=env \
    git clone "https://$(grep TOKEN_GIT /run/secrets/env | cut -d'=' -f 2-)@github.com/ArturoAlcaniz/PrometheusService.git" /app/PrometheusService/
RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common wget
RUN LATEST=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') && \
    wget https://github.com/prometheus/prometheus/releases/download/$LATEST/prometheus-$LATEST.linux-amd64.tar.gz && \
    tar xvfz prometheus-$LATEST.linux-amd64.tar.gz && \
    mv prometheus-$LATEST.linux-amd64 /app/PrometheusService/prometheus && \
    rm prometheus-$LATEST.linux-amd64.tar.gz
RUN mv /app/PrometheusService/prometheus.yml /app/PrometheusService/prometheus/