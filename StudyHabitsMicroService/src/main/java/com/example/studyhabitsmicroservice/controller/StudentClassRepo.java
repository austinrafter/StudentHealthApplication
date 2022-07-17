package com.example.studyhabitsmicroservice.controller;

import com.example.studyhabitsmicroservice.model.StudentClass;
import org.springframework.data.jpa.repository.JpaRepository;

interface StudentClassRepo extends JpaRepository<StudentClass, Long> {

}
