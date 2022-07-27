package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@Entity
@Table(name = "exercise", schema ="StudentHealth")
@RequiredArgsConstructor
public class Exercise {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "exerciseid")private int exerciseid;
    @Column(name = "exercisename",unique=true, nullable=false) private String exercisename;
    @Column(name = "exercisetype",nullable=false) private String exercisetype;
    @Column(name = "metabolicequivalentscore",nullable=false) private double metabolicequivalentscore;
    @Column(name = "exerciseimage") private String exerciseimage;

    @OneToMany(mappedBy = "exercise")
    Set<UserExercising> exercises;

    public String getExercise_name(){
        return exercisename;
    }
    
    public void setExercise_name(String exerciseName){
        this.exercisename = exerciseName;
    }

    public String getExercise_type(){
        return exercisetype;
    }

    public void setExercise_type(String exerciseType){
        this.exercisetype = exerciseType;
    }
    
    public double getMetabolic_equivalent_score(){
        return metabolicequivalentscore;
    }
    
    public void setMetabolic_equivalent_score(int metabolicEquivalentScore){
        this.metabolicequivalentscore = metabolicEquivalentScore;
    }

    public int getExercise_id(){
        return exerciseid;
    }

    public String getExerciseimage(){
        return exerciseimage;
    }

    public void setExerciseimage(String imagelink){
        this.exerciseimage = exerciseimage;
    }

}