package com.example.Model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "usermeditating")
public class UserMeditating {
    private @Id @GeneratedValue(strategy = GenerationType.AUTO) int user_meditating_id;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "meditation_id")
    Meditation meditation;

    @Column
    LocalDateTime started_at;

    @Column
    LocalDateTime ended_at;

    public UserMeditating(Meditation meditation, Student student, LocalDateTime started, LocalDateTime ended){
        this.meditation = meditation;
        this.student = student;
        this.started_at = started;
        this.ended_at = ended;
    }

    public UserMeditating() {

    }

    public LocalDateTime getStarted_at() {
        return started_at;
    }

    public void setStarted_at(LocalDateTime startedAt){
        this.started_at = startedAt;
    }

    public LocalDateTime getEnded_at() {
        return ended_at;
    }

    public void setEnded_at(LocalDateTime endedAt){
        this.ended_at = endedAt;
    }

    public int getUserMeditatingId(){
        return user_meditating_id;
    }



}
