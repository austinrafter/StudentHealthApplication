all: docker-run

docker-run:
	./gradlew clean build && java -jar build/libs/ExerciseAndMeditation-1.0.jar

docker-compose-run:
	docker build --build-arg JAR_FILE=build/libs/\*.jar -t exerciseandmeditationservice .
	docker-compose up