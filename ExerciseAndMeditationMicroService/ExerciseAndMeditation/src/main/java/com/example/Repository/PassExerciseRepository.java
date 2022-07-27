package com.example.Repository;
import com.example.Model.PassExercise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PassExerciseRepository extends JpaRepository<PassExercise, Long>{
   List<PassExercise> findByDateofContaining(String date);
}