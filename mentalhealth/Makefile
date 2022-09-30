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
	java -jar target/mentalhealth-1.0.jar

# Docker
docker-build: build
	docker build -t mentalhealth .
	docker images

docker-run: docker-build
	docker run --network healthone -e "MYSQL_HOST=mysql" --name mentalhealth -td -p 80:8080 mentalhealth
	docker ps

mysql:
	docker run -d --network healthone --name mysql -td -p 3306:3306 -e MYSQL_ROOT_PASSWORD=healthone mysql:8.0

docker-clean:
	docker stop mentalhealthe
	docker rm mentalhealthe
	docker rmi mentalhealthe

docker-shell:
	docker exec -it mentalhealth bash

docker-push:
	docker login
	docker build -t syuan118/mentalhealth:v1 -t syuan118/mentalhealth:v1 .
	docker push syuan118/mentalhealth:v1

# Pod

pod-run:
	kubectl apply -f pod.yaml

pod-list:
	kubectl get pods

pod-desc:
	kubectl describe pods mentalhealthe

pod-delete:
	kubectl delete -f pod.yaml

pod-shell:
	kubectl exec -it mentalhealth -- /bin/bash

pod-logs:
	kubectl logs -f mentalhealthe

# Service

service-create:
	kubectl create -f service.yaml

service-get:
	kubectl get services

service-get-ip:
	kubectl get service mentalhealth -o wide

service-delete:
	kubectl delete service mentalmcroservice

# Deployment

deployment-create:
	kubectl create -f deployment.yaml --save-config

deployment-get:
	kubectl get deployments

deployment-get-pods:
	kubectl get pods -l name=mentalhealthe

deployment-pod-shell:
	kubectl exec -it $(pod) -- /bin/bash

deployment-upgrade:
	kubectl apply  -f deployment.yaml

deployment-delete:
	kubectl delete deployment mentalhealth-deployment


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
	kubectl get service mentalhealth -o wide

service-delete:
	kubectl delete service mentalhealthe

# Ingress

ingress-apply:
	kubectl apply -f ingress.yaml

ingress-ip:
	kubectl get ingress mentalhealth-ingress
