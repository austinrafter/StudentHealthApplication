package com.example.model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "healthcondition")
@DataAmount @RequiredArgsConstructor
public class HealthCondition {
    private @Id @GeneratedValue Long healthConditionId;
    @Column(unique=true, nullable=false) private String healthConditionName;

    @OneToMany(mappedBy = "healthcondition")
    Set<HealthConditionPreventsExercise> healthConditionPreventsExerciseSet;

    public String getHealthConditionName(){
        return healthConditionName;
    }

    public void setHealthConditionName(String healthConditionName){
        this.healthConditionName = healthConditionName;
    }


}