package com.example.mentalhealth.mood;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;


@Repository
public interface MentalRepository extends JpaRepository<MentalHealth, Integer> {
    @Query(nativeQuery=true, value="SELECT stress FROM mental_health ORDER BY id DESC LIMIT 7")
    Collection<String> findStress();

    @Query(nativeQuery=true, value="SELECT mood FROM mental_health ORDER BY id DESC LIMIT 7")
    Collection<String> findMood();
}
