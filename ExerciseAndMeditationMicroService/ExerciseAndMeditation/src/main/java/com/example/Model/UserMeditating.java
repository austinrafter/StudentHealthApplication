package com.example.Model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "usermeditating")
public class UserMeditating {
    private @Id @GeneratedValue Long userMeditatingId;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "meditation_id")
    Meditation meditation;

    @Column
    LocalDateTime startedAt;

    @Column
    LocalDateTime endedAt;

    public UserMeditating(Meditation meditation, Student student, LocalDateTime started, LocalDateTime ended){
        this.meditation = meditation;
        this.student = student;
        this.startedAt = started;
        this.endedAt = ended;
    }

    public UserMeditating() {

    }

    public LocalDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(LocalDateTime startedAt){
        this.startedAt = startedAt;
    }

    public LocalDateTime getEndedAt() {
        return endedAt;
    }

    public void setEndedAt(LocalDateTime endedAt){
        this.endedAt = endedAt;
    }

    public Long getUserMeditatingId(){
        return userMeditatingId;
    }



}
