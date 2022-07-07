package com.example.Model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "usermeditating")
public class UserMeditating {
    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int usermeditatingid;

    @ManyToOne
    @JoinColumn(name = "studentid")
    Student student;

    @ManyToOne
    @JoinColumn(name = "meditationid")
    Meditation meditation;

    LocalDateTime startedat;

    LocalDateTime endedat;

    int totaltime;

    public UserMeditating(Meditation meditation, Student student, LocalDateTime started, LocalDateTime ended, int totaltime){
        this.meditation = meditation;
        this.student = student;
        this.startedat = started;
        this.endedat = ended;
        this.totaltime = totaltime;
    }

    public UserMeditating() {

    }

    public LocalDateTime getStarted_at() {
        return startedat;
    }

    public void setStarted_at(LocalDateTime startedAt){
        this.startedat = startedAt;
    }

    public LocalDateTime getEnded_at() {
        return endedat;
    }

    public void setEnded_at(LocalDateTime endedAt){
        this.endedat = endedAt;
    }

    public int getUserMeditatingId(){
        return usermeditatingid;
    }

    public int getTotaltime(){
        return totaltime;
    }



}
