package com.example.Controller;

import com.example.Model.Activity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;

interface ActivityRepo extends JpaRepository<Activity, Long> {
    @Query(nativeQuery=true, value="SELECT duration FROM activity ORDER BY id DESC LIMIT 7")
    Collection<Long> findStudyAmount();
}