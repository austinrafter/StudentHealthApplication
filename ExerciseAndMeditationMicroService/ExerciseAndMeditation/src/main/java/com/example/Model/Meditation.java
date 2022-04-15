package com.example.model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "meditation")
@DataAmount @RequiredArgsConstructor
public class Meditation {
    private @Id @GeneratedValue Long meditationId;
    @Column(unique=true, nullable=false) private String meditationName;
    @Column(nullable=false) private String meditationType;

    public String getMeditationName(){
        return meditationName;
    }

    public void setMeditationName(String meditationName){
        this.meditationName = meditationName;
    }

    public String getMeditationType(){
        return meditationType;
    }

    public void setMeditationType(String meditationType){
        this.meditationType = meditationType;
    }

    public Long getMeditationId(){
        return meditationId;
    }

}