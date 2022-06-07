package com.example.mentalmicroservice.mood;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class MentalController {

    @Autowired
    private MentalRepository repo;

    @PostMapping("/update")
    public MentalHealth updateMood(@RequestBody MentalHealth mentalHealth){
        return repo.save(mentalHealth);
    }

    @GetMapping
    public List<MentalHealth> getMental(){
        return repo.findAll();
    }

    @PostMapping("/update/{id}")
    public String updateMood(@PathVariable int id){
        boolean exist = repo.existsById(id);
        if(exist){
            MentalHealth mental = repo.getById(id);
            repo.save(mental);
            return "Updated Mood";
        }
        return "Updated";
    }

    @DeleteMapping("/delete/{id}")
    public String deleteMood(@PathVariable int id){
        boolean exist = repo.existsById(id);
        if(exist){
            repo.deleteById(id);
            return "Mood Deleted";
        }
        return "Deleted";
    }
}
