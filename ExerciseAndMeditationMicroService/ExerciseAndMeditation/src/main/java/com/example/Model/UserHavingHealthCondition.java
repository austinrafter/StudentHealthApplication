package com.example.Model;
import com.example.Model.Exercise;
import com.example.Model.HealthCondition;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
public class UserHavingHealthCondition {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    Long userHavingHealthConditionId;

    @ManyToOne
    @JoinColumn(name = "student_id")
    Student student;

    @ManyToOne
    @JoinColumn(name = "healthcondition_id")
    HealthCondition healthCondition;
}
