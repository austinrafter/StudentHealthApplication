package com.example.Repository;
import com.example.Model.PassExercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PassExerciseRepository extends JpaRepository<PassExercise, String>{
   List<PassExercise> findByDateofContaining(String date);
   @Query(nativeQuery=true, value="SELECT totaltime FROM passexercise ORDER BY passexerciseid DESC LIMIT 7")
   Collection<Integer> findExerciseCount();
}