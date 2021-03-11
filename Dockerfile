# Base system
FROM debian:buster as base

# Download argocd
FROM base as download-argocd

RUN apt update && apt upgrade -y
RUN apt install curl -y

ARG ARGOCD_VERSION
RUN echo "version: $ARGOCD_VERSION"
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

RUN argocd version --client

FROM base

COPY --from=download-argocd /usr/local/bin/argocd /usr/local/bin/argocd

RUN apt update && apt upgrade -y
RUN apt install jq -y