package com.example.Controller;

import com.example.Model.StudyBlock;
import org.springframework.data.jpa.repository.JpaRepository;

interface StudyBlockRepo extends JpaRepository<StudyBlock, Long> {

}