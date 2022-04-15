package com.example.studyhabitsmicroservice.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;

import java.util.Date;

@Document("activity")
public class Activity {
    @Id
    private String id;

    @Getter @Setter
    private String name;

    @CreatedDate
    @Getter @Setter
    private Date start;

    @LastModifiedDate
    @Getter @Setter
    private Date end;

    public Activity(String name){
        this.name = name;
    }
}
