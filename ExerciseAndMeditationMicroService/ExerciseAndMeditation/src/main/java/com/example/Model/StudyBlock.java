package com.example.Model;

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
@Table(name = "StudyBlock")
public class StudyBlock {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;

    private String day;
    private String startTime;
    private String endTime;

    public StudyBlock(String day, String startTime, String endTime){
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }
}
