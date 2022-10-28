package com.example.Repository;
import com.example.Model.PassMeditation;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.Model.PassExercise;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PassMeditationRepository extends JpaRepository<PassMeditation, Long>{
    List<PassMeditation> findByDateofContaining(String date);
    @Query(nativeQuery=true, value="SELECT totaltime FROM passmeditation ORDER BY passmeditationid DESC LIMIT 7")
    Collection<Integer> findMeditationCount();
}