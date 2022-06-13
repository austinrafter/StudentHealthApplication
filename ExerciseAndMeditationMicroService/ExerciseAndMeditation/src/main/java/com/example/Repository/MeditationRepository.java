package com.example.Repository;
import com.example.Model.Meditation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MeditationRepository extends JpaRepository<Meditation, Long>{
    //List<Meditation> findByMeditationName(String meditationName);
    //List<Meditation> findByMeditationType(String meditationType);
    //Meditation getByMeditationId(long meditationId);
}