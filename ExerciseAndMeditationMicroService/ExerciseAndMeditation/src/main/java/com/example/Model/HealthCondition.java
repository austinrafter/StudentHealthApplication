package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "healthcondition")
@DataAmount @RequiredArgsConstructor
public class HealthCondition {
    private @Id @GeneratedValue(strategy = GenerationType.IDENTITY) int healthconditionid;
    @Column(unique=true, nullable=false) private String healthconditionname;

    @OneToMany(mappedBy = "healthCondition")
    Set<HealthConditionPreventsExercise> healthConditionPreventsExerciseSet;

    @OneToMany(mappedBy = "healthCondition")
    Set<UserHavingHealthCondition> healthConditions;

    public String getHealth_condition_name(){
        return healthconditionname;
    }

    public void setHealth_condition_name(String healthConditionName){
        this.healthconditionname = healthConditionName;
    }


}