package com.example.mentalhealth.mood;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Data
@RequiredArgsConstructor
@Entity
@Table(name = "MENTAL_HEALTH")
public class MentalHealth {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;
    private String userName;

    //Values: Sad, Neutral, Happy
    private String mood;
    
    private String month;
    private String year;
    private String day;
}
