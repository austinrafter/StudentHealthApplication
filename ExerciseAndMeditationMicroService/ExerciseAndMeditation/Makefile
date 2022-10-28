all: docker-run

clean:
	./gradlew clean

compile:
	./gradlew compile

run:
	./gradlew bootRun

gradle-build:
	./gradlew build
docker-run: gradle-build
	java -jar build/libs/ExerciseAndMeditation-1.0.jar

docker-compose-run: gradle-build
	docker build --build-arg JAR_FILE=build/libs/\*.jar -t exerciseandmeditationservice .
	docker-compose up

mysql:
	docker run -d --name mysql -td -p 3306:3306 -e MYSQL_ROOT_PASSWORD=thisismypassword mysql:8.0

mysql-shell:
	docker exec -it exerciseandmeditation-mysqldb-1 bash
	mysql --password