FROM ghcr.io/neosperience/shipper:0.3 as shipper
FROM argoproj/argocd:latest
# TODO: use a smaller base image and install just the argocd cli but you need to fix this error before
# time="2021-03-19T12:19:34Z" level=fatal msg="rpc error: code = Internal desc = transport: received the unexpected content-type \"text/plain; charset=utf-8\"

USER root

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        jq \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY --from=shipper /usr/local/bin/shipper /usr/local/bin/shipper
USER argocd
