.PHONY: up stop down build install init reset

include .env
export $(shell sed 's/=.*//' .env)

up:
	@docker-compose up -d

stop:
	@docker-compose stop

down:
	@docker-compose down

build:
	@docker-compose build

install:
	@docker exec --user root -i $${COMPOSE_PROJECT_NAME}_php-fpm_1 bash -c "install"

init: up install

reset: down
	@echo "Deleting volumes for ${COMPOSE_PROJECT_NAME} project:"
	@docker volume rm $${COMPOSE_PROJECT_NAME}_database
	make init