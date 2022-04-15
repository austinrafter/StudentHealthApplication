package com.example.model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "user")
@DataAmount @RequiredArgsConstructor
public class User {
    private @Id @GeneratedValue Long userId;
    @Column(unique=true, nullable=false) private String userName;
    @Column(unique=true, nullable=false) private String email;
    @Column(nullable=false) private String passWord;
    @Column(nullable=false) private String school;
    @Column(nullable=false) private int weight;
    @Column(nullable=false) private boolean authenticatedUser;

    @OneToMany(mappedBy = "user")
    Set<UserExercising> exercises;


    public String getUserName(){
        return userName;
    }

    public String getPassWord(){
        return passWord;
    }

    public void setPassWord(String passWord){
        this.passWord = passWord;
    }

    public Long getUserId(){
        return userId;
    }

    public boolean isAuthenticatedUser() {
        return authenticatedUser;
    }
    
    public String getSchool(){
        return school;
    }
    
    public void setSchool(String school){
        this.school = school;
    }
    
    public int getWeight(){
        return weight;
    }
    
    public void setWeight(int weight){
        this.weight = weight;
    }

    public void setAuthenticatedUser(Boolean authenticatedUser){
        this.authenticatedUser = authenticatedUser;
    }
}
