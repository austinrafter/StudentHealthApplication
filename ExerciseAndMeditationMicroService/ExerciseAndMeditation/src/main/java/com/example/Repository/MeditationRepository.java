package com.example.repository;
import com.example.model.Meditation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MeditationRepository extends JpaRepository{
    Meditation findByMeditationName(String meditationName);
    Meditation findByMeditationType(String meditationType);
}