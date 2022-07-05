package com.example.Model;

//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "userexercising")
public class UserExercising {

    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int user_exercising_id;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "exercise_id")
    Exercise exercise;

    LocalDateTime started_at;

    LocalDateTime ended_at;

    double calories_burned;

    public UserExercising(Exercise exercise, Student student, LocalDateTime startedAt, LocalDateTime endedAt){
        this.exercise = exercise;
        this.student = student;
        this.started_at = startedAt;
        this.ended_at = endedAt;
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
        return calories_burned;
    }

    public LocalDateTime getStarted_at() {
        return started_at;
    }

    public void setStarted_at(LocalDateTime startedAt){
        this.started_at = startedAt;
    }

    public LocalDateTime getEnded_at() {
        return ended_at;
    }

    public void setEnded_at(LocalDateTime endedAt){
        this.ended_at = endedAt;
    }

    public int getUser_exercising_id(){
        return user_exercising_id;
    }

    public void setCalories_burned(double caloriesBurned){
        this.calories_burned = caloriesBurned;
    }
}