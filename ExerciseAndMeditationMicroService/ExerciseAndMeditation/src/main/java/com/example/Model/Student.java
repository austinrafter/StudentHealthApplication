package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "student")
@DataAmount
//@RequiredArgsConstructor
public class Student {
    private @Id @GeneratedValue Long student_id;
    @Column(unique=true, nullable=false) private String user_name;
    @Column(unique=true, nullable=false) private String email;
    //@Column(nullable=false) private String pass_word;
    @Column(nullable=false) private String school;
    @Column(nullable=false) private double weight;

    @OneToMany(mappedBy = "student")
    Set<UserExercising> exercises;

    @OneToMany(mappedBy = "student")
    Set<UserMeditating> meditations;

    @OneToMany(mappedBy = "student")
    Set<UserHavingHealthCondition> healthConditions;


    public String getUser_name(){
        return user_name;
    }

    //public String getPass_word(){
        //return pass_word;
    //}

    //public void setPass_word(String passWord){
       // this.pass_word = passWord;
    //}

    public Long getStudent_id(){
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
