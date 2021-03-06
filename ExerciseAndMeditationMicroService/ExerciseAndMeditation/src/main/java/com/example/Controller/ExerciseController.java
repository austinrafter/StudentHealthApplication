package com.example.Controller;

import com.example.Model.Exercise;
import com.example.Model.PassExercise;
import com.example.Model.Student;
import com.example.Model.UserExercising;
import com.example.Repository.ExerciseRepository;
import com.example.Repository.PassExerciseRepository;
import com.example.Repository.UserExercisingRepository;
import com.example.Repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping(path = "/exercises")
public class ExerciseController {

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private UserExercisingRepository userExercisingRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private PassExerciseRepository passExerciseRepository;

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

    @PostMapping("/addStudent")
    public Student addStudent(@RequestBody Student student){
        return studentRepository.save(student);
    }

    @GetMapping("/getStudents")
    public List<Student> getStudents(){
        return studentRepository.findAll();
    }


    @PostMapping("/addtouser")
    public PassExercise addUserExercise(@RequestBody PassExercise passExercise){
        List<Exercise> exercises = exerciseRepository.findByExercisename(passExercise.getExercisename());
        List<Student> students = studentRepository.findByUsername(passExercise.getUsername());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime dateTimeStarted = LocalDateTime.parse(passExercise.getStartedat(), formatter);
        LocalDateTime dateTimeEnded = LocalDateTime.parse(passExercise.getEndedat(), formatter);
        UserExercising userExercising = new UserExercising(exercises.get(0), students.get(0), dateTimeStarted, dateTimeEnded, passExercise.getTotaltime(), passExercise.getCaloriesburned());
        userExercisingRepository.save(userExercising);
       return passExerciseRepository.save(passExercise);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateExerciseForUser(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            UserExercising userExercising = userExercisingRepository.getById(id);
            Exercise exercise = userExercising.getExercise();
            Student student = userExercising.getStudent();
            double metabolicEquivalentScore = exercise.getMetabolic_equivalent_score();
            double studentWeight = student.getWeight();
            double weightInKilograms = studentWeight * 0.453592;
            double caloriesBurned = (metabolicEquivalentScore * 3.5 * weightInKilograms) / 200;
            userExercising.setCalories_burned(caloriesBurned);
            userExercising.setEnded_at(ended);
            userExercisingRepository.save(userExercising);
            Duration totalTime = Duration.between(userExercising.getStarted_at(),userExercising.getEnded_at());
            return new ResponseEntity<>("Calories burned for " + totalTime + " minutes exercised: " + caloriesBurned, HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteExerciseForUser(@PathVariable Long id){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            userExercisingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }


}
