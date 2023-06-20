# Imagem base do Crystal
FROM crystallang/crystal:1.8.2-alpine AS dev

WORKDIR /usr/src/dev-api

EXPOSE 3000

COPY . .

RUN shards install
RUN crystal build --release lib/sentry/src/sentry_cli.cr -o ./sentry

# Comando para iniciar a aplicação a partir do sentry
ENTRYPOINT ./sentry

# ─────────────────────────────────────────────────────

FROM crystallang/crystal:1.8.2-alpine AS build

WORKDIR /usr/src/build-api

COPY . .

RUN shards install --production
RUN crystal build --static --release src/api.cr -o bin/api

# ─────────────────────────────────────────────────────

FROM alpine:latest as prod

EXPOSE 3000

WORKDIR /usr/src/api

# Copia o executável compilado da fase anterior (build)
COPY --from=build /usr/src/build-api/bin .

# Comando para iniciar a aplicação
ENTRYPOINT ./api
