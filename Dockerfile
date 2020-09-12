FROM rjkernick/alpine-wget:latest as builder

WORKDIR /tmp

COPY ./plugins.txt .

RUN cat plugins.txt | \
    xargs -n 1 -P 8 wget --no-check-certificate --no-verbose && \
    rm plugins.txt

FROM alpine

WORKDIR /plugins

COPY --from=builder /tmp/* ./

RUN mkdir -p /tmp/scripts

COPY install_plugins.sh /tmp/scripts/
