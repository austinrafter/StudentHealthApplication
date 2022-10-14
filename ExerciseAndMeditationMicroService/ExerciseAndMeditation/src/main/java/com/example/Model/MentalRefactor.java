package com.example.Model;


import lombok.Data;
import lombok.RequiredArgsConstructor;

public class MentalRefactor {
    //Values: sad = 2, neutral = 1, happy = 0
    private String mood;
    //Values: low = 2, medium = 1, high = 0
    private String stress;
    private int moodTotal = 0;
    private int stressTotal = 0;
    private int dayTotal = 1;
    private String date;

    public MentalRefactor(String mood, String stress, String date, int moodTotal, int stressTotal){
        this.mood = mood;
        this.stress = stress;
        this.date = date;
        this.moodTotal = moodTotal;
        this.stressTotal = stressTotal;
    }

    public String getStress() {
        return stress;
    }

    public String getMood() {
        return mood;
    }

    public String getDate() {
        return date;
    }

    public int getDayTotal() {
        return dayTotal;
    }

    public int getMoodTotal() {
        return moodTotal;
    }

    public int getStressTotal() {
        return stressTotal;
    }

    public void setStress(String stress) {
        this.stress = stress;
    }

    public void setMood(String mood) {
        this.mood = mood;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setDayTotal(int dayTotal) {
        this.dayTotal = dayTotal;
    }

    public void setMoodTotal(int moodTotal) {
        this.moodTotal = moodTotal;
    }

    public void setStressTotal(int stressTotal) {
        this.stressTotal = stressTotal;
    }
}