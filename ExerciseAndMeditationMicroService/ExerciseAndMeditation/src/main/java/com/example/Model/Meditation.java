package com.example.Model;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;

@Data
@Entity
@Table(name = "meditation", schema ="StudentHealth")
@RequiredArgsConstructor
public class Meditation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "meditationid") private int meditationid;
    @Column(name = "meditationname",unique=true, nullable=false) private String meditationname;
    @Column(name = "meditationtype",nullable=false) private String meditationtype;
    @Column(name = "audiolink",unique=true, nullable=false) private String audiolink;
    @Column(name = "imagelink") private String imagelink;

    @OneToMany(mappedBy = "meditation")
    Set<UserMeditating> meditations;

    public String getMeditationname(){
        return meditationname;
    }

    public void setMeditationname(String meditationName){
        this.meditationname = meditationName;
    }

    public String getMeditationtype(){
        return meditationtype;
    }

    public void setMeditationtype(String meditationType){
        this.meditationtype = meditationType;
    }

    public int getMeditationid(){
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