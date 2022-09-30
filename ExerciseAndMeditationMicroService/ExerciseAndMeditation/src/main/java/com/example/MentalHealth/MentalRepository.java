package com.example.MentalHealth;
/**
 * Used from Sophia Yuans mental health section for singular project testing
 */
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MentalRepository extends JpaRepository<MentalHealth, Integer> {

}
