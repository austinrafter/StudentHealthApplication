package com.example.Model;
import jdk.jfr.DataAmount;
//import lombok.RequiredArgsConstructor;
import javax.persistence.*;
import java.util.Set;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "passmeditation", schema ="StudentHealth")
@RequiredArgsConstructor
public class PassMeditation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "passmeditationid")
    private int passmeditationid;
    //@Column(name = "exercisename", nullable=false)
    private String meditationname;
    //@Column(name = "username", nullable=false)
    private String username;
    //@Column(name = "startedat", nullable=false)
    private String dateof;
    //@Column(name = "totaltime", nullable=false)
    private int totaltime;
    //@Column(name = "caloriesburned", nullable=false)
    private String soundused;

    public String getMeditationname(){
        return meditationname;
    }

    public String getUsername(){
        return username;
    }

    public String getDateof(){
        return dateof;
    }

    public int getTotaltime(){
        return totaltime;
    }

    public String getSoundused(){
        return soundused;
    }

}