package com.example.studyhabitsmicroservice.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;

@Document("class")
public class StudentClass {
    @Id
    private String id;

    @Getter @Setter
    private String name;
    @Getter @Setter
    private Double point;
    @Getter @Setter
    private String grade;

    public StudentClass(String name, Double point, String grade){
        this.name = name;
        this.point = point;
        this.grade = grade;
    }
}
