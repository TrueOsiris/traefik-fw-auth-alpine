# traefik-fw-auth-alpine

[![Docker](https://img.shields.io/badge/GHCR-2496ED?logo=docker&logoColor=white)](https://github.com/TrueOsiris/traefik-fw-auth-alpine/pkgs/container/traefik-fw-auth-alpine)
[![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white)](https://github.com/TrueOsiris/traefik-fw-auth-alpine)
[![Traefik](https://img.shields.io/badge/Traefik-24A1C1?logo=traefik&logoColor=white)](https://traefik.io/)
[![Go](https://img.shields.io/badge/Go-00ADD8?logo=go&logoColor=white)](https://go.dev/)
[![Alpine](https://img.shields.io/badge/Alpine-0D597F?logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
[![GitHub stars](https://img.shields.io/github/stars/TrueOsiris/traefik-fw-auth-alpine?logo=github&label=stars)](https://github.com/TrueOsiris/traefik-fw-auth-alpine)
[![GitHub forks](https://img.shields.io/github/forks/TrueOsiris/traefik-fw-auth-alpine?logo=github&label=forks)](https://github.com/TrueOsiris/traefik-fw-auth-alpine)
[![GitHub open issues](https://img.shields.io/github/issues/TrueOsiris/traefik-fw-auth-alpine?logo=github&label=open%20issues)](https://github.com/TrueOsiris/traefik-fw-auth-alpine/issues)
[![GitHub last-commit](https://img.shields.io/github/last-commit/TrueOsiris/traefik-fw-auth-alpine?logo=github&label=last%20commit)](https://github.com/TrueOsiris/traefik-fw-auth-alpine/commits)

Simple inclusion of traefik-fw-auth into an alpine container, so we can add a healthcheck.<br>
The image is autobuilt every night.

## Docker Compose

``` yaml
  traefik-fw-auth:
    image: ghcr.io/trueosiris/traefik-fw-auth-alpine:latest
    labels:   
      traefik.http.middlewares.traefik-forward-auth.forwardauth.address: http://traefik-forward-auth:4181
      traefik.http.middlewares.traefik-forward-auth.forwardauth.authResponseHeaders: X-Forwarded-User
      traefik.http.services.traefik-forward-auth.loadbalancer.server.port: 4181
    environment:
      - PROVIDERS_GOOGLE_CLIENT_ID=${PROVIDERS_GOOGLE_CLIENT_ID}
      - PROVIDERS_GOOGLE_CLIENT_SECRET=${PROVIDERS_GOOGLE_CLIENT_SECRET}
      - SECRET=testing
      # INSECURE_COOKIE is required if not using a https entrypoint
      - INSECURE_COOKIE=false
      - LOG_LEVEL=info
      - COOKIE_DOMAIN=your.domain
      - AUTH_HOST=authgoogle.your.domain
    ports:
      - 4181:4181
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "1m"
        max-file: "1"      
    networks:
      - proxy      
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "--header=X-Forwarded-Proto: https", "http://localhost:4181/_ping"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 10s
```

## Documentation and Useful info

https://hub.docker.com/r/thomseddon/traefik-forward-auth<br>
https://console.cloud.google.com/apis/credentials?project=traefik-2factor<br>
