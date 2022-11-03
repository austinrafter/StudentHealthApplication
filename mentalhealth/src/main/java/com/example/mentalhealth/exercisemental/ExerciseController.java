package com.example.mentalhealth.exercisemental;
import com.example.mentalhealth.exercisemental.PassExercise;

import com.example.mentalhealth.exercisemental.PassMeditationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping(path = "/")
public class ExerciseController {

    @Autowired
    private PassExerciseRepository passExerciseRepository;

    @PostMapping("/addExerciseDuration")
    public PassExercise addExerciseDuration(@RequestBody PassExercise passExercise){
        return passExerciseRepository.save(passExercise);
    }

    @GetMapping("/exercise")
    public int getExerciseTime(){
        int time = 0;
        System.out.println("FIRST TEST");
        Collection<Integer> exerciseTime = passExerciseRepository.findExerciseCount();
        Object[] thisExerciseAmount = exerciseTime.toArray(new Object[exerciseTime.size()]);
        int[] intTime = new int[thisExerciseAmount.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisExerciseAmount.length; i ++){
            intTime[i] = (Integer) thisExerciseAmount[i];
            System.out.println(intTime[i]);
            time += intTime[i];
        }
        return time;
    }
}
