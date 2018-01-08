.PONY: build start stop pull run
.DEFAULT_GOAL := run

build: Dockerfile
	docker build -t kajisha/alpinist .

start:
	docker-compose up -d

stop:
	docker-compose stop

pull:
	docker-compose pull

run: pull start
	docker-compose exec -u app alpine bash -i
