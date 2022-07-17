package com.example.studyhabitsmicroservice.controller;

import com.example.studyhabitsmicroservice.model.StudyBlock;
import org.springframework.data.jpa.repository.JpaRepository;

interface StudyBlockRepo extends JpaRepository<StudyBlock, Long> {

}