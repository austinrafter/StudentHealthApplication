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
    @Column(unique=true, nullable=false) private String audiolink;
    @Column() private String imagelink;

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

    public String getAudiolink(){
        return audiolink;
    }

    public void setAudiolink(String audiolink){
        this.audiolink = audiolink;
    }

    public String getImagelink(){
        return imagelink;
    }

    public void setImagelink(String imagelink){
        this.imagelink = imagelink;
    }

}