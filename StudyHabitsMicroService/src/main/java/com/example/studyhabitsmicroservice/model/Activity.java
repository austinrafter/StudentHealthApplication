package com.example.studyhabitsmicroservice.model;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import java.util.Date;

@Data
@Entity
@RequiredArgsConstructor
@Table(name = "Activity")
public class Activity {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    private String classCode;
    private String semester;
    private long duration;

    public Activity(String classCode, Stirng semester, long duration){
        this.classCode = classCode;
        this.semester = semester;
        this.duration = duration;
    }
}
