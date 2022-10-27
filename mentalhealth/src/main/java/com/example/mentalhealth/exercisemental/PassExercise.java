package com.example.mentalhealth.exercisemental;
import jdk.jfr.DataAmount;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "passexercise")
@RequiredArgsConstructor
public class PassExercise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "passexerciseid")
    private int passexerciseid;
    //@Column(name = "exercisename", nullable=false)
    private String exercisename = "test";
    //@Column(name = "username", nullable=false)
    private String username = "test";
    //@Column(name = "startedat", nullable=false)
    private String dateof = "test";
    //@Column(name = "totaltime", nullable=false)
    private int totaltime;
    //@Column(name = "caloriesburned", nullable=false)
    private double caloriesburned = 0;
    private int reps = 0;
    private double weightrepped = 0;

    public int getPassexerciseid(){return passexerciseid;}

    public String getExercisename(){
        return exercisename;
    }

    public String getUsername(){
        return username;
    }

    public String getDateof(){
        return dateof;
    }

    public int getTotaltime(){
        return totaltime;
    }

    public double getCaloriesburned(){
        return caloriesburned;
    }

    public int getReps(){return reps;}

    public double getWeightrepped(){ return weightrepped;}



}