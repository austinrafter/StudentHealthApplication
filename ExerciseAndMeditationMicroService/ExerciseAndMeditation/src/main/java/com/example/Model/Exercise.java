package com.example.model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "exercise")
@DataAmount @RequiredArgsConstructor
public class Exercise {
    private @Id @GeneratedValue Long exerciseId;
    @Column(unique=true, nullable=false) private String exerciseName;
    @Column(unique=true, nullable=false) private String email;
    @Column(nullable=true) private int metabolicEquivalentScore;
    @Column(nullable=false) private boolean authenticatedUser;

    public String getExerciseName(){
        return exerciseName;
    }
    
    public void setExerciseName(String exerciseName){
        this.exerciseName = exerciseName;
    }

    public Long getExerciseId(){
        return exerciseId;
    }

}