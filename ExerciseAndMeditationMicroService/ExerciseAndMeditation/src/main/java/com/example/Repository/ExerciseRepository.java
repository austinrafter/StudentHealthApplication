package com.example.repository;
import com.example.model.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExerciseRepository extends JpaRepository{
    Exercise findByExerciseName(String exerciseName);
    Exercise findByExerciseType(String exerciseType);
}