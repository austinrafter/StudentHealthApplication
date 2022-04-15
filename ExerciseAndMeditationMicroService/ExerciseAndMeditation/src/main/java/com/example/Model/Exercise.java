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
    @Column(nullable=false) private String exerciseType;
    @Column(nullable=true) private int metabolicEquivalentScore;

    @OneToMany(mappedBy = "exercise")
    Set<UserExercising> exercises;

    @OneToMany(mappedBy = "exercise")
    Set<HealthConditionPreventsExercise> healthConditionPreventsExerciseSet;

    public String getExerciseName(){
        return exerciseName;
    }
    
    public void setExerciseName(String exerciseName){
        this.exerciseName = exerciseName;
    }

    public String getExerciseType(){
        return exerciseType;
    }

    public void setExerciseType(String exerciseType){
        this.exerciseType = exerciseType;
    }

    public Long getExerciseId(){
        return exerciseId;
    }

}