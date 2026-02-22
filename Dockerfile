FROM thomseddon/traefik-forward-auth:2 AS binary

FROM alpine:3.19
RUN apk add --no-cache ca-certificates wget
COPY --from=binary /traefik-forward-auth /traefik-forward-auth
ENTRYPOINT ["/traefik-forward-auth"]
