package com.example.Repository;

import com.example.Model.Exercise;
import com.example.Model.Student;
import com.example.Model.UserExercising;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserExercisingRepository extends JpaRepository<UserExercising, Long> {

    UserExercising getByUserExercisingId(long userExercsisingId);

    List<UserExercising> getByStudent(Student student);

    List<UserExercising> getByExercise(Exercise exercise);
}
