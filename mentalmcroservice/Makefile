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
	java -jar target/mentalmicroservice-1.0.jar

# Docker
docker-build: build
	docker build -t mentalmicroservice .
	docker images

docker-run: docker-build
	docker run --name mentalmicromervice -td -p 80:8080 mentalmicroservice --network healthone -e "MYSQL_HOST=mysql"
	docker ps

mysql:
	docker run -d --network healthone --name mysql -td -p 3306:3306 -e MYSQL_ROOT_PASSWORD=healthone mysql:8.0

docker-clean:
	docker stop mentalmicroservice
	docker rm mentalmicroservice
	docker rmi mentalmicroservice

docker-shell:
	docker exec -it mentalmicroservice bash

docker-push:
	docker login
	docker build -t syuan118/mentalmicroservice:v1 -t syuan118/mentalmicroservice:v1 .
	docker push syuan118/mentalmicroservice:v1

# Pod

pod-run:
	kubectl apply -f pod.yaml

pod-list:
	kubectl get pods

pod-desc:
	kubectl describe pods mentalmicroservice

pod-delete:
	kubectl delete -f pod.yaml

pod-shell:
	kubectl exec -it mentalmicroservice -- /bin/bash

pod-logs:
	kubectl logs -f mentalmicroservice

# Service

service-create:
	kubectl create -f service.yaml

service-get:
	kubectl get services

service-get-ip:
	kubectl get service mentalmicroservice -o wide

service-delete:
	kubectl delete service mentalmicroservice

# Deployment

deployment-create:
	kubectl create -f deployment.yaml --save-config

deployment-get:
	kubectl get deployments

deployment-get-pods:
	kubectl get pods -l name=mentalmicroservice

deployment-pod-shell:
	kubectl exec -it $(pod) -- /bin/bash

deployment-upgrade:
	kubectl apply  -f deployment.yaml

deployment-delete:
	kubectl delete deployment mentalmicroservice-deployment


# Compose

network-ls:
	docker network ls

network-create:
	docker network create --driver bridge healthone

network-prune:
	docker network prune

compose-up:
	docker-compose up --scale gumball=2 -d

compose-down:
	docker-compose down

lb-stats:
	echo "user = admin | password = admin"
	open http://localhost:1936

lb-test:
	open http://localhost

# Service

service-create:
	kubectl create -f service.yaml

service-get:
	kubectl get services

service-get-ip:
	kubectl get service mentalmicroservice -o wide

service-delete:
	kubectl delete service mentalmicroservice

# Ingress

ingress-apply:
	kubectl apply -f ingress.yaml

ingress-ip:
	kubectl get ingress mentalmicroservice-ingress
