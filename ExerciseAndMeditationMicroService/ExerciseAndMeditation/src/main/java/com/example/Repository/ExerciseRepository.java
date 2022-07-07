package com.example.Repository;
import com.example.Model.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long>{
    List<Exercise> findByExercisename(String exercisename);
    //List<Exercise> findByExercise_type(String exercise_type);
    //List<Exercise> findByMetabolic_equivalent_score(int metabolicEquivalentScore);
    //Exercise findByExercise_id(long exerciseId);
}