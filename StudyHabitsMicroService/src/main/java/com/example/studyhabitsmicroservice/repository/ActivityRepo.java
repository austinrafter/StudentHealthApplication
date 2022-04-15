package com.example.studyhabitsmicroservice.repository;

import com.example.studyhabitsmicroservice.model.Activity;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ActivityRepo extends MongoRepository<Activity, String> {

}
