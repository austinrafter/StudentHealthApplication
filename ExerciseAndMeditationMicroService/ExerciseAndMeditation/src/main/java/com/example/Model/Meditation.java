package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "meditation")
@DataAmount @RequiredArgsConstructor
public class Meditation {
    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int meditationid;
    @Column(unique=true, nullable=false) private String meditationname;
    @Column(nullable=false) private String meditationtype;

    @OneToMany(mappedBy = "meditation")
    Set<UserMeditating> meditations;

    public String getMeditation_name(){
        return meditationname;
    }

    public void setMeditation_name(String meditationName){
        this.meditationname = meditationName;
    }

    public String getMeditation_type(){
        return meditationtype;
    }

    public void setMeditation_type(String meditationType){
        this.meditationtype = meditationType;
    }

    public int getMeditation_id(){
        return meditationid;
    }

}