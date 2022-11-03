package com.example.mentalhealth.exercisemental;
import com.example.mentalhealth.exercisemental.PassExercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PassExerciseRepository extends JpaRepository<PassExercise, String>{
   @Query(nativeQuery=true, value="SELECT totaltime FROM passexercise ORDER BY passexerciseid DESC LIMIT 7")
   Collection<Integer> findExerciseCount();
}