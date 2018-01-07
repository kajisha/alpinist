.PONY: build run
.DEFAULT_GOAL := run

build: Dockerfile
	docker build -t kajisha/alpinist .

pull:
	docker-compose pull

run: pull
	docker-compose run --rm alpine su - app || return 1
