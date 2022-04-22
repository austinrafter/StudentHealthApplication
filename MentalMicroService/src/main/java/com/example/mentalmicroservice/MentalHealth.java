package com.example.mentalmicroservice;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@RequiredArgsConstructor
@Entity
public class MentalHealth {

    /**
     *
     */
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

}
