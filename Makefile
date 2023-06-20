# Para executar os comandos abaixo, basta digitar no terminal:
# make <command>

# Exemplo: make compose_up_dev


# ─────────────────────────────────────────────────────
# Scripts para o ambiente Docker de desenvolvimento

compose_up_dev:
	docker-compose -f docker-compose.dev.yml up -d

compose_down_dev:
	docker-compose -f docker-compose.dev.yml down --remove-orphans

compose_rm_images_dev:
	docker image rm dev_api_multiverse_travels_booker

# ─────────────────────────────────────────────────────
# Scripts para o ambiente Docker de produção

compose_up_prod:
	docker-compose up -d

compose_down_prod:
	docker-compose down --remove-orphans

compose_rm_images_prod:
	docker image rm api_multiverse_travels_booker

# ─────────────────────────────────────────────────────
# Outros scripts

install_dependencies:
	shards install && make install_sentry

start_dev:
	./sentry

build:
	crystal build --static --release src/api.cr -o bin/api

start:
	./bin/api

format:
	crystal tool format

test:
	crystal spec

install_sentry:
	crystal build --release lib/sentry/src/sentry_cli.cr -o ./sentry

generate_docs:
	crystal docs --output public/docs src/api.cr
