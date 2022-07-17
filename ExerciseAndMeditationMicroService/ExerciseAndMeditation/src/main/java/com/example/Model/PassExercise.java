package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@Entity
@Table(name = "passexercise", schema ="StudentHealth")
@RequiredArgsConstructor
public class PassExercise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "passexerciseid")
    private int passexerciseid;
    //@Column(name = "exercisename", nullable=false)
    private String exercisename;
    //@Column(name = "username", nullable=false)
    private String username;
    //@Column(name = "startedat", nullable=false)
    private String startedat;
    //@Column(name = "exercisename", nullable=false)
    private String endedat;
    //@Column(name = "totaltime", nullable=false)
    private int totaltime;
    //@Column(name = "caloriesburned", nullable=false)
    private double caloriesburned;

    public String getExercisename(){
        return exercisename;
    }

    public String getUsername(){
        return username;
    }

    public String getStartedat(){
        return startedat;
    }

    public String getEndedat(){
        return endedat;
    }

    public int getTotaltime(){
        return totaltime;
    }

    public double getCaloriesburned(){
        return caloriesburned;
    }
}