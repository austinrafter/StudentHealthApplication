all: docker-run

gradle-docker-build-exercise:
	cd ExerciseAndMeditationMicroService && cd ExerciseAndMeditation && ./gradlew clean build && docker build --build-arg JAR_FILE=build/libs/\*.jar -t exerciseandmeditationservice . && cd .. && cd ..

maven-build-mentalhealth: gradle-docker-build-exercise
	cd mentalhealth && ./mvnw package && docker build -t mentalhealth . && cd ..

docker-compose-run: maven-build-mentalhealth
	docker-compose up