package com.example.Repository;
import com.example.Model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentRepository extends JpaRepository{
    List<Student> findByUsername(String userName);
    List<Student> findByEmail(String email);
}
