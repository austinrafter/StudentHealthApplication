package com.example.Repository;
import com.example.Model.PassMeditation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PassMeditationRepository extends JpaRepository<PassMeditation, Long>{
}