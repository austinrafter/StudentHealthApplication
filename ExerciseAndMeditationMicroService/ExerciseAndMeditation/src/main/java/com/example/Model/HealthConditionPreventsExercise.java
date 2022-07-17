package com.example.Model;
import com.example.Model.Exercise;
import com.example.Model.HealthCondition;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
class HealthConditionPreventsExercise {

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    Long healthConditionPreventsExerciseId;

    @ManyToOne
    @JoinColumn(name = "exerciseid")
    Exercise exercise;

    @ManyToOne
    @JoinColumn(name = "healthconditionid")
    HealthCondition healthCondition;


    
}