package com.example.Model;
import jdk.jfr.DataAmount;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;

public class ExerciseMentalComparison{

    private double minutes;
    private String mood;
    private String stress;
    private String date;

    public ExerciseMentalComparison(double minutes, String date,String mood,String stress){
        this.minutes = minutes;
        this.date = date;
        this.mood = mood;
        this.stress = stress;
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

    public String getMood() {
        return mood;
    }

    public String getStress() {
        return stress;
    }

    public void setMood(String mood) {
        this.mood = mood;
    }

    public void setStress(String stress) {
        this.stress = stress;
    }
}