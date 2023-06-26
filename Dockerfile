# Imagem base do Crystal
FROM crystallang/crystal:1.8.2-alpine AS dev

WORKDIR /usr/src/dev-api

EXPOSE 3000

COPY . .

RUN shards install
RUN crystal build --release lib/sentry/src/sentry_cli.cr -o ./sentry

# Comando para iniciar a aplicação a partir do sentry
ENTRYPOINT make sam db:setup && make generate_docs && ./sentry

# ─────────────────────────────────────────────────────

FROM crystallang/crystal:1.8.2-alpine AS build

WORKDIR /usr/src/build-api

COPY . .

RUN shards install --production
RUN crystal build --static --release src/api.cr -o bin/api

# ─────────────────────────────────────────────────────

FROM alpine:3.18.2 as prod

EXPOSE 3000

WORKDIR /usr/src/api

# Copia os arquivos da fase anterior (build)
COPY --from=build /usr/src/build-api .

RUN apk add --no-cache make
RUN apk add --no-cache crystal shards
RUN apk add --no-cache libressl-dev
RUN apk add --no-cache libxml2-dev
RUN apk add --no-cache yaml-dev

# Comando para iniciar a aplicação
ENTRYPOINT make generate_docs && ./bin/api
