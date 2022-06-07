package com.example.mentalmicroservice;

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
    private Long id;

    private String mood;
    private String date;


}
