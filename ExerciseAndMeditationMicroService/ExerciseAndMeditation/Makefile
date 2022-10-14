all: docker-run

gradle-build:
	./gradlew clean build
docker-run: gradle-build
	java -jar build/libs/ExerciseAndMeditation-1.0.jar

docker-compose-run: gradle-build
	docker build --build-arg JAR_FILE=build/libs/\*.jar -t exerciseandmeditationservice .
	docker-compose up