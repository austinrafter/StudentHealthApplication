package com.example.Repository;
import com.example.Model.Meditation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MeditationRepository extends JpaRepository{
    Meditation findByMeditationName(String meditationName);
    Meditation findByMeditationType(String meditationType);
}