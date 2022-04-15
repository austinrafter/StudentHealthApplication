package com.example.studyhabitsmicroservice.repository;

import com.example.studyhabitsmicroservice.model.Activity;
import com.example.studyhabitsmicroservice.model.StudentClass;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ClassRepo extends MongoRepository<StudentClass, String> {

}
