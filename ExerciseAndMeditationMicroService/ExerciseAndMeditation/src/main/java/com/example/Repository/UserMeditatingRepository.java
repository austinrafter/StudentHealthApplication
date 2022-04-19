package com.example.Repository;

import com.example.Model.Meditation;
import com.example.Model.Student;
import com.example.Model.UserMeditating;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserMeditatingRepository extends JpaRepository<UserMeditating, Long> {
    UserMeditating userMeditating(long userMeditatinId);
    List<UserMeditating> getByStudent(Student student);
    List<UserMeditating> getByStudent(Meditation meditation);

}
