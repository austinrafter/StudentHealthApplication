package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "exercise", schema ="StudentHealth")
@DataAmount
//@RequiredArgsConstructor
public class Exercise {
    @Id @GeneratedValue @Column(name = "exercise_id")private Long exercise_id;
    @Column(name = "exercise_name",unique=true, nullable=false) private String exercise_name;
    @Column(name = "exercise_type",nullable=false) private String exercise_type;
    @Column(name = "metabolic_equivalent_score",nullable=false) private double metabolic_equivalent_score;

    @OneToMany(mappedBy = "exercise")
    Set<UserExercising> exercises;

    @OneToMany(mappedBy = "exercise")
    Set<HealthConditionPreventsExercise> healthConditionPreventsExerciseSet;

    public String getExercise_name(){
        return exercise_name;
    }
    
    public void setExercise_name(String exerciseName){
        this.exercise_name = exerciseName;
    }

    public String getExercise_type(){
        return exercise_type;
    }

    public void setExercise_type(String exerciseType){
        this.exercise_type = exerciseType;
    }
    
    public double getMetabolic_equivalent_score(){
        return metabolic_equivalent_score;
    }
    
    public void setMetabolic_equivalent_score(int metabolicEquivalentScore){
        this.metabolic_equivalent_score = metabolicEquivalentScore;
    }

    public Long getExercise_id(){
        return exercise_id;
    }

}