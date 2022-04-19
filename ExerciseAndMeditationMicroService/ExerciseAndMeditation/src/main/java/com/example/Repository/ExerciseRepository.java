package com.example.Repository;
import com.example.Model.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long>{
    List<Exercise> findByExerciseName(String exerciseName);
    List<Exercise> findByExerciseType(String exerciseType);
    List<Exercise> findByMetabolicEquivalentScore(int metabolicEquivalentScore);
    Exercise findByExerciseId(long exerciseId);
}