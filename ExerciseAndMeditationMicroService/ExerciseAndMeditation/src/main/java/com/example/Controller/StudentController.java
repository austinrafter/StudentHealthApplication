package com.example.Controller;

import com.example.Model.Exercise;
import com.example.Model.ExerciseChartItem;
import com.example.Model.WeightExerciseChartItem;
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
import java.util.*;

@RestController
@RequestMapping(path = "/students")
public class StudentController {


    @Autowired
    private StudentRepository studentRepository;


    @GetMapping("/getTest")
    public String getTest(){
        return "Connected";
    }

    @PostMapping("/addStudent")
    public Student addStudent(@RequestBody Student student){
        return studentRepository.save(student);
    }

    @GetMapping("/getStudents")
    public List<Student> getStudents(){
        return studentRepository.findAll();
    }

    @PostMapping("/getStudentIfPresent")
    public List<Student> getStudentIfPresent(@RequestBody Student student){
        List<Student>  students =  studentRepository.findByUsername(student.getUser_name());
        if(students != null){
            return students;
        }
        return null;
    }

    @PostMapping("/updateStudentWeight")
    public List<Student> updateUserWeight(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getWeight() != checkIfStudentPresent.get(0).getWeight()){
                checkIfStudentPresent.get(0).setWeight(student.getWeight());
            }
            return checkIfStudentPresent;
        }
        return null;
    }

    @PostMapping("/updateStudentSchool")
    public List<Student> updateUserSchool(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getSchool() != checkIfStudentPresent.get(0).getSchool()){
                checkIfStudentPresent.get(0).setSchool(student.getSchool());
            }
            return checkIfStudentPresent;
        }
        return null;
    }





}
