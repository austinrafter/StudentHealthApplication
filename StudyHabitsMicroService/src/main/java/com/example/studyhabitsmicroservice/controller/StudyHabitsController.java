package com.example.studyhabitsmicroservice.controller;

import com.example.studyhabitsmicroservice.model.Activity;
import com.example.studyhabitsmicroservice.model.StudentClass;
import com.example.studyhabitsmicroservice.model.StudyBlock;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;

@RestController
@Slf4j
@Controller
@RequestMapping("/study")
public class StudyHabitsController {

    private ActivityRepo actRepo;
    private StudentClassRepo stuClassRepo;
    private StudyBlockRepo stuBlockRepo;

    public StudyHabitsController(ActivityRepo actRepo, StudentClassRepo stuClassRepo, StudyBlockRepo stuBlockRepo){
        this.actRepo = actRepo;
        this.stuClassRepo = stuClassRepo;
        this.stuBlockRepo = stuBlockRepo;
    }

    @GetMapping("/activities")
    public List<Activity> allActivities() {
        List<Activity> activities = actRepo.findAll();
        return activities;
    }

    @GetMapping("/activity/{id}")
    public Activity oneActivity(@PathVariable Long id) {
        Activity activity = actRepo.findById(id) //
                .orElseThrow(() -> new ActivityNotFoundException(id));
        return activity;
    }

    @PutMapping("/activity")
    public String addActivity(@RequestBody Activity newActivity){
        return actRepo.save(newActivity);
    }

    @PutMapping("/activity/{id}")
    public String addActivity(@PathVariable Long id, @RequestBody Activity newActivity){
        Activity updatedActivity = actRepo.findById(id) //
                .map(activity -> {
                    activity.setName(newActivity.getName());
                    return actRepo.save(activity);
                }) //
                .orElseGet(() -> {
                    newActivity.setId(id);
                    return actRepo.save(newActivity);
                });

        return "Activity updated";
    }

    @DeleteMapping("/activity/{id}")
    public String deleteActivity(@PathVariable Long id){
        actRepo.deleteById(id);
        return "Activity deleted";
    }
    @DeleteMapping("/activities")
    public String deleteActivities(){
        actRepo.deleteAll();
        return "All activities deleted";
    }


    @GetMapping("/classes")
    public List<StudentClass> allStudentClasses() {
        List<StudentClass> studentClasses = stuClassRepo.findAll();
        return studentClasses;
    }

    @GetMapping("/class/{id}")
    public StudentClass oneStudentClass(@PathVariable Long id) {
        StudentClass studentClass = stuClassRepo.findById(id) //
                .orElseThrow(() -> new ActivityNotFoundException(id));
        return studentClass;
    }

    @PutMapping("/class")
    public String addStudentClass(@RequestBody StudentClass newClass){
        return stuClassRepo.save(newClass);
    }

    @PutMapping("/class/{id}")
    public String addStudentClass(@PathVariable Long id, @RequestBody StudentClass newClass){
        StudentClass updatedClass = stuClassRepo.findById(id) //
                .map(studentClass -> {
                    studentClass.setName(newClass.getName());
                    studentClass.setPoint(newClass.getPoint());
                    studentClass.setGrade(newClass.getGrade());
                    return stuClassRepo.save(studentClass);
                }) //
                .orElseGet(() -> {
                    newClass.setId(id);
                    return stuClassRepo.save(newClass);
                });

        return "Activity updated";
    }

    @DeleteMapping("/class/{id}")
    public String deleteClass(@PathVariable Long id){
        stuClassRepo.deleteById(id);
        return "Student class deleted";
    }
    @DeleteMapping("/classes")
    public String deleteAllStudentClasses(){
        stuClassRepo.deleteAll();
        return "All student classes deleted";
    }


    @GetMapping("/blocks")
    public List<StudyBlock> allStudyBlocks() {
        List<StudyBlock> blocks = stuBlockRepo.findAll();
        return blocks;
    }

    @GetMapping("/blocks/{id}")
    public StudyBlock oneStudyBlock(@PathVariable Long id) {
        StudyBlock block = stuBlockRepo.findById(id) //
                .orElseThrow(() -> new ActivityNotFoundException(id));
        return block;
    }

    @PutMapping("/block")
    public String addStudyBlock(@RequestBody StudyBlock newBlock){
        return stuBlockRepo.save(newBlock);
    }

    @PutMapping("/block/{id}")
    public String addStudyBlock(@PathVariable Long id, @RequestBody StudyBlock newBlock){
        StudyBlock updatedBlock = stuBlockRepo.findById(id) //
                .map(block -> {
                    block.setDay(newBlock.getDay());
                    block.setStartTime(newBlock.getStartTime());
                    block.setEndTime(newBlock.getEndTime());
                    return stuBlockRepo.save(block);
                }) //
                .orElseGet(() -> {
                    newBlock.setId(id);
                    return stuBlockRepo.save(newBlock);
                });

        return "Study block updated";
    }

    @DeleteMapping("/block/{id}")
    public String deleteStudyBlock(@PathVariable Long id){
        stuBlockRepo.deleteById(id);
        return "Study block deleted";
    }
    @DeleteMapping("/blocks")
    public String deleteAllStudyBlocks(){
        stuBlockRepo.deleteAll();
        return "All study blocks deleted";
    }
}
