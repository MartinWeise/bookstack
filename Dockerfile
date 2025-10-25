FROM docker.io/alpine:3 AS runtime
LABEL org.opencontainers.image.authors="martinweiseat@gmail.com"

RUN apk --no-cache \
    add \
    bash

USER 1001