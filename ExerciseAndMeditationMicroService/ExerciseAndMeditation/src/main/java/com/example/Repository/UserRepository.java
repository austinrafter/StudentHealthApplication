package com.example.repository;
import com.example.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository{
    User findByUsername(String userName);
    USer findByEmail(String email);
}