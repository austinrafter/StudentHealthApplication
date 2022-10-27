package com.example.mentalhealth.exercisemental;

import com.example.mentalhealth.exercisemental.PassMeditationRepository;
import com.example.mentalhealth.studymental.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping(path = "/")
public class MeditationController {

    @Autowired
    private PassMeditationRepository passMeditationRepository;

    @PostMapping("/addMeditationDuration")
    public PassMeditation addMeditationDuration(@RequestBody PassMeditation passMeditation){
        return passMeditationRepository.save(passMeditation);
    }

    @GetMapping("/meditation")
    public int getUserTimedExercises() {
        int time = 0;
        System.out.println("FIRST TEST");
        Collection<Integer> meditationTime = passMeditationRepository.findMeditationCount();
        Object[] thisMeditationAmount = meditationTime.toArray(new Object[meditationTime.size()]);
        int[] intTime = new int[thisMeditationAmount.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisMeditationAmount.length; i ++){
            intTime[i] = (Integer) thisMeditationAmount[i];
            System.out.println(intTime[i]);
            time += intTime[i];
        }
        return time;
    }
}
