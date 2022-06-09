package com.example.Model;
import com.example.Model.UserExercising;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "user")
@DataAmount
//@RequiredArgsConstructor
public class User {
    private @Id @GeneratedValue Long userId;
    @Column(unique=true, nullable=false) private String userName;
    @Column(unique=true, nullable=false) private String email;
    @Column(nullable=false) private String passWord;
    @Column(nullable=false) private String school;
    @Column(nullable=false) private double weight;
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
    
    public double getWeight(){
        return weight;
    }
    
    public void setWeight(double weight){
        this.weight = weight;
    }

    public void setAuthenticatedUser(Boolean authenticatedUser){
        this.authenticatedUser = authenticatedUser;
    }
}
