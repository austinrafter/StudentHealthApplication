package com.example.model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "meditation")
@DataAmount @RequiredArgsConstructor
public class Meditation {
    private @Id @GeneratedValue Long meditationId;
    @Column(unique=true, nullable=false) private String meditationName;
    @Column(nullable=false) private String meditationType;
    @Column(nullable=true) private int metabolicEquivalentScore;

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