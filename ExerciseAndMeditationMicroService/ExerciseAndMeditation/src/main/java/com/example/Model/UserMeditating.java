package com.example.Model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class UserMeditating {
    @Id
    Long userMeditatingId;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "meditation_id")
    Meditation meditation;

    LocalDateTime startedAt;
    LocalDateTime endedAt;

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
