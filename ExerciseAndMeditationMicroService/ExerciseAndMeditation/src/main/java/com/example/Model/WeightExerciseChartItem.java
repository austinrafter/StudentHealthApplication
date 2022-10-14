package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;

public class WeightExerciseChartItem {

    private String exercise;

    private double weight;

    private int reps;

    private String date;

    public WeightExerciseChartItem(String exercise, double weight, int reps, String date){
        this.exercise = exercise;
        this.weight = weight;
        this.reps = reps;
        this.date = date;
    }

    public int getReps() {
        return reps;
    }

    public double getWeight() {
        return weight;
    }

    public String getDate() {
        return date;
    }

    public String getExercise() {
        return exercise;
    }

    public void setExercise(String exercise) {
        this.exercise = exercise;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setReps(int reps) {
        this.reps = reps;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
}