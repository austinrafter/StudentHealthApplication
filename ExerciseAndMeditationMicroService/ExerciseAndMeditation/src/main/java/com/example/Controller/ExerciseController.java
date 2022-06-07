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

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping(path = "/exercises")
public class ExerciseController {

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private UserExercisingRepository userExercisingRepository;

    @GetMapping
    public List<Exercise> getExercises(){
        return exerciseRepository.findAll();
    }

    @GetMapping
    public List<UserExercising> getUserExercises(){
        return userExercisingRepository.findAll();
    }

    @PostMapping("/add")
    public Exercise addExercise(@RequestBody Exercise exercise){
        return exerciseRepository.save(exercise);
    }

    @PostMapping("/addtouser")
    public UserExercising addUserExercise(@RequestBody Exercise exercise, @RequestBody Student student, @RequestBody LocalDateTime start){
        return userExercisingRepository.save(exercise, student, start, start);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateExerciseForUser(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            UserExercising userExercising = userExercisingRepository.getById(id);
            userExercising.setEndedAt(ended);
            userExercisingRepository.save(userExercising);
            return new ResponseEntity<>("Finished the exercise", HttpStatus.OK);
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
