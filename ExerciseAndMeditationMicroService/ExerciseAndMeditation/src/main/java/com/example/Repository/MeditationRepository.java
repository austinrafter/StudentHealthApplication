package com.example.Repository;
import com.example.Model.Meditation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MeditationRepository extends JpaRepository<Meditation, Long>{
    List<Meditation> findByMeditationname(String meditationName);
    List<Meditation> findByMeditationtype(String meditationType);
    Meditation getByMeditationid(long meditationId);
}