package com.example.Repository;
import com.example.Model.PassMeditation;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.Model.PassExercise;

import java.util.List;

public interface PassMeditationRepository extends JpaRepository<PassMeditation, Long>{
    List<PassMeditation> findByDateofContaining(String date);
}