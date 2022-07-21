package com.example.Model;
import com.example.Model.Exercise;
import com.example.Model.HealthCondition;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
public class UserHavingHealthCondition {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long userHavingHealthConditionId;

    @ManyToOne
    @JoinColumn(name = "studentid")
    Student student;

    @ManyToOne
    @JoinColumn(name = "healthconditionid")
    HealthCondition healthCondition;
}
