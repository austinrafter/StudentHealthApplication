package com.example.Controller;

import com.example.Model.StudentClass;
import org.springframework.data.jpa.repository.JpaRepository;

interface StudentClassRepo extends JpaRepository<StudentClass, Long> {

}
