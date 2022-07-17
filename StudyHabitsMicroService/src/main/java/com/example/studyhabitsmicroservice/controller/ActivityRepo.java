package com.example.studyhabitsmicroservice.controller;

import com.example.studyhabitsmicroservice.model.Activity;
import org.springframework.data.jpa.repository.JpaRepository;

interface ActivityRepo extends JpaRepository<Activity, Long> {

}
