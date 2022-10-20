package com.example.mentalhealth.mood;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping("/")
public class MentalController {

    @Autowired
    private MentalRepository repo;

    @PostMapping("/stressmood")
    public MentalHealth addStressMood(@RequestBody MentalHealth mentalHealth){
        return repo.save(mentalHealth);
    }

    @PostMapping("/updatemood")
    public MentalHealth addMood(@RequestBody MentalHealth mentalHealth){
        return repo.save(mentalHealth);
    }

    @GetMapping("/datamood")
    public List<MentalHealth> getMood(){
        return repo.findAll();
    }

    @PutMapping("/updatemood/{id}")
    public String updateMood(@PathVariable int id, @RequestBody MentalHealth mentalHealth){
        boolean exist = repo.existsById(id);
        if(exist){
            MentalHealth mental = repo.getReferenceById(id);
            mental.setYear(mentalHealth.getYear());
            mental.setDay(mentalHealth.getDay());
            mental.setMonth(mentalHealth.getMonth());
            mental.setMood(mentalHealth.getMood());
            repo.save(mental);
            return "Updated Mood";
        }
        return "Not updated";
    }

    @DeleteMapping("/deletemood/{id}")
    public String deleteMood(@PathVariable int id){
        boolean exist = repo.existsById(id);
        if(exist){
            repo.deleteById(id);
            return "Mood Deleted";
        }
        return "Not deleted";
    }

    @DeleteMapping("/deletemoodall")
    public String deleteMoodAll(){
        repo.deleteAll();
        return "Deleted All";
    }

    @GetMapping("/getRegularStress")
    public long getRegularStress(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findStress();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("regular")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }

    @GetMapping("/getHighStress")
    public long getHighStress(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findStress();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("high")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }

    @GetMapping("/getLowStress")
    public long getLowStress(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findStress();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("low")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }

    @GetMapping("/getNegativeMood")
    public long getNegativeMood(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findMood();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("negative")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }

    @GetMapping("/getPositiveMood")
    public long getPositiveMood(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findMood();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("positive")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }

    @GetMapping("/getNeutralMood")
    public long getNeutralMood(){
        System.out.println("FIRST TEST");
        long numStress = 0;
        int countStress = 0;
        Collection<String> stress = repo.findMood();
        Object[] thisStress = stress.toArray(new Object[stress.size()]);
        String[] stringStress = new String[thisStress.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisStress.length; i ++){
            stringStress[i] = thisStress[i].toString();
            System.out.println(stringStress[i] + " " + stringStress[i].getClass());
        }

        long regularStressSum = 0;

        for(int i = 0; i < thisStress.length; i ++){
            if(thisStress[i].equals("neutral")){
                regularStressSum += 1;
            }
        }
        return regularStressSum;
    }
}
