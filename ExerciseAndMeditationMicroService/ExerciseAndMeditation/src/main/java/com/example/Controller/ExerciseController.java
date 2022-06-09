package com.example.Controller;

import com.example.Model.Exercise;
import com.example.Model.Student;
import com.example.Model.UserExercising;
import com.example.Repository.ExerciseRepository;
import com.example.Repository.UserExercisingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping(path = "/exercises")
public class ExerciseController {

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private UserExercisingRepository userExercisingRepository;

    @GetMapping("/getExercises")
    public List<Exercise> getExercises(){
        return exerciseRepository.findAll();
    }

    @GetMapping("/getUserExercises")
    public List<UserExercising> getUserExercises(){
        return userExercisingRepository.findAll();
    }

    @GetMapping("/getTest")
    public String getTest(){
        return "Connected";
    }

    @PostMapping("/add")
    public Exercise addExercise(@RequestBody Exercise exercise){
        return exerciseRepository.save(exercise);
    }

    @PostMapping("/addtouser")
    public UserExercising addUserExercise(@RequestBody Exercise exercise, @RequestBody Student student, @RequestBody LocalDateTime start){
        return userExercisingRepository.save(new UserExercising(exercise, student, start, start));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateExerciseForUser(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            UserExercising userExercising = userExercisingRepository.getById(id);
            Exercise exercise = userExercising.getExercise();
            Student student = userExercising.getStudent();
            double metabolicEquivalentScore = exercise.getMetabolicEquivalentScore();
            double studentWeight = student.getWeight();
            double weightInKilograms = studentWeight * 0.453592;
            double caloriesBurned = (metabolicEquivalentScore * 3.5 * weightInKilograms) / 200;
            userExercising.setCaloriesBurned(caloriesBurned);
            userExercising.setEndedAt(ended);
            userExercisingRepository.save(userExercising);
            Duration totalTime = Duration.between(userExercising.getStartedAt(),userExercising.getEndedAt());
            return new ResponseEntity<>("Calories burned for " + totalTime + " minutes exercised: " + caloriesBurned, HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            userExercisingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }


}
