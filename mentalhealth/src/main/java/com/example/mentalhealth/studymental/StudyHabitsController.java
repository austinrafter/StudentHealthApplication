package com.example.mentalhealth.studymental;

import com.example.mentalhealth.studymental.Activity;
import com.example.mentalhealth.studymental.ActivityRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.Collection;
import java.util.List;

@RestController
@Slf4j
@Controller
@RequestMapping("/")
public class StudyHabitsController {

    @Autowired
    private ActivityRepo actRepo;

    @PostMapping("/addActivityDuration")
    public Activity addDuration(@RequestBody Activity activity){
        return actRepo.save(activity);
    }

    @GetMapping("/activities")
    public long allActivities() {
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
