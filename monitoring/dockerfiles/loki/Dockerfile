FROM grafana/loki:3.1.1

USER root

RUN apk add --no-cache curl ca-certificates \
  && mkdir -p /loki/chunks /loki/index /loki/cache
