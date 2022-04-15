package com.example.Repository;
import com.example.Model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository{
    Student findByUsername(String userName);
    Student findByEmail(String email);
}
