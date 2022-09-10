docker-run:
    ./gradlew clean build && java -jar build/libs/gs-spring-boot-docker-0.1.0.jar
    docker build --build-arg JAR_FILE=build/libs/\*.jar -t exerciseandmeditationservice .
    docker-compose up