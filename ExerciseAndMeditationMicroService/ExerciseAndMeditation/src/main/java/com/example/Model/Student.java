package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import lombok.Data;

import javax.persistence.*;
import java.util.*;

@Data
@Entity
@Table(name = "student", schema ="StudentHealth")
@RequiredArgsConstructor
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "student_id")
    private int student_id;
    @Column(name = "user_name",unique=true, nullable=false)
    private String user_name;
    @Column(name = "email",unique=true, nullable=false)
    private String email;
    @Column(name = "school", nullable=false)
    private String school;
    @Column(name = "weight", nullable=false)
    private double weight;

    @OneToMany(mappedBy = "student")
    Set<UserExercising> exercises;

    @OneToMany(mappedBy = "student")
    Set<UserMeditating> meditations;

    public String getUser_name(){
        return user_name;
    }

    //public String getPass_word(){
        //return pass_word;
    //}

    //public void setPass_word(String passWord){
       // this.pass_word = passWord;
    //}

    public int getStudent_id(){
        return student_id;
    }

    public String getSchool(){
        return school;
    }

    public void setSchool(String school){
        this.school = school;
    }

    public double getWeight(){
        return weight;
    }

    public void setWeight(double weight){
        this.weight = weight;
    }

}
