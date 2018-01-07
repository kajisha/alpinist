.PONY: build run
.DEFAULT_GOAL := run

build: Dockerfile
	docker build -t kajisha/alpinist .

run:
	docker-compose run --rm alpine su - app || return 1
