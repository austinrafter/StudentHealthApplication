package com.example.mentalmicroservice.mood;

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
    private String mood;
    private String date;
}
