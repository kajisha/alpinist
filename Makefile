.PONY: build run
.DEFAULT_GOAL := run

build: Dockerfile
	docker build -t kajisha/alpinist .

pull:
	docker-compose pull

run: pull
	docker-compose run -u app --service-ports --rm alpine bash -i || return 1
