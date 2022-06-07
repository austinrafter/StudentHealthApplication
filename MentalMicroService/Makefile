all: clean

clean:
	./mvnw clean

build:
	./mvnw package

site:
	./mvnw surefire-report:report

test:
	./mvnw test

run:
	java -jar target/spring-payments-1.0.jar

# Docker
docker-build: build
	docker build -t spring-payments .
	docker images

docker-run: docker-build
	docker run --network finalpayments --name spring-payments -p 90:9090  \
    	-e "api_endpoint=http://spring-payments-api:8080/" -td spring-payments

docker-push:
	docker login
	docker build -t syuan118/spring-payments:v1.0 -t syuan118/spring-payments:v1.0 .
	docker push syuan118/spring-payments:v1.0


# Compose

network-ls:
	docker network ls

network-create:
	docker network create --driver bridge $(network)

network-prune:
	docker network prune

compose-up:
	docker-compose up --scale payments=3 -d

compose-down:
	docker-compose down

lb-stats:
	echo "user = admin | password = admin"
	open http://localhost:1936

lb-test:
	open http://localhost
