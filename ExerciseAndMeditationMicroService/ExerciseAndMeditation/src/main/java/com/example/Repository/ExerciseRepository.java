package com.example.Repository;
import com.example.Model.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExerciseRepository extends JpaRepository{
    Exercise findByExerciseName(String exerciseName);
    Exercise findByExerciseType(String exerciseType);
    Exercise findByMetabolicEquivalentScore(int metabolicEquivalentScore);
}