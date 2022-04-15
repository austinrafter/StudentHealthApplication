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
}