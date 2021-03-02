# Base system
FROM alpine:3.13 as base

# Download argocd
FROM base as download-argocd

RUN apk update && apk upgrade
RUN apk add curl

ARG ARGOCD_VERSION
RUN echo "version: $ARGOCD_VERSION"
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

RUN argocd version --client

FROM base

COPY --from=download-argocd /usr/local/bin/argocd /usr/local/bin/argocd

RUN apk update && apk upgrade
RUN apk add jq