package com.example.Model;
import jdk.jfr.DataAmount;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;

public class ExerciseChartItem{

    private double minutes;
    private String date;
    private double calories;

    public ExerciseChartItem(double minutes, String date, double calories){
        this.minutes = minutes;
        this.date = date;
        this.calories = calories;
    }


    public String getDate() {
        return date;
    }

    public double getMinutes() {
        return minutes;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setMinutes(double minutes) {
        this.minutes = minutes;
    }

    public double getCalories() {
        return calories;
    }

    public void setCalories(double calories) {
        this.calories = calories;
    }
}