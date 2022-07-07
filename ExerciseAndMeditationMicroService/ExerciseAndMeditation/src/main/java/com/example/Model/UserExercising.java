package com.example.Model;

//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "userexercising")
public class UserExercising {

    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int userexercisingid;

    @ManyToOne
    @JoinColumn(name = "studentid")
    Student student;

    @ManyToOne
    @JoinColumn(name = "exerciseid")
    Exercise exercise;

    LocalDateTime startedat;

    LocalDateTime endedat;

    int totaltime;

    double caloriesburned;

    public UserExercising(Exercise exercise, Student student, LocalDateTime startedAt, LocalDateTime endedAt, int totalTime, double caloriesBurned){
        this.exercise = exercise;
        this.student = student;
        this.startedat = startedAt;
        this.endedat = endedAt;
        this.totaltime = totalTime;
        this.caloriesburned = caloriesBurned;
    }

    public UserExercising() {

    }

    public Exercise getExercise(){
        return exercise;
    }

    public Student getStudent(){
        return student;
    }

    public double getCalories_burned(){
        return caloriesburned;
    }

    public LocalDateTime getStarted_at() {
        return startedat;
    }

    public void setStarted_at(LocalDateTime startedAt){
        this.startedat = startedAt;
    }

    public LocalDateTime getEnded_at() {
        return endedat;
    }

    public void setEnded_at(LocalDateTime endedAt){
        this.endedat = endedAt;
    }

    public int getUser_exercising_id(){
        return userexercisingid;
    }

    public void setCalories_burned(double caloriesBurned){
        this.caloriesburned = caloriesBurned;
    }
}