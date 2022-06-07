package com.example.mentalhealth.mood;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MentalRepository extends JpaRepository<MentalHealth, Integer> {

}
