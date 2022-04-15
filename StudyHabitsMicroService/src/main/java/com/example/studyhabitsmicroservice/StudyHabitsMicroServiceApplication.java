package com.example.studyhabitsmicroservice;

import com.example.studyhabitsmicroservice.repository.ActivityRepo;
import com.example.studyhabitsmicroservice.repository.ClassRepo;
import com.example.studyhabitsmicroservice.repository.StudyBlockRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableMongoRepositories
public class StudyHabitsMicroServiceApplication {

    @Autowired
    ActivityRepo activityRepo;
    @Autowired
    ClassRepo classRepo;
    @Autowired
    StudyBlockRepo studyBlockRepo;

    public static void main(String[] args) {
        SpringApplication.run(StudyHabitsMicroServiceApplication.class, args);
    }

}
