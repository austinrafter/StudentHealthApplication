package com.example.Model;

import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "userexercising")
public class UserExercising {

    private @Id @GeneratedValue Long userExercisingId;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "exercise_id")
    Exercise exercise;

    @Column
    LocalDateTime startedAt;
    @Column
    LocalDateTime endedAt;
    @Column
    double caloriesBurned;

    public UserExercising(Exercise exercise, Student student, LocalDateTime startedAt, LocalDateTime endedAt){
        this.exercise = exercise;
        this.student = student;
        this.startedAt = startedAt;
        this.endedAt = endedAt;
    }

    public UserExercising() {

    }

    public Exercise getExercise(){
        return exercise;
    }

    public Student getStudent(){
        return student;
    }

    public double getCaloriesBurned(){
        return caloriesBurned;
    }

    public LocalDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(LocalDateTime startedAt){
        this.startedAt = startedAt;
    }

    public LocalDateTime getEndedAt() {
        return endedAt;
    }

    public void setEndedAt(LocalDateTime endedAt){
        this.endedAt = endedAt;
    }

    public Long getUserExercisingId(){
        return userExercisingId;
    }

    public void setCaloriesBurned(double caloriesBurned){
        this.caloriesBurned = caloriesBurned;
    }
}