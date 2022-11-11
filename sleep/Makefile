# Variables
jarFileName := sleep-0.0.1
packageName := sleep

# Maven
clean:
	./mvnw clean

compile:
	./mvnw compile

run:
	./mvnw spring-boot:run

build:
	./mvnw clean package

run-jar:
	java -jar target/$(jarFileName).jar

# Docker
docker-build: build
	docker build -t $(packageName) .
	docker images

docker-run: docker-build
	docker run --name $(packageName) -td -p 80:8080 $(packageName)
	docker ps

docker-clean:
	docker stop $(packageName)
	docker rm $(packageName)
	docker rmi $(packageName)

docker-shell:
	docker exec -it $(packageName) bash

docker-push:
	docker login
	docker build -t dockersjsupaulnguyen/$(packageName):latest -t dockersjsupaulnguyen/$(packageName):latest .
	docker push dockersjsupaulnguyen/$(packageName):latest

# Pod
pod-run:
	kubectl apply -f pod.yaml

pod-list:
	kubectl get pods

pod-desc:
	kubectl describe pods $(packageName)

pod-delete:
	kubectl delete -f pod.yaml

pod-shell:
	kubectl exec -it $(packageName) -- /bin/bash

pod-logs:
	kubectl logs -f $(packageName)

# service
service-create:
	kubectl create -f service.yaml

service-get:
	kubectl get services

service-get-ip:
	kubectl get service $(packageName) -o wide

service-delete:
	kubectl delete service $(packageName)
