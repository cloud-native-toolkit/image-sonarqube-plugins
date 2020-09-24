FROM rjkernick/alpine-wget:latest as builder

WORKDIR /tmp

COPY ./plugins.txt .

RUN cat plugins.txt | \
    xargs -n 1 -P 8 wget --no-check-certificate --no-verbose && \
    rm plugins.txt

FROM bitnami/nginx

WORKDIR /app

COPY --from=builder /tmp/* ./
