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
@Table(name = "Class")
public class StudentClass {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;

    private String code;
    private String name;
    private String semester;
    private Double point;
    private String grade;

    public StudentClass(String code, String name, String semester, Double point, String grade){
        this.code = code;
        this.name = name;
        this.semester = semester;
        this.point = point;
        this.grade = grade;
    }
}
