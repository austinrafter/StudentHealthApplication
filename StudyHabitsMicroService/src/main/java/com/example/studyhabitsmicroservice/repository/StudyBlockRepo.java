package com.example.studyhabitsmicroservice.repository;

import com.example.studyhabitsmicroservice.model.Activity;
import com.example.studyhabitsmicroservice.model.StudyBlock;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface StudyBlockRepo extends MongoRepository<StudyBlock, String> {

}
