package com.example.mentalhealth.mood;

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

    @GetMapping("/data")
    public List<MentalHealth> getMental(){
        return repo.findAll();
    }

    @PutMapping("/update/{id}")
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
