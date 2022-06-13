package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "healthcondition")
@DataAmount @RequiredArgsConstructor
public class HealthCondition {
    private @Id @GeneratedValue Long health_condition_id;
    @Column(unique=true, nullable=false) private String health_condition_name;

    @OneToMany(mappedBy = "healthCondition")
    Set<HealthConditionPreventsExercise> healthConditionPreventsExerciseSet;

    @OneToMany(mappedBy = "healthCondition")
    Set<UserHavingHealthCondition> healthConditions;

    public String getHealth_condition_name(){
        return health_condition_name;
    }

    public void setHealth_condition_name(String healthConditionName){
        this.health_condition_name = healthConditionName;
    }


}