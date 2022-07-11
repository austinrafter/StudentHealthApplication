package com.example.Model;

//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "userexercising")
public class UserExercising {

    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int userexercisingid;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "studentid")
    Student student;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "exerciseid")
    Exercise exercise;

    @Column(name = "startedat", nullable=false)
    LocalDateTime startedat;

    @Column(name = "endedat", nullable=false)
    LocalDateTime endedat;

    @Column(name = "totaltime", nullable=false)
    int totaltime;

    @Column(name = "caloriesburned", nullable=false)
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