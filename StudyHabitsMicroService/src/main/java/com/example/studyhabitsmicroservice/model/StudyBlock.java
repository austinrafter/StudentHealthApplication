package com.example.studyhabitsmicroservice.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;

@Document
public class StudyBlock {
    @Id
    private String id;

    @Getter @Setter
    private String day;
    @Getter @Setter
    private String startTime;
    @Getter @Setter
    private String endTime;

    public StudyBlock(String day, String startTime, String endTime){
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }
}
