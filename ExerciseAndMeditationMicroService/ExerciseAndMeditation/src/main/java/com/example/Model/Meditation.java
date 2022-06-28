package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "meditation")
@DataAmount @RequiredArgsConstructor
public class Meditation {
    private @Id @GeneratedValue(strategy = GenerationType.AUTO) Long mediation_id;
    @Column(unique=true, nullable=false) private String meditation_name;
    @Column(nullable=false) private String meditation_type;

    @OneToMany(mappedBy = "meditation")
    Set<UserMeditating> meditations;

    public String getMeditation_name(){
        return meditation_name;
    }

    public void setMeditation_name(String meditationName){
        this.meditation_name = meditationName;
    }

    public String getMeditation_type(){
        return meditation_type;
    }

    public void setMeditation_type(String meditationType){
        this.meditation_type = meditationType;
    }

    public Long getMediation_id(){
        return mediation_id;
    }

}