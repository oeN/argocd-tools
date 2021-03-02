# Base system
FROM alpine:3.13 as base

# Download argocd
FROM base as download-argocd

RUN apk update && apk upgrade
RUN apk add curl

ARG VERSION
RUN VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'); \
  echo "version: $VERSION"; \
  curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

RUN argocd version --client

FROM base

COPY --from=download-argocd /usr/local/bin/argocd /usr/local/bin/argocd

RUN apk update && apk upgrade
RUN apk add jq