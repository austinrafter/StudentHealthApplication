import com.example.model.User;
import com.example.model.Exercise;
import jdk.jfr.DataAmount;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
class UserExercising {

    @Id
    Long userExercisingId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

    @ManyToOne
    @JoinColumn(name = "exercise_id")
    Exercise exercise;

    LocalDateTime startedAt;
    LocalDateTime endedAt;

    int caloriesBurned;

    // additional properties
    // standard constructors, getters, and setters

    public int getCaloriesBurned(){
        return userName;
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

    public void setEndedAt(endedAt){
        this.endedAt = endedAt;
    }

    public Long getUserExercisingId(){
        return userExercisingId;
    }
}