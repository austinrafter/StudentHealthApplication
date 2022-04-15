import com.example.model.User;
import com.example.model.Exercise;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
class HealthConditionPreventsExercise {

    @Id
    Long healthConditionPreventsExerciseId;

    @ManyToOne
    @JoinColumn(name = "exercise_id")
    Exercise exercise;

    @ManyToOne
    @JoinColumn(name = "healthcondition_id")
    HealthCondition healthCondition;


    
}