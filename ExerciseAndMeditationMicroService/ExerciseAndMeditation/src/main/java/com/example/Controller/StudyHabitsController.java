package com.example.Controller;

import com.example.Model.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.ArrayList;

import java.util.Collection;

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

    @PostMapping("/activity")
    public Activity addActivity(@RequestBody Activity newActivity){
        return actRepo.save(newActivity);
    }

    @PutMapping("/activity/{id}")
    public String addActivity(@PathVariable Long id, @RequestBody Activity newActivity){
        Activity updatedActivity = actRepo.findById(id) //
                .map(activity -> {
                    activity.setDuration(newActivity.getDuration());
                    activity.setClassCode(newActivity.getClassCode());
                    activity.setSemester(newActivity.getSemester());
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

    @PostMapping("/class")
    public StudentClass addStudentClass(@RequestBody StudentClass newClass){
        return stuClassRepo.save(newClass);
    }

    @PutMapping("/class/{id}")
    public String addStudentClass(@PathVariable Long id, @RequestBody StudentClass newClass){
        StudentClass updatedClass = stuClassRepo.findById(id) //
                .map(studentClass -> {
                    studentClass.setCode(newClass.getCode());
                    studentClass.setName(newClass.getName());
                    studentClass.setSemester(newClass.getSemester());
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

    @PostMapping("/block")
    public StudyBlock addStudyBlock(@RequestBody StudyBlock newBlock){
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

    @GetMapping("/ActivityChartItems")
    public List<ActivityChartItem> getUserTimedExercises(){
        List<ActivityChartItem> activityChartItemArrayList = new ArrayList<>();
        List<Activity> activities = actRepo.findAll();
        boolean classCodeMatched = false;

        for(Activity activity: activities){
            ActivityChartItem item = new ActivityChartItem(((double)activity.getDuration()/60) , activity.getClassCode());
            if(activityChartItemArrayList.size() == 0){
                activityChartItemArrayList.add(item);
            }
            for(ActivityChartItem curItem : activityChartItemArrayList){
                if((item.getClassCode().equals(curItem.getClassCode()))){
                    curItem.setMinutes(item.getMinutes() + curItem.getMinutes());
                    classCodeMatched = true;
                }
            }
            if(!classCodeMatched){
                activityChartItemArrayList.add(item);
            }else{
                classCodeMatched = false;
            }
        }
        for (ActivityChartItem curItem : activityChartItemArrayList){
            System.out.println(curItem.getMinutes());
        }
        return activityChartItemArrayList;
    }

    @GetMapping("/activitiessummed")
    public long allActivitiesSummed() {
        long time = 0;
        System.out.println("FIRST TEST");
        Collection<Long> studyTime = actRepo.findStudyAmount();
        System.out.println(actRepo.findStudyAmount());
        System.out.println("collection length," + studyTime.size() + " type: " + studyTime.getClass());
        Object[] studyAmount = studyTime.toArray(new Object[studyTime.size()]);
        System.out.println("object[] length," + studyAmount.length + " type: " + studyAmount.getClass());
        long[] longTime = new long[studyAmount.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < studyAmount.length; i ++){
            longTime[i] = (Long) studyAmount[i];
            time += longTime[i];
            System.out.println(time);
        }
        return time;
    }
}
