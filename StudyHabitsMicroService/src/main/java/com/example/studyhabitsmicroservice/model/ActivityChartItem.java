package com.example.studyhabitsmicroservice.model;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

@Data
@Entity
@RequiredArgsConstructor
@Table(name = "ActivityChartItem")
public class ActivityChartItem{

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    private double minutes;
    private String classCode;

    public ActivityChartItem(double minutes, String classCode){
        this.minutes = minutes;
        this.classCode = classCode;
    }
}