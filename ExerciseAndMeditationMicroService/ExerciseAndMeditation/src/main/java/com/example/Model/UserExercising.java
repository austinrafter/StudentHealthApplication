package com.example.Model;

import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "userexercise")
public class UserExercising {

    @Id
    Long userExercisingId;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "exercise_id")
    Exercise exercise;

    LocalDateTime startedAt;
    LocalDateTime endedAt;

    int caloriesBurned;

    // additional properties
    // standard constructors, getters, and setters

    public int getCaloriesBurned(){
        return caloriesBurned;
    }

    public LocalDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(LocalDateTime startedAt){
        this.startedAt = startedAt;
    }

    public LocalDateTime getEndedAt() {
        return endedAt;
    }

    public void setEndedAt(LocalDateTime endedAt){
        this.endedAt = endedAt;
    }

    public Long getUserExercisingId(){
        return userExercisingId;
    }
}