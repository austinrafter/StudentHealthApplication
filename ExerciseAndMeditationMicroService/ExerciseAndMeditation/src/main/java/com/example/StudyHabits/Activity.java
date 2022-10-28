package com.example.StudyHabits;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import java.util.Date;

@Data
@Entity
@RequiredArgsConstructor
@Table(name = "activity")
public class Activity {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    private String classCode = "test";
    private String semester = "test";
    private long duration;

    public Activity(String classCode, String semester, long duration){
        this.classCode = classCode;
        this.semester = semester;
        this.duration = duration;
    }

    public long getDuration() {
        return duration;
    }

    public String getClassCode() {
        return classCode;
    }

    public String getSemester() {
        return semester;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }
}
