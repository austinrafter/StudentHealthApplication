package com.example.mentalhealth.exercisemental;
import com.example.mentalhealth.exercisemental.PassMeditation;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.mentalhealth.exercisemental.PassExercise;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PassMeditationRepository extends JpaRepository<PassMeditation, Long>{
    @Query(nativeQuery=true, value="SELECT totaltime FROM passmeditation ORDER BY passmeditationid DESC LIMIT 7")
    Collection<Integer> findMeditationCount();
}