package com.example.mentalmicroservice;

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

    @PostMapping("/update/{date}")
    public String updateMood(@PathVariable Long id){
        boolean exist = repo.existsById(id);

        if(exist){
            
        }
    }
}
