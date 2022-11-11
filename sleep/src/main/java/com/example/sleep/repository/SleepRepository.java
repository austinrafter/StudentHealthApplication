package com.example.sleep.repository;

import com.example.sleep.model.Sleep;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SleepRepository extends JpaRepository<Sleep, Integer> {
    List<Sleep> findSleepsByOrderByEndDesc();
    List<Sleep> findSleepsByEndAfterOrderByEndDesc(Long after);
    List<Sleep> findSleepsByEndBetweenOrderByEndDesc(Long start, Long end);
}
