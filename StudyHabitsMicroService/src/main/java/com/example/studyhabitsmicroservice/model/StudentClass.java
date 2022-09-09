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
@Table(name = "Class")
public class StudentClass {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    private String name;
    private Double point;
    private String grade;

    public StudentClass(String name, Double point, String grade){
        this.name = name;
        this.point = point;
        this.grade = grade;
    }
}
